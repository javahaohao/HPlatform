#HPlatform敏捷开发平台
---
##HPlatform是什么？

    HPlatform是一个采用Maven管理的基础敏捷开发平台，是一个集众多开源技术控件为一体的开源项目，它拥有独立的权限资源管理和组织架构管理，模块分类明确，二次开发敏捷（单表基本CRUD维护只需5分钟完成）等特点。
---
##HPlatform组成有哪些？
* ####平台前端UI及控件组成
    * 整体样式采用目前主流的Bootstrap样式类库
    * UI采用了基于Bootstrap的Boostrap-Ace组件库，里面含有丰富的控件，可以满足大部分开发需要，[预览参考](http://responsiweb.com/themes/preview/ace/1.4/),[API帮助文档]()
    * 模板组件采用了腾讯开源的[artTemplate](http://aui.github.io/artTemplate/)，[性能对比](http://www.iteye.com/news/25340)
    * 上传组件采用了百度开源的[webuploader](http://fex.baidu.com/webuploader/)组件
    * JS类库基于[jQuery v2.1.1](http://hemin.cn/jq/)，也与[jQueryUI](http://www.css88.com/jquery-ui-api/)无缝集成，采用[jquery-validate](http://plugins.jquery.com/validate/)验证控件，[ztree](http://www.ztree.me/v3/main.php)树控件
    * 与websocket集成实现消息推送以及即时聊天工具
* ###平台后端及组件组成
    * 架构是由SpringMVC+mybatis框架组成
    * 采用了shiro安全框架，来管理平台的登陆、权限以及资源的分配
    * 使用ehcache-web的SimplePageCachingFilter来缓存页面，使页面加载更加迅速
    * sitemesh作为渲染页面的布局模板
    * freemarker模板引擎，用于代码生成器
    * 集成HtmlUnit爬虫技术，可简单实现页面爬取
    * junit单元测试工具
    * 文件处理工具FileUtils封装了IO的操作，与webuploader搭配可实现文件的断点上传下载
    * 采用缓存技术Ehcache，将字典数据缓存到内存，以便快速读取
    * Apache-poi导入导出
    * quartz动态定时任务（spring默认是固定的定时任务，经过封装改造成读取数据库动态定时任务）
    * 分页采用PageHelper,支持跨数据类型分页
    * 数据库链接池采用阿里巴巴的DruidDataSource
    * 各种工具类的封装等等，详情参加代码
---
##HPlatform适合什么项目类型？
    平台建议针对于企业级项目、电商级以及类似于进销存管理项目进行二次开发
---
##注：
* HPlatform使用Eclipse ide开发工具开发，源码中包含了项目源码以及sql脚本（mysql）
* 目前HPlatform算是一个嗷嗷待哺的小雏鸟，对HPlatform感兴趣的“童鞋”可以加入进来，提各种bug以及意见，大家一起交流进行完善，让它变成一直翱翔于天空的雄鹰
* QQ交流群：424890813
    