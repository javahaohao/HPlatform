package com.hplatform.core.web.controller;

import com.hplatform.core.constants.ColumnsConstants;
import com.hplatform.core.constants.TagsConstants;
import com.hplatform.core.entity.Element;
import com.hplatform.core.service.ElementService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hplatform.core.common.util.ConstantsUtil;
import com.hplatform.core.constants.TableConstants;
import com.hplatform.core.entity.Columns;
import com.hplatform.core.entity.Table;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.ColumnsService;
import com.hplatform.core.service.DictService;
import com.hplatform.core.service.TableService;

@Controller
@RequestMapping("${adminPath}/table")
public class TableController extends BaseController {
	@Autowired
	private TableService tableService;
	@Autowired
	private ColumnsService columnsService;
	@Autowired
	private DictService dictService;
	@Autowired
	private ElementService elementService;
	@ModelAttribute
	public Table get(@RequestParam(required=false) String id) throws CRUDException {
		return new Table();
	}
	private void setCommonData(Model model,Table table) throws CRUDException{
    	model.addAttribute("tableList", tableService.findAll(table));
    }
	@RequiresPermissions("table:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
        Table table = new Table();
        table.setGenType(ConstantsUtil.get().getONE());
    	setCommonData(model,table);
        return TableConstants.LIST;
    }
	@RequiresPermissions("table:create")
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showCreatFrom(Model model) {
        model.addAttribute("op", "保存");
        model.addAttribute("relationTypes", Table.RelationType.values());
        return TableConstants.EDIT;
    }
	@RequiresPermissions("table:create")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String create(Table table, RedirectAttributes redirectAttributes) throws CRUDException {
        table.setStep(TableConstants.GEN_STEP_ONE);
        table.setGenType(ConstantsUtil.get().getONE());
		tableService.save(table);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/table");
    }
	@RequiresPermissions("table:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(Table table, Model model) throws CRUDException {
        model.addAttribute("table", tableService.findOne(table));
        model.addAttribute("relationTypes", Table.RelationType.values());
        model.addAttribute("op", "修改");
        return TableConstants.EDIT;
    }
	@RequiresPermissions("table:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(Table table, RedirectAttributes redirectAttributes) throws CRUDException {
		tableService.update(table);
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/table");
    }
	@RequiresPermissions("table:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(Table table, RedirectAttributes redirectAttributes) throws CRUDException {
		tableService.delete(table);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/table");
    }
	
	@RequiresPermissions("table:view")
    @RequestMapping(value = "/{tableId}/viewColumn",method = RequestMethod.GET)
    public String list(Columns columns,Model model) throws CRUDException {
		model.addAttribute("columnsList", columnsService.findAllByRelation(columns));
		model.addAttribute("table",tableService.findOne(new Table(columns.getTableId())));

        model.addAttribute("FK", ColumnsConstants.COLUMN_KEYS_FK);
		model.addAttribute("validateList",dictService.findChildDictById(ConstantsUtil.get().DICT_VALIDATE_PARENT_ID));
        return TableConstants.COLUMN_EDIT;
    }
	@RequiresPermissions("table:create")
    @RequestMapping(value = "/editColumns", method = RequestMethod.POST)
    public String editColumns(Table table, RedirectAttributes redirectAttributes) throws CRUDException {
        if(TableConstants.GEN_STEP_TWO!=table.getStep()){
            table.setStep(TableConstants.GEN_STEP_TWO);
            table.setGenFlag(true);
            tableService.update(table);
        }
		columnsService.editColumns(table.getColumnList());
        redirectAttributes.addFlashAttribute("msg", "规则保存成功！");
        return getAdminUrlPath("/table");
    }
	/**
	 * 批量代码生成
	 * @param table
	 * @param redirectAttributes
	 * @return
	 * @throws CRUDException
	 */
	@RequiresPermissions("table:create")
	@RequestMapping(value = "/genCodeBatch", method = RequestMethod.GET)
	public String genCodeBatch(Table table, RedirectAttributes redirectAttributes) throws Exception {
		tableService.genCodeBatch(table);
		redirectAttributes.addFlashAttribute("msg", "代码生成成功！");
		return getAdminUrlPath("/table");
	}

    /**
     * 重置方案配置规则
     * @param table
     * @param redirectAttributes
     * @return
     * @throws CRUDException
     */
    @RequiresPermissions("table:update")
    @RequestMapping(value = "/{id}/reset", method = RequestMethod.GET)
    public String reset(Table table, RedirectAttributes redirectAttributes) throws CRUDException {
        tableService.resetGenRules(table.getId());
        redirectAttributes.addFlashAttribute("msg", "规则重置成功");
        return getAdminUrlPath("/table/"+table.getId()+"/viewColumn");
    }


    /**
     * 跳转自定义表单页面
     * @param model
     * @param table
     * @return
     * @throws CRUDException
     */
    @RequiresPermissions("table:create")
    @RequestMapping(value = "/form", method = RequestMethod.GET)
    public String form(Model model,Table table) throws CRUDException {
        table.setGenType(ConstantsUtil.get().getZERO());
        setCommonData(model,table);
        return TableConstants.FORM_LIST;
    }

    /**
     * 跳转form自定义表单维护界面
     * @param model
     * @param table
     * @return
     * @throws CRUDException
     */
    @RequiresPermissions("table:create")
    @RequestMapping(value = "/form/create", method = RequestMethod.GET)
    public String formCreate(Model model,Table table) throws CRUDException {
        model.addAttribute("table", tableService.findOne(table));
        return TableConstants.FORM;
    }

    /**
     * 保存自定义表单
     * @param table
     * @return
     * @throws CRUDException
     */
    @RequiresPermissions("table:create")
    @RequestMapping(value = "/form/create", method = RequestMethod.POST)
    public String saveForm(Table table) throws CRUDException {
        return getAdminUrlPath("/table/form");
    }
}
