package com.hplatform.core.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.org.rapid_framework.util.ObjectUtils;

import com.hplatform.core.common.util.ConstantsUtil;
import com.hplatform.core.common.util.PropertiesUtil;
import com.hplatform.core.common.util.UserUtil;
import com.hplatform.core.common.word.ExportExcel;
import com.hplatform.core.common.word.ImportExcel;
import com.hplatform.core.constants.Constants;
import com.hplatform.core.entity.Attachment;
import com.hplatform.core.entity.Page;
import com.hplatform.core.entity.User;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.DictService;
import com.hplatform.core.service.OrganizationService;
import com.hplatform.core.service.RoleService;
import com.hplatform.core.service.UserService;
import com.hplatform.model.entity.Resume;
import com.hplatform.model.service.ResumeService;

@Controller
@RequestMapping("${adminPath}/user")
public class UserController extends BaseController {

    @Autowired
    private UserService userService;

    @Autowired
    private OrganizationService organizationService;
    @Autowired
    private DictService dictService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private ResumeService resumeService;

    @RequiresPermissions("user:info")
    @RequestMapping(value="/userinfo",method = RequestMethod.GET)
    public String userInfo(Model model,User user) throws CRUDException {
    	user.setId(UserUtil.getCurrentUserId());
        model.addAttribute("user", userService.findOne(user));
        Resume resume = resumeService.findOne(new Resume(user.getId()));
        resume = ObjectUtils.isEmpty(resume)?new Resume():resume;
        model.addAttribute("resume", resume);
        return "core/user/userinfo";
    }
    
    @RequiresPermissions("user:info")
    @RequestMapping(value = "/updateinfo", method = RequestMethod.POST)
    public String updateinfo(User user, Model model) throws CRUDException {
        userService.updateUser(user);
        return getAdminUrlPath("/user/userinfo");
    }
    
    @RequiresPermissions("user:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list() throws CRUDException {
        return "core/user/list";
    }
    
    @RequiresPermissions("user:view")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public Page<User> listData(User user) throws CRUDException {
        return userService.findAllByPage(user);
    }

    @RequiresPermissions("user:create")
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateForm(Model model) {
        setCommonData(model);
        model.addAttribute("user", new User());
        model.addAttribute("op", "新增");
        return "core/user/edit";
    }

    @RequiresPermissions("user:create")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String create(User user, RedirectAttributes redirectAttributes) throws CRUDException {
        userService.createUser(user);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/user");
    }

    @RequiresPermissions("user:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(User user, Model model) throws CRUDException {
        setCommonData(model);
        model.addAttribute("user", userService.findOne(user));
        model.addAttribute("op", "修改");
        return "core/user/edit";
    }

    @RequiresPermissions("user:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(User user, RedirectAttributes redirectAttributes) throws CRUDException {
        userService.updateUser(user);
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/user");
    }

    @RequiresPermissions("user:delete")
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String delete(User user, RedirectAttributes redirectAttributes) throws CRUDException {
        userService.deleteUser(user);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/user");
    }

    @RequiresPermissions("user:delete")
    @RequestMapping(value = "/deleteBatch", method = RequestMethod.GET)
    public String deleteBatch(User user, RedirectAttributes redirectAttributes) throws CRUDException {
        userService.deleteBatchEntity(user);
        redirectAttributes.addFlashAttribute("msg", "批量删除成功");
        return getAdminUrlPath("/user");
    }

    /**
     * 验证原始密码输入是否正确
     * @param user
     * @return
     * @throws CRUDException
     */
    @RequestMapping(value = "/confirmOldPwd", method = RequestMethod.POST)
    @ResponseBody
    public boolean confirmOldPwd(User user) throws CRUDException{
    	return ObjectUtils.isNotEmpty(userService.confirmOldPwd(user));
    }

    @RequiresPermissions("user:info")
    @RequestMapping(value = "/{id}/changePassword", method = RequestMethod.GET)
    public String showChangePasswordForm(User user, Model model) throws CRUDException {
        model.addAttribute("user", userService.findOne(user));
        model.addAttribute("op", "修改密码");
        return "core/user/changePassword";
    }

    @RequiresPermissions("user:info")
    @RequestMapping(value = "/changePassword", method = RequestMethod.POST)
    public String changePassword(User user, RedirectAttributes redirectAttributes) throws CRUDException {
        userService.updatePassword(user);
        redirectAttributes.addFlashAttribute("msg", "修改密码成功");
        return getAdminUrlPath(String.format("/user/%s",UserUtil.getParamFromRequest("from")));
    }

