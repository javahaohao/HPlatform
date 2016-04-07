(function( $ ){
	$.fn.jqDatagrid=function(options,selfOptions){
		var searchForm = $('.form-search');
		return $(this).data('jqDatagrid',
				new widget.jqDatagrid(options,$.extend(true,{
					container:$(this),
					searchForm:searchForm,
					columnModel:[],								// 拼装列配置对象数组
					pager: '#grid-page',
					inputPageNum:$('#pageNum',searchForm),
					inputPageSize:$('#pageSize',searchForm),
					inputOrderBy:$('#orderBy',searchForm)
				},selfOptions)));
	};
	/**
	 * jqDatagrid.default的默认值，
	 * 可以通过setDefaults改变或者重载默认属性
	 */
	$.fn.jqDatagrid.defaults={
		url:'',
		mtype: "POST", 
		datatype: "json",
		// 自定义表格的JSON读取参数
		jsonReader: { 	
			id: "id", root: "list", page: "pageNum", userdata: "otherData",
			total: "pages", records: "total", subgrid: {root:"list"},
			repeatitems: true
		},
		// 自定义Ajax请求参数
		prmNames: {		
			page:"pageNum", rows:"pageSize", sort: "orderBy",
			order: "sord", search:"search", nd:"nd", id:"id",
			oper:"oper",editoper:"edit",addoper:"add",deloper:"del", 
			subgridid:"id", npage: null, totalrows:"pages"
		},
		rowNum: -1, 		// 显示行数，-1为显示全部
		rownumbers:true,	// 左侧行号
		rownumWidth: 30,	// 序号列宽
		rowList:[20,50,100],
		multiselect: true,
		multiboxonly: true,	// 单击复选框时在多选
		altRows: true, 		// 斑马线样式，交替行altclass
		height:'auto',
		colNames:[],
		colModel:[],
		viewrecords:true,	// 确定是否显示总的记录条数
		sortorder:'desc',	// 当使用xml或者json数据类型时，设置默认的排序方式。可选值asc或desc.
		
		// 树结构表格参数
		treeGrid: false,							// 启用树结构表格
		treeGridModel: 'adjacency',					// 启用简单结构模式
		ExpandColClick: true,						// 单击列可展开
		ExpandColumn: ''							// 要展开的列
		
	};
	/**
	 * jqDatagrid.default的全局配置属性
	 * 可在任何位置配置jqDatagrid的属性值
	 */
	$.fn.jqDatagrid.setDefaults=function(defaults){
		$.extend(true,$.fn.jqDatagrid.defaults,defaults);
	};
	var widget = widget||{};
	widget.jqDatagrid = function(options,selfOptions){
		var self = this;
		//将全局属性以及使用时传入的参数合并到jqDatagrid对象里，方便下文this直接调用
		self.jqGridOptions = $.extend(true,
								$.fn.jqDatagrid.defaults,{
									pager:selfOptions.pager,
									//postData: selfOptions.searchForm.serializeArray(),
									loadComplete:function(data){
										self.updatePagerIcons();
										self.enableTooltips();
										self.setParam({rowNum:data.pageSize});
									},
									onSortCol:function(index, iCol, sortorder){
										if (selfOptions.inputOrderBy && selfOptions.inputOrderBy.length){
											selfOptions.inputOrderBy.val(index + ' ' + sortorder);
										}
									},
									beforeRequest:function(){
										//self.setParam({postData: selfOptions.searchForm.serializeArray()});
									}
								},options);
		
		$.extend(true,this,selfOptions);
		
		self.init();
	}
	widget.jqDatagrid.prototype={
		/**
		 * 初始化jqGrid
		 */
		init:function(){
			var self = this;
			self.analyticalColModel();
			
			self.jqGrid = self.container.jqGrid(self.jqGridOptions);
			
			self.setNavButtons();
			
			self.bindEvent();
			
			self.setSearchDom();
		},
		/**
		 * 设置查询元素
		 */
		setSearchDom:function(){
			var self = this;
			
		},
		/**
		 * 解析列对象为jqGrid标准格式
		 */
		analyticalColModel:function(){
			var self = this;
			for(var i=0; i<self.columnModel.length; i++){
				self.jqGridOptions.colNames.push(self.columnModel[i].header);
				self.jqGridOptions.colModel.push(self.columnModel[i]);
			}
		},
		/**
		 * 绑定事件
		 */
		bindEvent:function(){
			var self = this;
			//resize to fit page size
			$(window).on('resize.jqGrid', function () {
				self.container.jqGrid( 'setGridWidth', $(".page-content").width() );
		    }).triggerHandler('resize.jqGrid');
			//resize on sidebar collapse/expand
			var parent_column = self.container.closest('[class*="col-"]');
			$(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
				if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
					//setTimeout is for webkit only to give time for DOM changes and then redraw!!!
					setTimeout(function() {
						self.container.jqGrid( 'setGridWidth', parent_column.width() );
					}, 0);
				}
		    }).on('ajaxloadstart', function(e) {
		    	self.container.jqGrid('GridUnload');
				$('.ui-jqdialog').remove();
			});
		},
		/**
		 * 设置navButtons
		 */
		setNavButtons:function(){
			var self = this;
			//navButtons
			jQuery(self.container).jqGrid('navGrid',self.pager,
				{ 	//navbar options
					edit: false,
					editicon : 'ace-icon fa fa-pencil blue',
					add: false,
					addicon : 'ace-icon fa fa-plus-circle purple',
					del: false,
					delicon : 'ace-icon fa fa-trash-o red',
					search: true,
					searchicon : 'ace-icon fa fa-search orange',
					refresh: true,
					refreshicon : 'ace-icon fa fa-refresh green',
					view: false,
					viewicon : 'ace-icon fa fa-search-plus grey'
				}
			);
		},
		//replace icons with FontAwesome icons like above
		updatePagerIcons:function(){
			var replacement = 
			{
				'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
				'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
				'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
				'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
			};
			$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
				var icon = $(this);
				var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
				
				if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
			});
		},
		enableTooltips:function(){
			$('.navtable .ui-pg-button').tooltip({container:'body'});
			this.container.find('.ui-pg-div').tooltip({container:'body'});
		},
		/**
		 * 设置jqGrid参数
		 */
		setParam:function(param){
			if(this.jqGrid)
				this.jqGrid.jqGrid('setGridParam', param);
		}
	}
})( jQuery );