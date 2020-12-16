package com.yi.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yi.domain.AdminVO;
import com.yi.domain.PageMaker;
import com.yi.domain.SearchCriteria;
import com.yi.service.AdminService;

import gu.admin.organ.DepartmentVO;
import gu.admin.organ.DeptSvc;
import gu.admin.organ.UserSvc;
import gu.common.FileUtil;
import gu.common.FileVO;
import gu.common.TreeMaker;
import gu.common.UtilEtc;
import gu.etc.EtcSvc;
import gu.member.UserVO;



@Controller
@RequestMapping("/admin/userMgr/*")
public class AdminUserMgrControoler {
	
    @Autowired
    private DeptSvc deptSvc;
    
    @Autowired
    private UserSvc userSvc;
    
    @Autowired
    private EtcSvc etcSvc;
	
    @Autowired private AdminService adminService;
    
     // 리스트
     
    @RequestMapping(value = "/cafeUserManager")
       public String department(HttpServletRequest request, ModelMap modelMap) {

		String auth = request.getSession().getAttribute("Auth").toString(); 
    	String userno = request.getSession().getAttribute("userId").toString();
		String authno = request.getSession().getAttribute("AuthNo").toString(); 
   
        etcSvc.setCommonAttribute(userno, modelMap);

        List<?> listview   = deptSvc.selectDepartment();

        TreeMaker tm = new TreeMaker();

        String treeStr = tm.makeTreeByHierarchy(listview);

        modelMap.addAttribute("treeStr", treeStr);

        return "/admin/adminCafeUserMgr";
    }
     
    //부서 등록
     
    @RequestMapping(value = "/adDepartmentSave")
       public void departmentSave(HttpServletResponse response, DepartmentVO deptInfo) {
        
        deptSvc.insertDepartment(deptInfo);
        
        UtilEtc.responseJsonValue(response, deptInfo);
    }

    
      // 부서 정보(하나)
     
    @RequestMapping(value = "/adDepartmentRead")
       public void departmentRead(HttpServletRequest request, HttpServletResponse response) {
        
        String deptno = request.getParameter("deptno");
        
        DepartmentVO deptInfo = deptSvc.selectDepartmentOne(deptno);
        
        UtilEtc.responseJsonValue(response, deptInfo);
    }
    
    
     // 부서 삭제
     
    @RequestMapping(value = "/adDepartmentDelete")
       public void departmentDelete(HttpServletRequest request, HttpServletResponse response) {
        
        String deptno = request.getParameter("deptno");
        
        deptSvc.deleteDepartment(deptno);
        
        UtilEtc.responseJsonValue(response, "OK");
    }
    
	//리스트
    
    @RequestMapping(value = "/userManager")
    public String user(HttpServletRequest request, ModelMap modelMap) {
    
	 String auth = request.getSession().getAttribute("Auth").toString(); 
	 String userno = request.getSession().getAttribute("userId").toString();
	 String authno = request.getSession().getAttribute("AuthNo").toString(); 	
         
     etcSvc.setCommonAttribute(userno, modelMap);
     
     List<?> listview   = deptSvc.selectDepartment();

     TreeMaker tm = new TreeMaker();
     String treeStr = tm.makeTreeByHierarchy(listview);
     
     modelMap.addAttribute("treeStr", treeStr);
     
     return "admin/adminUserMgr";
    }
    
    
     // User 리스트.
   
    @RequestMapping(value = "/adUserList")
    public String userList(HttpServletRequest request, ModelMap modelMap) {
        String deptno = request.getParameter("deptno");

        return common_UserList(modelMap, deptno);
    }
    
    
     // 지정된 부서의 사용자 리스트.     
     
    public String common_UserList(ModelMap modelMap, String deptno) {

        List<?> listview  = userSvc.ad_selectUserList(deptno);
        
        modelMap.addAttribute("listview", listview);
        
        return "admin/UserList";
    }
    
   
    // 사용자 저장.
    // 신규 사용자는 저장 전에 중복 확인 
    
