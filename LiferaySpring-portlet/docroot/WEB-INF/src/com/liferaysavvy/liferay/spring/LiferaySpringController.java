package com.liferaysavvy.liferay.spring;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;
import javax.portlet.ReadOnlyException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.portlet.ValidatorException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.ModelAndView;
import org.springframework.web.portlet.bind.annotation.ActionMapping;
import org.springframework.web.portlet.bind.annotation.RenderMapping;
import org.springframework.web.portlet.bind.annotation.ResourceMapping;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.servlet.ServletResponseUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.model.User;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
@Controller
@RequestMapping(value = "VIEW")
public class LiferaySpringController{
	private static final long serialVersionUID = 1L;
	private com.liferay.portal.kernel.log.Log logger = LogFactoryUtil
			.getLog(LiferaySpringController.class);
	private static final String DEFAULT_VIEW_PAGE_NAME = "view";
	@RenderMapping
	public String renderView(RenderRequest request, RenderResponse response) {
		String renderViewPageName = ParamUtil.getString(request, "jspPageName");
		logger.info("renderView Method");
		if (renderViewPageName != null
				&& !renderViewPageName.equalsIgnoreCase("")) {
			return renderViewPageName.trim();
		} else {
			return DEFAULT_VIEW_PAGE_NAME;
		}
	}
	@RenderMapping(params ="action=listusers")
	public ModelAndView listUsersView(RenderRequest request, RenderResponse response) throws SystemException {
		return new ModelAndView("list_users","userList",UserLocalServiceUtil.getUsers(-1, -1));
	}
	@RenderMapping(params ="action=view")
	public String renderHomePage(RenderRequest request, RenderResponse response) throws SystemException {
		return "view";
	}
	@RenderMapping(params ="action=validateUser")
	public String renderValidateuserPage(RenderRequest request, RenderResponse response) throws SystemException {
		return "validate_user";
	}
	@RenderMapping(params ="action=viewUserRigistration")
	public String renderCreateAccountPage(RenderRequest request, RenderResponse response) throws SystemException {
		return "form_submission";
	}
	@RenderMapping(params ="action=viewUserRigistrationData")
	public String renderUserRegistrationDataPage(RenderRequest request, RenderResponse response) throws SystemException {
		return "user_registration_data";
	}
	@RenderMapping(params ="action=listuserssearchcontainer")
	public ModelAndView listUserSeachContainer(RenderRequest request, RenderResponse response) throws SystemException {
		return new ModelAndView("list_users_search_container","userList",UserLocalServiceUtil.getUsers(-1, -1));
	}
	//http://www.opensource-techblog.com/2012/09/render-and-action-methods-in-spring-mvc.html
	@ResourceMapping("validateUserbyEmail")
	public void validateUserbyEmailAction(ResourceRequest request,
			ResourceResponse response) throws IOException, PortalException,
			SystemException {
		String emailAddress = ParamUtil.getString(request,"emailAddress");
		ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(com.liferay.portal.kernel.util.WebKeys.THEME_DISPLAY);
		JSONObject jsonUser=JSONFactoryUtil.createJSONObject();
		try {
			User useObject=UserLocalServiceUtil.getUserByEmailAddress(themeDisplay.getCompanyId(), emailAddress);
			if(useObject!=null){
		    logger.info("use is available");	
			jsonUser.put("success",true);
			jsonUser.put("firstName",useObject.getFirstName());
			jsonUser.put("lastName",useObject.getLastName());
			jsonUser.put("email",useObject.getEmailAddress());
			jsonUser.put("screeName",useObject.getScreenName());
			}
			logger.info(jsonUser.toString());
			}
			catch (Exception e) {
			jsonUser.put("success",false);
			logger.error("user not found"+e.getLocalizedMessage());
			}
           logger.info("Resource Method");
           ServletResponseUtil.write(PortalUtil.getHttpServletResponse(response),jsonUser.toString());
	}

	@ActionMapping(params = "action=findUser")
	public void findUserById(ActionRequest actionRequest,
			ActionResponse actionResponse) throws ReadOnlyException,
			ValidatorException, IOException {
		logger.info("deleteSiteAction Method");
		
	}
	@ActionMapping(params = "action=userRegistration")
	public void createAccount(ActionRequest actionRequest,
			ActionResponse actionResponse) throws IOException, PortletException{
			try {
			String firstName = ParamUtil.getString(actionRequest, "firstName",StringPool.BLANK);
			String lastName = ParamUtil.getString(actionRequest, "lastName",StringPool.BLANK);
			String screeName = ParamUtil.getString(actionRequest, "screeName",StringPool.BLANK);
			String emailAddress = ParamUtil.getString(actionRequest,
			"emailAddress",StringPool.BLANK);
			int userGander = ParamUtil.getInteger(actionRequest, "sex",1);
			String address = ParamUtil.getString(actionRequest, "address",StringPool.BLANK);
			logger.info("firstName:"+firstName);
			logger.info("lastName:"+lastName);
			logger.info("screeName:"+screeName);
			logger.info("emailAddress:"+emailAddress);
			logger.info("studentGender:"+userGander);
			logger.info("address:"+address);
			List<String> userData=new LinkedList<String>();
			userData.add(firstName);
			userData.add(lastName);
			userData.add(screeName);
			userData.add(emailAddress);
			String userGenederString=userGander==1?"Male":"Famale";
			userData.add(String.valueOf(userGenederString));
			userData.add(address);
			actionRequest.setAttribute("userData", userData);
			// write logic to add data in database
			logger.info("====From submitted succesfully=====");
			} catch (Exception e) {
				logger.error("user not found"+e.getLocalizedMessage());
			}
			actionResponse.setRenderParameter("action", "viewUserRigistrationData");
			}
}
