
function MenuView(config){
	this.items = config.items || [];
	this.formatItems = [];
	this.handler = config.handler;
	this.path = config.path;
	this.contentFrame = config.contentFrame;
	//根节点编号
	this.rootId = '1';
	
	//存放菜单的容器(即：菜单的父元素)
	this.container = typeof config.container === 'string' ? $('#' + config.container) : config.container;
	
	this.create();
}

MenuView.prototype = {
	create: function(){
		var self = this;
		
		//组建菜单
		self._menuUL = $('<ul class="nav nav-list"></ul>');
		
		self._menuUL.appendTo(self.container);
		
		//将数组节点转换成字符串，使用“,”隔开
		//转换后的字符串样式:		parentId_selfId,parentId_selfId
		var idArr = [],eachId,eachItem;
		for(var i in self.items){
			eachItem = self.items[i];
			eachId = eachItem.parentId+'_'+eachItem.id;
			self.formatItems[eachId] = eachItem;
			idArr.push(eachId);
		}
		self.ids = idArr.join(',');
		self._loadChildItems(self._getEachMenuId(self.rootId),self._menuUL);
		self._show();
	},
	
	/**
	 * 获取所有以parentId开始，32位字母或者数字组成的字符串结尾，中间使用下划线分割的字符串。
	 * 即：匹配【parentId_selfId】
	 * @param parentId
	 * @returns
	 */
	_getEachMenuId: function(parentId){
		var self = this;
		var reg = new RegExp(parentId+"[_][a-zA-Z0-9]*","g");
		return self.ids.match(reg);
	},
	
	/**
	 *	private
	 *
	 *	加载子菜单的内容
	 *
	 */
	_loadChildItems: function(itemIds,ul){
		var self = this;
		for(var index in itemIds){
			var $li = $('<li></li>').appendTo(ul),$a = $('<a></a>'),$item = self.formatItems[itemIds[index]];
			if(!!$item){
				$li.append($a);
				$a.attr({
					'itemId':$item.id,
					'href':'#',
					'url':$item.url
				}).text($item.name);
				var childItemIds = self._getEachMenuId($item.id);
				if($item.parentId===self.rootId&&(!!!childItemIds||childItemIds.length<=0)){
					$li.remove();
					continue;
				}else if($item.parentId===self.rootId){
					$a.prepend('<i class="menu-icon '+(!!!$item.icon?'fa fa-desktop':$item.icon)+'"></i>');
				}
				if(!!childItemIds&&$.isArray(childItemIds)&&childItemIds.length>0){
					$a.addClass('dropdown-toggle').append('<b class="arrow fa fa-angle-down"></b>');
					self._loadChildItems(childItemIds, $('<ul class="submenu"></ul>').appendTo($li));
				}else{
					$a.prepend('<i class="menu-icon '+(!!!$item.icon?'fa fa-desktop':$item.icon)+'"></i>')
					//.prepend('<i class="menu-icon fa fa-caret-right"></i>')
					.on('click',function(){
						self._location(self.path+$(this).attr('url'),$(this).attr('itemId'));
					});
				}
			}
		}
	},
	/**
	 * 点击菜单链接到的位置
	 */
	_location:function(url,itemId){
		var self = this;
		setCookie('currentMenu', itemId+'&'+url, 'h'+24,function(){
			if(!!self.contentFrame)
				$(self.contentFrame).attr('src',url);
			else
				window.location = url;
		});
	},
	/**
	 * 根据itemId展示当前选择的菜单
	 */
	_show:function(){
		var cookieMenu = getCookie('currentMenu'),currentItem;
		if(cookieMenu){
			currentItem = $('a[itemId="'+cookieMenu.split('&')[0]+'"]');
		}
		if(!!!currentItem)
			currentItem = $('a[itemId]:first');
		currentItem.closest('li')
		.addClass('active').closest('ul').closest('li')
		.addClass('active open');
	}
};