    @RequestMapping(value = "/adUserSave")
    public String userSave(HttpServletResponse response, ModelMap modelMap, UserVO userInfo) {

        if (userInfo.getUserno() == null || "".equals(userInfo.getUserno())) {
            String userid = userSvc.selectUserID(userInfo.getUserid());
            if (userid != null) {
                return "common/blank"; 
            }
        }
        FileUtil fs = new FileUtil();
        FileVO fileInfo = fs.saveFile(userInfo.getPhotofile());
        if (fileInfo != null) {
            userInfo.setPhoto(fileInfo.getRealname());
        }
        userSvc.insertUser(userInfo);

        return common_UserList(modelMap, userInfo.getDeptno());
    }
    
    
    // ID 중복 확인.
     
    @RequestMapping(value = "/chkUserid")
    public void chkUserid(HttpServletRequest request, HttpServletResponse response) {
        String userid = request.getParameter("userid");

        userid = userSvc.selectUserID(userid);

        UtilEtc.responseJsonValue(response, userid);
    }
    
    
     // 사용자 조회.
     
    @RequestMapping(value = "/adUserRead")
    public void userRead(HttpServletRequest request, HttpServletResponse response) {
        String userno = request.getParameter("userno");
        
        UserVO userInfo = userSvc.selectUserOne(userno);

        UtilEtc.responseJsonValue(response, userInfo);
    }
    
    
     // 사용자 삭제.
     
    @RequestMapping(value = "/adUserDelete")
    public String userDelete(HttpServletRequest request, ModelMap modelMap, UserVO userInfo) {
        
        userSvc.deleteUser(userInfo.getUserno());
        
        return common_UserList(modelMap, userInfo.getDeptno());
    }
	
	 
	  // 관리자 관리
	  
	  @RequestMapping(value = "adminManager", method = RequestMethod.GET) public
	  String adminMgr(SearchCriteria cri, Model model) throws Exception {
	  
	  List<AdminVO> list = adminService.selectAdminList(cri);
	 
	  PageMaker pageMaker = new PageMaker(); pageMaker.setCri(cri);
	  pageMaker.setTotalCount(adminService.selectAdminTotalCnt(cri));
	  
	  model.addAttribute("list", list); model.addAttribute("cri", cri);
	  model.addAttribute("pageMaker", pageMaker);
	  
	  return "/admin/adminAdmMgr"; 
	  }
    
	/*
	 * @Autowired private UsersService service;
	 * 
	 * @Autowired private AdminService adminService; // 카페 점주 관리
	 * 
	 * @RequestMapping(value = "cafeUserManager", method = RequestMethod.GET) public
	 * String cafeMgr(SearchCriteria cri, Model model) throws Exception { int
	 * userType = 1;
	 * 
	 * List<UsersVO> list = service.selectUserList(userType, cri); PageMaker
	 * pageMaker = new PageMaker(); pageMaker.setCri(cri);
	 * pageMaker.setTotalCount(service.selectUserListTotalCnt(userType, cri));
	 * 
	 * model.addAttribute("list", list); model.addAttribute("cri", cri);
	 * model.addAttribute("pageMaker", pageMaker); return "/admin/adminCafeUserMgr";
	 * }
	 * 
	 * // 회원 관리
	 * 
	 * @RequestMapping(value = "userManager", method = RequestMethod.GET) public
	 * String userMgr(SearchCriteria cri, Model model) throws Exception { int
	 * userType = 2;
	 * 
	 * List<UsersVO> list = service.selectUserList(userType, cri); PageMaker
	 * pageMaker = new PageMaker(); pageMaker.setCri(cri);
	 * pageMaker.setTotalCount(service.selectUserListTotalCnt(userType, cri));
	 * 
	 * model.addAttribute("list", list); model.addAttribute("cri", cri);
	 * model.addAttribute("pageMaker", pageMaker);
	 * 
	 * return "/admin/adminUserMgr"; }
	 */
	 
}
