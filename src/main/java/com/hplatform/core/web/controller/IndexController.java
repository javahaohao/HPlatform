package com.hplatform.core.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hplatform.core.common.htmlunit.HtmlUnitUtil;
import com.hplatform.core.entity.Area;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.AreaService;
import com.hplatform.core.service.ResourceService;
import com.hplatform.core.service.UserService;

@Controller
public class IndexController extends BaseController {

    @Autowired
    private ResourceService resourceService;
    @Autowired
    private UserService userService;
    @Autowired
    private AreaService areaService;

    @RequestMapping("${adminPath}/")
    public String adminPath( Model model) {
//        return "index";
        return "welcome";
    }
    @RequestMapping("${sitePath}/")
    public String sitePath(Model model) throws CRUDException {
        return "core/site/index";
    }
    @RequestMapping("${adminPath}/welcome")
    public String welcome() {
        return "welcome";
    }
    
    /**
     * 获取当前所在城市信息
     * @param request
     * @return
     * @throws CRUDException
     */
    @RequestMapping("/site/cuurentSite")
    @ResponseBody
    public Area getCurrentArea(HttpServletRequest request) throws CRUDException{
    	Area area = new Area();
    	area.setCode(HtmlUnitUtil.getIpInfo(HtmlUnitUtil.getIpAddress(request)).getCity_id());
    	area.setLevel(2);
    	return areaService.findOne(area);
    }
    /**
     * 按照条件查询区域数据
     * @param model
     * @return
     * @throws CRUDException
     */
    @RequestMapping("/site/findAreas")
    @ResponseBody
    public List<Area> findAreas(Model model,Area area) throws CRUDException{
    	return areaService.findAll(area);
    }
    /**
     * 404、500跳转页面
     * @param model
     * @return
     * @throws CRUDException
     */
    @RequestMapping("/redirect")
    public String redirect(Model model) throws CRUDException{
    	return "exception/redirect";
    }
}