    private void setCommonData(Model model) {
        model.addAttribute("organizationList", organizationService.findAll());
        model.addAttribute("roleList", roleService.findAll());
        model.addAttribute("userTypeList",dictService.findChildDictById(ConstantsUtil.get().DICT_USER_TYPE_PARENT_ID));
    }
    /**
     * 修改用户头像
     * @return
     * @throws CRUDException 
     */
    @RequiresPermissions("user:info")
    @RequestMapping(value = "/uploadHeaderPic", method = RequestMethod.POST)
    @ResponseBody
    public Attachment uploadHeaderPic(User user,Attachment attachment,@RequestParam("photo") MultipartFile file) throws CRUDException{
    	return userService.updateUserHeaderPic(attachment,user,file);
    }
    /**
     * 激活锁定用户
     * @param user
     * @return
     * @throws CRUDException 
     */
    @RequiresPermissions("user:update")
    @RequestMapping(value = "/{id}/{activation}/activation", method = RequestMethod.GET)
    public String activation(User user) throws CRUDException{
    	userService.updateActivation(user);
    	return getAdminUrlPath("/user");
    }
    /**
     * 初始化密码
     * @param user
     * @return
     * @throws CRUDException
     */
    @RequiresPermissions("user:update")
    @RequestMapping(value = "/{id}/initUserPwd", method = RequestMethod.GET)
    public String initUserPwd(User user, RedirectAttributes redirectAttributes) throws CRUDException{
    	String initPwd = PropertiesUtil.getProperty(Constants.DEFAULT_PWD);
    	user = userService.findOne(user);
    	user.setPassword(initPwd);
    	userService.updatePassword(user);
    	redirectAttributes.addFlashAttribute("msg", StringUtils.join(new Object[]{"密码已经初始化为:",initPwd}));
    	return getAdminUrlPath("/user");
    }
    
    /**
	 * 导出人员
	 * @param modelMap
	 * @param ids
	 * @return
	 * @throws Exception
	 */
    @RequiresPermissions("user:view")
	@RequestMapping(value = "/exportUser")
	public void exportUser(HttpServletResponse response) throws Exception {
		new ExportExcel("用户数据", User.class).setDataList(userService.findAll(new User())).write("用户信息.xlsx").dispose();
	}
	/**
	 * 导入人员
	 * @param file
	 * @throws Exception
	 */
	@RequiresPermissions("user:update")
	@RequestMapping(value = "/importUser", method = RequestMethod.POST)
	@ResponseBody
	public void importUser(HttpServletRequest request,@RequestParam MultipartFile fileInput) throws Exception {
		ImportExcel ei = new ImportExcel(fileInput, 1, 0);
		List<User> userList = ei.getDataList(User.class);
		for(User user : userList){
			System.out.println(user);
		}
	}
    //注册用户-start
    /**
     * 注册用户入口
     * @param user
     * @return
     * @throws CRUDException 
     */
    @RequestMapping(value = "/register/registerUser", method = RequestMethod.POST)
    @ResponseBody
    public String registerUser(User user) throws CRUDException {
    	userService.registerUser(user);
        return "恭喜！注册成功，立马激活登录系统。";
    }
    /**
     * 验证注册用户信息
     * @param user
     * @return
     * @throws CRUDException
     */
    @RequestMapping(value = "/register/checkInfo", method = RequestMethod.POST)
    @ResponseBody
    public boolean registerCheckInfo(User user) throws CRUDException {
    	return ObjectUtils.isEmpty(userService.registerCheckInfo(user));
    }
    @RequestMapping(value = "/register/sendEmailCode", method = RequestMethod.POST)
    @ResponseBody
    public String sendEmailCheckCode(String email) throws CRUDException{
    	boolean sendFlag = userService.sendRegisterEmailCheckCode(email);
    	if(sendFlag)
    		return "验证码已发送到您得邮箱，请注意查收！";
    	else
    		return "邮件发送失败！请验证邮箱正确性.";
    }
    @RequestMapping(value = "/register/checkEmailCode", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkEmailCode(String email,String code){
    	return userService.checkRegisterEmailCode(email, code);
    }
    //注册用户-end
    //重置密码-start
    /**
     * 用户密码找回邮箱验证码发送
     * @param email
     * @return
     * @throws CRUDException 
     */
    @RequestMapping(value = "/register/sendResetPwdEmailCode", method = RequestMethod.POST)
    @ResponseBody
    public boolean sendResetPwdEmailCode(String email) throws CRUDException{
    	return userService.sendRestPwdEmailCheckCode(email);
    }
    @RequestMapping(value = "/register/getUserByEmailCode", method = RequestMethod.GET)
    public String getUserByEmailCode(String code,Model model) throws CRUDException{
    	model.addAttribute("user", userService.getUserByEmailCode(code));
    	return "core/user/resetpwd";
    }
    /**
     * 重置新密码
     * @param user
     * @param redirectAttributes
     * @return
     * @throws CRUDException 
     */
    @RequestMapping(value = "/register/resetPassword", method = RequestMethod.POST)
    public String resetPassword(User user, RedirectAttributes redirectAttributes) throws CRUDException {
        userService.updatePassword(user);
        redirectAttributes.addFlashAttribute("msg", "修改密码成功");
        return getAdminUrlPath("/login");
    }
    /**
     * 验证发送的邮箱是否存在
     * @param user
     * @return
     * @throws CRUDException
     */
    @RequestMapping(value = "/register/hasEmail", method = RequestMethod.POST)
    @ResponseBody
    public boolean hasEmail(User user) throws CRUDException {
    	return !registerCheckInfo(user);
    }
    //重置密码-end
}
