package ${table.pkg}.${table.bumodel}.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.web.controller.BaseController;
import ${table.pkg}.${table.bumodel}.constants.${table.domainName}Constants;
import ${table.pkg}.${table.bumodel}.entity.${table.domainName};
import ${table.pkg}.${table.bumodel}.service.${table.domainName}Service;

@Controller
@RequestMapping("${"$"}{adminPath}/${table.domainName?uncap_first}")
public class ${table.domainName}Controller extends BaseController {
	@Autowired
	private ${table.domainName}Service ${table.domainName?uncap_first}Service;
	@Autowired
	private ${table.parent.domainName}Service ${table.parent.domainName?uncap_first}Service;
	@ModelAttribute
	public ${table.domainName} get(@RequestParam(required=false) String id) throws CRUDException {
		return new ${table.domainName}();
	}
	private void setCommonData(Model model) throws CRUDException{
    	model.addAttribute("${table.domainName?uncap_first}List", ${table.domainName?uncap_first}Service.findAll(new ${table.domainName}()));
    }
	private void initParents(Model model) throws CRUDException{
        model.addAttribute("parents", ${table.parent.domainName?uncap_first}Service.findAll(new ${table.parent.domainName}()));
	}
	@RequiresPermissions("${table.domainName?uncap_first}:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
    	setCommonData(model);
        return ${table.domainName}Constants.LIST;
    }
	@RequiresPermissions("${table.domainName?uncap_first}:create")
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showCreatFrom(Model model) {
        model.addAttribute("op", "保存");
        initParents(model);
        return ${table.domainName}Constants.EDIT;
    }
	@RequiresPermissions("${table.domainName?uncap_first}:create")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String create(${table.domainName} ${table.domainName?uncap_first}, RedirectAttributes redirectAttributes) throws CRUDException {
		${table.domainName?uncap_first}Service.save(${table.domainName?uncap_first});
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/${table.domainName?uncap_first}");
    }
	@RequiresPermissions("${table.domainName?uncap_first}:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(${table.domainName} ${table.domainName?uncap_first}, Model model) throws CRUDException {
        model.addAttribute("${table.domainName?uncap_first}", ${table.domainName?uncap_first}Service.findOne(${table.domainName?uncap_first}));
        model.addAttribute("op", "修改");
        initParents(model);
        return ${table.domainName}Constants.EDIT;
    }
	@RequiresPermissions("${table.domainName?uncap_first}:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(${table.domainName} ${table.domainName?uncap_first}, RedirectAttributes redirectAttributes) throws CRUDException {
		${table.domainName?uncap_first}Service.update(${table.domainName?uncap_first});;
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/${table.domainName?uncap_first}");
    }
	@RequiresPermissions("${table.domainName?uncap_first}:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(${table.domainName} ${table.domainName?uncap_first}, RedirectAttributes redirectAttributes) throws CRUDException {
		${table.domainName?uncap_first}Service.delete(${table.domainName?uncap_first});
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/${table.domainName?uncap_first}");
    }
	@RequiresPermissions("${table.domainName?uncap_first}:delete")
    @RequestMapping(value = "/deleteBatch", method = RequestMethod.GET)
    public String deleteBatch(${table.domainName} ${table.domainName?uncap_first}, RedirectAttributes redirectAttributes) throws CRUDException {
		${table.domainName?uncap_first}Service.deleteBatch(${table.domainName?uncap_first});
        redirectAttributes.addFlashAttribute("msg", "批量删除成功");
        return getAdminUrlPath("/${table.domainName?uncap_first}");
    }
}