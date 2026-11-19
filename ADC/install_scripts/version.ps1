param([string]$OutputPath, [string]$ExportPath)
$ErrorActionPreference = 'Stop'
try {
    $root = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
    function Invoke-Git {
        $result = & git -C $root @args
        if ($LASTEXITCODE -ne 0) { throw "Git failed: $args" }
        return $result
    }
    if (Test-Path -LiteralPath (Join-Path $root '.git')) {
        if (Invoke-Git rev-parse --show-prefix) { throw 'Unexpected Git repository root.' }
        if ((Invoke-Git rev-parse --is-shallow-repository) -ne 'false') { throw 'Incomplete (shallow) Git history. Fetch the complete history first.' }
        $partial = & git -C $root config --get-regexp '^(extensions\.partialclone|remote\..*\.promisor)$'
        if ($LASTEXITCODE -gt 1) { throw 'Cannot inspect Git configuration.' }
        if ($partial) { throw 'Partial clones are not supported; use a complete checkout.' }
        if (Invoke-Git status --porcelain=v1 --untracked-files=all --ignore-submodules=none) { throw 'Local changes found. Commit or remove them before installation/export.' }
        $graftPath = Invoke-Git rev-parse --git-path info/grafts
        if (![IO.Path]::IsPathRooted($graftPath)) { $graftPath = Join-Path $root $graftPath }
        if ((Invoke-Git replace -l) -or ((Test-Path -LiteralPath $graftPath) -and (Get-Item -LiteralPath $graftPath).Length -gt 0)) { throw 'Git replacements/grafts are not supported.' }
        $commit = Invoke-Git rev-parse --verify 'HEAD^{commit}'
        $base = Invoke-Git show "${commit}:VERSION"
        $count = Invoke-Git --no-replace-objects rev-list --count $commit
        if ($base -cnotmatch '^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$' -or $count -cnotmatch '^[1-9][0-9]*$') { throw 'Invalid VERSION or commit count.' }
        Invoke-Git diff --quiet $commit --
        Invoke-Git diff --cached --quiet $commit --
        $version = "$base.$count"
    } else {
        if ($ExportPath) { throw 'Release export requires a complete Git checkout.' }
        $metadata = Join-Path $PSScriptRoot 'version.properties'
        if (!(Test-Path -LiteralPath $metadata)) { throw 'No Git checkout or prepared release version data found.' }
        $values = @{}
        foreach ($line in Get-Content -LiteralPath $metadata) {
            if ($line -cnotmatch '^(ADC_VERSION|ADC_GIT_COMMIT)=(.+)$' -or $values.ContainsKey($Matches[1])) { throw 'Invalid release version data.' }
            $values[$Matches[1]] = $Matches[2]
        }
        $version = $values['ADC_VERSION']; $commit = $values['ADC_GIT_COMMIT']
        $base = (Get-Content -LiteralPath (Join-Path $root 'VERSION') -Raw).TrimEnd("`r", "`n")
        if ($base -cnotmatch '^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$' -or !$version -or !$version.StartsWith("$base.")) { throw 'Release data does not match VERSION.' }
    }
    if ($version -cnotmatch '^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.[1-9][0-9]*$' -or $commit -cnotmatch '^([0-9a-f]{40}|[0-9a-f]{64})$') { throw 'Invalid product version or full Git commit hash.' }
    $data = "ADC_VERSION=$version`nADC_GIT_COMMIT=$commit`n"
    if ($ExportPath) {
        $destination = [IO.Path]::GetFullPath($ExportPath)
        if (Test-Path -LiteralPath $destination) { throw 'Export destination must not exist.' }
        $temp = Join-Path ([IO.Path]::GetTempPath()) ([IO.Path]::GetRandomFileName() + '.zip')
        try {
            Invoke-Git archive --format=zip "--output=$temp" $commit
            Expand-Archive -LiteralPath $temp -DestinationPath $destination
            [IO.File]::WriteAllText((Join-Path $destination 'ADC/install_scripts/version.properties'), $data, [Text.Encoding]::ASCII)
        } finally { Remove-Item -LiteralPath $temp -ErrorAction SilentlyContinue }
    }
    if ($OutputPath) { [IO.File]::WriteAllText($OutputPath, $data, [Text.Encoding]::ASCII) }
    Write-Host "ADC version $version, Git commit $commit"
} catch { Write-Error "ADC: $_"; exit 1 }
