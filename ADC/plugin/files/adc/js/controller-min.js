var de=de||{};function de_condes_plugin_adc(){de.condes.plugin.adc.init(this.action)}de.condes=de.condes||{},de.condes.plugin=de.condes.plugin||{},de.condes.plugin.adc=de.condes.plugin.adc||{},function(adc,$,server){"use strict";const C_CHANGE_EVENT="change",C_CLICK_EVENT="click",C_DBLCLICK_EVENT="dblclick",C_ENTER_EVENT="enter",C_KEYPRESS_EVENT="keypress",C_APEX_BEFORE_REFRESH="apexbeforerefresh",C_APEX_AFTER_REFRESH="apexafterrefresh",C_APEX_AFTER_CLOSE_DIALOG="apexafterclosedialog",C_NO_TRIGGERING_ITEM="DOCUMENT",C_LOCK_LENGTH=200,C_PROTECTED_EVENTS=[C_CLICK_EVENT,C_DBLCLICK_EVENT,C_ENTER_EVENT],C_BODY="body",C_BUTTON="button",C_APEX_BUTTON="t-Button",C_INPUT_SELECTOR=":input:visible:not(button)";adc.controller={};var ctl=adc.controller,props={ajaxIdentifier:"",quarantineList:[],triggeringElement:{id:"",data:"",event:"",isClick:!1},eventData:{ajaxIdentifier:"",pageItems:""},pageState:{itemMap:new Map},pageItems:[],bindItems:[],lastItemValues:[],additionalItems:[],standardMessages:{}};const changeCallback=function(e,t,n){getTriggeringElement(e),$(C_BODY).queue((function(){adc.actions.showWaitSpinner(n),ctl.execute(e,t)}))},enterCallback=function(e,t,n){getTriggeringElement(e),props.triggeringElement.event===C_ENTER_EVENT&&(apex.debug.info(`Enqueueing Event '${C_ENTER_EVENT}'`),$("body").queue((function(){adc.actions.showWaitSpinner(n),ctl.execute(t)})))},unsavedCallback=function(e,t){getTriggeringElement(e),$(C_BODY).queue((function(){adc.actions.showWaitSpinner(t),ctl.hasUnsavedChanges()?adc.renderer.confirmRequest(e,changeCallback):changeCallback(e)}))},bindEvent=function(e,t,n){var i,a;e.search(/[\.#\u0020:\[\]]+/)<0&&(e=`#${e}`),(i=$(e)).length>0&&(a="function"==typeof n?n:void 0!==n&&n.length>0?new Function(n):changeCallback,i.off(t).on(t,props.eventData,a),t===C_CHANGE_EVENT&&i.on(C_APEX_BEFORE_REFRESH,(function(t){$(this).off(C_CHANGE_EVENT),apex.debug.info(`Event '${C_CHANGE_EVENT}' paused at ${e}`)})).on(C_APEX_AFTER_REFRESH,(function(t){$(this).on(C_CHANGE_EVENT,props.eventData,a),apex.debug.info(`Event '${C_CHANGE_EVENT}' re-established at ${e}`)})))},bindEvents=function(){$.each(props.bindItems,(function(){this.event==C_ENTER_EVENT?bindEvent(this.id,C_KEYPRESS_EVENT,this.action||enterCallback):(bindEvent(this.id,this.event,this.action),this.event===C_CHANGE_EVENT&&addPageItem(this.id))}))},addPageItem=function(e){-1===$.inArray(e,props.pageItems)&&props.pageItems.push(e)},executeCode=function(e){var t;e&&($(C_BODY).append(e),t="#"+$(e).attr("id"),$(t).remove()),$(C_BODY).dequeue()},getTriggeringElement=function(e){var t;if(props.triggeringElement.id=C_NO_TRIGGERING_ITEM,props.triggeringElement.event=e.type,props.triggeringElement.data=e.data,props.triggeringElement.isClick=!1,void 0!==e.target){switch(props.triggeringElement.event){case C_APEX_AFTER_CLOSE_DIALOG:props.triggeringElement.id=e.currentTarget.id;break;case C_CHANGE_EVENT:props.triggeringElement.id=e.target.id,"radio"!==(t=$(`#${props.triggeringElement.id}`)).attr("type")&&"checkbox"!==t.attr("type")||(props.triggeringElement.id=t.parents(".radio_group,.checkbox_group").attr("id")),props.triggeringElement.id&&props.triggeringElement.id.match(/oj.*/)&&(props.triggeringElement.id=$(`#${props.triggeringElement.id}`).closest("div.apex-item-group").attr("id"));break;case C_CLICK_EVENT:props.triggeringElement.isClick=!0,props.triggeringElement.id=""!==e.target.id?e.target.id:e.currentTarget.id,""===props.triggeringElement.id&&(props.triggeringElement.id=e.target.parentElement.id),$(`#${props.triggeringElement.id}`).hasClass(C_APEX_BUTTON)||$(`#${props.triggeringElement.id}`).parent(C_BUTTON);break;case C_KEYPRESS_EVENT:switch(props.triggeringElement.id=e.target.id,e.keyCode){case 13:props.triggeringElement.event=C_ENTER_EVENT;break}break;default:props.triggeringElement.id=e.target.id}apex.debug.info(`Event '${props.triggeringElement.event}' raised at Triggering element '${props.triggeringElement.id}'`)}},hexToChar=function(e){var t,n="";if(e){t=e.toString();for(let e=0;e<t.length;e+=2)n+=String.fromCharCode(parseInt(t.substr(e,2),16))}return n},maintainAndCheckEventLock=function(){var e=!0,t=props.triggeringElement;return C_PROTECTED_EVENTS.indexOf(t.event)>-1?props.quarantineList.indexOf(t.event)>-1?(apex.debug.info(`Ignoring Event '${t.event}', on quarantine list`),e=!1):(apex.debug.info("Clear event queue after locking an event"),$("body").clearQueue(),props.quarantineList.push(t.event),apex.debug.info(`Event '${t.event}' pushed on quarantine`),setTimeout((function(){props.quarantineList=[],apex.debug.info(`Event '${t.event}' popped from quarantine`)}),C_LOCK_LENGTH),t.isClick&&(apex.debug.info(`Locking button '${t.id}'`),apex.item(t.id).disable())):C_PROTECTED_EVENTS.indexOf(props.quarantineList[0])>-1&&(apex.debug.info(`Ignoring event '${t.event}', event '${props.quarantineList[0]}' is on quarantine list`),e=!1),e},addButtonHandler=function(e,t,n,i){let a;a=$._data(e.get(0),"events"),void 0!==a&&a[C_CLICK_EVENT]&&e.off(C_CLICK_EVENT),e.on(C_CLICK_EVENT,{ajaxIdentifier:props.ajaxIdentifier,message:t,"props.pageItems":props.pageItems,title:n},i)};ctl.bindObserverItems=function(e){var t;e&&(t=e.split(","),$.each(t,(function(e,t){"."===this.substring(0,1)?$(t).each((function(e,t){addPageItem($(t).attr("id"))})):-1===$.inArray(t,props.pageItems)&&props.pageItems.push(t)})),apex.debug.info(`Additional page items: ${e}`))},ctl.bindConfirmationHandler=function(e,t,n,i){let a,r;a=i?function(){apex.actions.invoke(i)}:changeCallback,r=function(t){adc.renderer.confirmRequest(t,a,e.attr("id"))},addButtonHandler(e,t,n,r)},ctl.bindUnsavedConfirmationHandler=function(e,t,n){addButtonHandler(e,t,n,unsavedCallback)},ctl.findItemValue=function(e){var t=$.grep(props.lastItemValues,(function(t){return t.id===e}));if(t.length>0)return t[0].value},ctl.getPageState=function(){return props.pageState},ctl.setPageState=function(e){props.pageState=e},ctl.pushPageItem=function(e){-1===$.inArray(e,props.pageItems)&&(props.pageItems.push(e),bindEvent(e,C_CHANGE_EVENT))},ctl.hasUnsavedChanges=function(e){var t,n=!1;return t=Array.isArray(e)?e:$(C_INPUT_SELECTOR),$.each(t,(function(e){if((e=t[e]).id&&(e=e.id),apex.debug.info(`Comparing ${e}`),props.pageState.itemMap.has(e)&&props.pageState.itemMap.get(e)!=apex.item(e).getValue())return n=!0,!1})),n},ctl.pauseChangeEventDuringRefresh=function(e,t){var n,i,a=$(`#${e}`),r=a.get(0);a.length>0&&(n=$._data(r,"events"),delete(i=$.extend(!0,[],n)).change,$._data(r,"events",i),a.one(C_APEX_AFTER_REFRESH,(function(i){var a=ctl.getPageState();t&&(apex.item(e).setValue(t,t,!0),a.itemMap.has(e)&&(a.itemMap.set(e,t),ctl.setPageState(a))),$._data(r,"events",n)})))},ctl.setAdditionalItems=function(e){props.additionalItems=e},ctl.setTriggeringElement=function(e,t,n,i){props.triggeringElement.id=e,props.triggeringElement.event=t,props.triggeringElement.data=n,props.triggeringElement.isClick=i||!1},ctl.setLastItemValues=function(e){props.lastItemValues=e},ctl.getStandardMessage=function(e){return props.standardMessages[e]},ctl.execute=function(){maintainAndCheckEventLock()&&(props.triggeringElement.data&&props.triggeringElement.data.additionalPageItems&&(props.pageItems=new Set([...props.pageItems,...props.triggeringElement.data.additionalPageItems]),props.pageItems=Array.from(props.pageItems)),apex.debug.info(`ADC handles event ${props.triggeringElement.event}`),apex.debug.info(`ADC sends pageItems ${props.pageItems.join()}`),server.plugin(props.ajaxIdentifier,{x01:props.triggeringElement.id,x02:props.triggeringElement.event,x03:JSON.stringify(props.triggeringElement.data),pageItems:props.pageItems},{dataType:"html",success:function(e){props.triggeringElement.isClick&&apex.item(props.triggeringElement.id).enable(),executeCode(e)}}),props.additionalItems=[])},adc.init=function(pAction){props.bindItems=$.parseJSON(pAction.attribute01.replace(/~/g,'"')),adc.renderer=eval(pAction.attribute03),props.ajaxIdentifier=pAction.ajaxIdentifier,props.eventData.ajaxIdentifier=props.ajaxIdentifier,props.eventData.pageItems=props.pageItems,pAction.attribute02&&(apex.debug.info("Required pageItems: "+pAction.attribute02),props.pageItems=pAction.attribute02.split(",")),pAction.attribute06&&(props.standardMessages=JSON.parse(pAction.attribute06)),ctl.bindObserverItems(pAction.attribute05),bindEvents(),apex.debug.info("ADC initialized"),executeCode(hexToChar(pAction.attribute04))}}(de.condes.plugin.adc,apex.jQuery,apex.server);