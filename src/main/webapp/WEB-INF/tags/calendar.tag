<%@ tag language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="false" description="标签类型ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="标签name"%>
<%@ attribute name="editPanel" type="java.lang.String" required="false" description="日程设置的编辑区域"%>
<%@ attribute name="selectEvent" type="java.lang.String" required="false" description="在日期表格上面选中事件"%>
<%@ attribute name="eventClick" type="java.lang.String" required="false" description="点击已填信息时事件"%>
<div id="${empty id?'calendar':id}"></div>
<input type="hidden" type="${name}" id="${name}"/>
<script type="text/javascript">
	$(function() {
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		var calendar = $('#${empty id?'calendar':id}').fullCalendar({
			//isRTL: true,
			 buttonHtml: {
				prev: '<i class="ace-icon fa fa-chevron-left"></i>',
				next: '<i class="ace-icon fa fa-chevron-right"></i>'
			},
		
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			events: [
			  {
				title: 'All Day Event',
				start: new Date(y, m, 1),
				className: 'label-important'
			  },
			  {
				title: 'Long Event',
				start: new Date(y, m, d-5),
				end: new Date(y, m, d-2),
				className: 'label-success'
			  },
			  {
				title: 'Some Event',
				start: new Date(y, m, d-3, 16, 0),
				allDay: false
			  }
			]
			,
			monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],  
            monthNamesShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],  
            dayNames: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],  
            dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],  
            today: ["今天"],
            firstDay: 1,  
            buttonText: {  
              today: '本月',  
              month: '月',  
              week: '周',  
              day: '日',  
              prev: '上一页',  
              next: '下一页'  
            },
            currentTimezone: 'Asia/Beijing', 
			editable: true,
			droppable: true, // this allows things to be dropped onto the calendar !!!
			drop: function(date, allDay) { // this function is called when something is dropped
			
				// retrieve the dropped element's stored Event Object
				var originalEventObject = $(this).data('eventObject');
				var $extraEventClass = $(this).attr('data-class');
				
				
				// we need to copy it, so that multiple events don't have a reference to the same object
				var copiedEventObject = $.extend({}, originalEventObject);
				
				// assign it the date that was reported
				copiedEventObject.start = date;
				copiedEventObject.allDay = allDay;
				if($extraEventClass) copiedEventObject['className'] = [$extraEventClass];
				
				// render the event on the calendar
				// the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
				$('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
				
				// is the "remove after drop" checkbox checked?
				if ($('#drop-remove').is(':checked')) {
					// if so, remove the element from the "Draggable Events" list
					$(this).remove();
				}
				
			}
			,
			selectable: true,
			selectHelper: true,
			select: function(start, end, allDay) {
				platform.showContentDialog({
					title:'日程设置',
					content:'${editPanel}',
					selectedHandler:function(dialog){
						if(!!"${selectEvent}"){
							var result = eval("${selectEvent}(dialog,calendar)");
							if(!!result)
								calendar.fullCalendar('renderEvent',
									$.extend(true,{},{
										start: start,
										end: end
									},result),
									true // make the event "stick"
								);
						}
					},
					cancleHandler:function(dialog){
					},
					option:{
						width:400
					}
				});
				calendar.fullCalendar('unselect');
			}
			,
			eventClick: function(calEvent, jsEvent, view) {
		
				//display a modal
				var modal = 
				'<div class="modal fade">\
				  <div class="modal-dialog">\
				   <div class="modal-content">\
					 <div class="modal-body">\
					   <button type="button" class="close" data-dismiss="modal" style="margin-top:-10px;">&times;</button>\
					   <form class="no-margin">\
						  <label>Change event name &nbsp;</label>\
						  <input class="middle" autocomplete="off" type="text" value="' + calEvent.title + '" />\
						 <button type="submit" class="btn btn-sm btn-success"><i class="ace-icon fa fa-check"></i> Save</button>\
					   </form>\
					 </div>\
					 <div class="modal-footer">\
						<button type="button" class="btn btn-sm btn-danger" data-action="delete"><i class="ace-icon fa fa-trash-o"></i> Delete Event</button>\
						<button type="button" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-times"></i> Cancel</button>\
					 </div>\
				  </div>\
				 </div>\
				</div>';
			
			
				var modal = $(modal).appendTo('body');
				modal.find('form').on('submit', function(ev){
					ev.preventDefault();
		
					calEvent.title = $(this).find("input[type=text]").val();
					calendar.fullCalendar('updateEvent', calEvent);
					modal.modal("hide");
				});
				modal.find('button[data-action=delete]').on('click', function() {
					calendar.fullCalendar('removeEvents' , function(ev){
						return (ev._id == calEvent._id);
					})
					modal.modal("hide");
				});
				
				modal.modal('show').on('hidden', function(){
					modal.remove();
				});
		
		
				//console.log(calEvent.id);
				//console.log(jsEvent);
				//console.log(view);
		
				// change the border color just for fun
				//$(this).css('border-color', 'red');
		
			}
			
		});
	});
</script>
