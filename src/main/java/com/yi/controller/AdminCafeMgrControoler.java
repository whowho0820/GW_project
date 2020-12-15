package com.yi.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yi.domain.CafeCdt;
import com.yi.domain.CafeVO;
import com.yi.domain.PageMaker;
import com.yi.domain.PowerLinkVO;
import com.yi.domain.SearchCriteria;
import com.yi.service.CafeService;
import com.yi.service.PowerLinkService;

import gu.admin.organ.DeptSvc;
import gu.admin.organ.UserSvc;
import gu.admin.sign.SignDocSvc;
import gu.admin.sign.SignDocTypeVO;
import gu.common.SearchVO;
import gu.common.TreeMaker;
import gu.etc.EtcSvc;
import gu.sign.SignDocVO;
import gu.sign.SignSvc;
import gu.sign.SignVO;

@Controller
@RequestMapping("/admin/cafeMgn/*")
public class AdminCafeMgrControoler {
	
	@Autowired
	private CafeService service;
	
	@Autowired
	private PowerLinkService powerService;
	
    @Autowired
    private SignDocSvc signDocSvc;

    @Autowired
    private SignSvc signSvc;

    @Autowired
    private EtcSvc etcSvc; 
    
    @Autowired
    private DeptSvc deptSvc;
    
    @Autowired
    private UserSvc userSvc;
	
//	//결재 받을 문서
//	@RequestMapping(value = "newCafeManager", method = RequestMethod.GET)
//	public String newCafe(SearchCriteria cri, Model model) throws Exception {
//		CafeVO vo = new CafeVO();
//		vo.setCafeCdt(CafeCdt.WAITING);
//		
//		List<CafeVO> list = service.adminNewCafeList(vo, cri);
//		PageMaker pageMater = new PageMaker();
//		pageMater.setCri(cri);
//		pageMater.setTotalCount(service.cafeWaitingCntAndKeyword(vo, cri));
//		
//		model.addAttribute("list", list);
//		model.addAttribute("cri", cri);
//		model.addAttribute("pageMaker", pageMater);
//		return "/admin/adminNewCafeMgr";
//	}		
//	
	// 등록 승인
	@RequestMapping(value = "newCafeManager/modify", method = RequestMethod.GET)
	public String newCafeModify(int cafeNo ,SearchCriteria cri, Model model) throws Exception {
		
		service.updateNewCafeCdt(cafeNo);
		
		model.addAttribute("page", cri.getPage());
		model.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/cafeMgn/newCafeManager";
	}
	
	// 결재할 문서
	@RequestMapping(value = "cafeManager", method = RequestMethod.GET)
	public String cafeMgr(SearchCriteria cri, Model model) throws Exception {
		CafeVO vo = new CafeVO();
		vo.setCafeCdt(CafeCdt.WAITING); // select 조건 -> where c.cafe_cdt != #{vo.cafeCdt} 이기 때문에 WAITING를 사용
		
		List<CafeVO> list = service.adminCafeList(vo, cri);
		PageMaker pageMater = new PageMaker();
		pageMater.setCri(cri);
		pageMater.setTotalCount(service.cafeWaitingCntAndKeyword(vo, cri));
		
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pageMaker", pageMater);
		
		return "/admin/adminCafeMgr";
	}
	
	// 카페 운영/폐업 등록
	@RequestMapping(value = "cafeManager/modify", method = RequestMethod.GET)
	public String cafeMgrModify(int cafeNo, int cafeCdt, SearchCriteria cri, Model model) throws Exception {
		CafeVO vo = new CafeVO();
		vo.setCafeNo(cafeNo);
		
		if(cafeCdt == 2) {
			vo.setCafeCdt(CafeCdt.CLOSING);
		} 
		
		service.updateCafeCdt(vo);
		
		model.addAttribute("page", cri.getPage());
		model.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/cafeMgn/cafeManager";
	}
	
	
	//기안하기
	@RequestMapping(value = "monthCafeManager", method = RequestMethod.GET)
	public String monthCafeMgr(SearchCriteria cri, Model model) throws Exception {
		cri.setPerPageNum(20);
		
		List<PowerLinkVO> list = powerService.selectAdminMonCafeList(cri);
		
		PageMaker pageMater = new PageMaker();
		pageMater.setCri(cri);
		pageMater.setTotalCount(powerService.selectAdminMonCafeTotalCnt(cri));
		
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pageMaker", pageMater);
		
		return "/admin/adminMonthCafeMgr";
	}
	
	//월간 카페 등록 및 관리
		@RequestMapping(value = "monthCafeManager2", method = RequestMethod.GET)
		public String monthCafeMgr2(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) throws Exception {

	    	String userno = request.getSession().getAttribute("userno").toString();
	        
	    	etcSvc.setCommonAttribute(userno, modelMap);
	    	
	        // 
	        searchVO.setUserno(userno);
	        searchVO.pageCalculate( signSvc.selectSignDocTobeCount(searchVO) ); // startRow, endRow
	        List<?> listview  = signSvc.selectSignDocTobeList(searchVO);
	        
	        modelMap.addAttribute("searchVO", searchVO);
	        modelMap.addAttribute("listview", listview);			
			
			
			return "/admin/adminMonthCafeMgr2";
		}
		
		 /** 
	     * 쓰기. 
	     */
	    @RequestMapping(value = "/adSignDocTypeForm")
	    public String signDocTypeForm(HttpServletRequest request, SignDocTypeVO signInfo, ModelMap modelMap) {
	        // 페이지 공통: alert
			String auth = request.getSession().getAttribute("Auth").toString(); 
	    	String userno = request.getSession().getAttribute("userno").toString();
			String authno = request.getSession().getAttribute("AuthNo").toString(); 
	        
	        etcSvc.setCommonAttribute(userno, modelMap);
	    	
	        // 개별 작업
	        if (signInfo.getDtno() != null) {
	            signInfo = signDocSvc.selectSignDocTypeOne(signInfo.getDtno());
	        
	            modelMap.addAttribute("signInfo", signInfo);
	        }
	        
	        return "admin/SignDocTypeForm";
	    }
	    
	    /**
	     * 저장.
	     */
	    @RequestMapping(value = "/adSignDocTypeSave")
	    public String signDocTypeSave(HttpServletRequest request, SignDocTypeVO signInfo, ModelMap modelMap) {
	    	
	        signDocSvc.insertSignDocType(signInfo);

	        return "redirect:/admin/cafeMgn/monthCafeManager2";
	    }

	    /**
	     * 삭제.
	     */
	    @RequestMapping(value = "/adSignDocTypeDelete")
	    public String signDocTypeDelete(HttpServletRequest request, SignDocTypeVO signVO) {

	        signDocSvc.deleteSignDocType(signVO);
	        
	        return "redirect:/admin/cafeMgn/monthCafeManager2";
	    }
	   		
	    /**
	     * 결제 받을 문서 리스트.
	     */
	    @RequestMapping(value = "newCafeManager")
	    public String newCafeManager(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
	        // 페이지 공통: alert
	    	String auth = request.getSession().getAttribute("Auth").toString(); 
	    	String userno = request.getSession().getAttribute("userno").toString();
			String authno = request.getSession().getAttribute("AuthNo").toString();
	        
	        etcSvc.setCommonAttribute(userno, modelMap);
	    	
	        // 
	        searchVO.setUserno(userno);
	        searchVO.pageCalculate( signSvc.selectSignDocTobeCount(searchVO) ); // startRow, endRow
	        List<?> listview  = signSvc.selectSignDocTobeList(searchVO);
	        
	        modelMap.addAttribute("searchVO", searchVO);
	        modelMap.addAttribute("listview", listview);
	        
	        return "/admin/adminNewCafeMgr";
	    }

	    /**
	     * 결제 할 문서 리스트.
	     */
	    @RequestMapping(value = "cafeManager")
	    public String cafeManager(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
	        // 페이지 공통: alert
	    	String auth = request.getSession().getAttribute("Auth").toString(); 
	    	String userno = request.getSession().getAttribute("userno").toString();
			String authno = request.getSession().getAttribute("AuthNo").toString();
	        
	        etcSvc.setCommonAttribute(userno, modelMap);
	    	
	        //
	        if (searchVO.getSearchExt1()==null || "".equals(searchVO.getSearchExt1())) searchVO.setSearchExt1("sign");
	        searchVO.setUserno(userno);
	        searchVO.pageCalculate( signSvc.selectSignDocCount(searchVO) ); // startRow, endRow
	        List<?> listview  = signSvc.selectSignDocList(searchVO);
	        
	        modelMap.addAttribute("searchVO", searchVO);
	        modelMap.addAttribute("listview", listview);
	        
	        return "/admin/adminCafeMgr";
	    }
	    
	    /** 
	     * 기안하기. 
	     */
	    @RequestMapping(value = "monthCafeManagerFormList")
	    public String signDocTypeList(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
	        // 페이지 공통: alert
	    	String auth = request.getSession().getAttribute("Auth").toString(); 
	    	String userno = request.getSession().getAttribute("userno").toString();
			String authno = request.getSession().getAttribute("AuthNo").toString();
	        
	        etcSvc.setCommonAttribute(userno, modelMap);
	    	List<?> listview  = signDocSvc.selectSignDocTypeList(searchVO);
	        
	        modelMap.addAttribute("listview", listview);
	        
	        return "/admin/adminMonthCafeMgrFormList";
	    }
	    
	    @RequestMapping(value = "/signDocForm")
	    public String signDocForm(HttpServletRequest request, SignDocVO signDocInfo, ModelMap modelMap) {
	        // 페이지 공통: alert
	    	String auth = request.getSession().getAttribute("Auth").toString(); 
	    	String userno = request.getSession().getAttribute("userno").toString();
			String authno = request.getSession().getAttribute("AuthNo").toString();
	        
	        etcSvc.setCommonAttribute(userno, modelMap);
	    	
	        // 개별 작업
	        List<?> signlist = null;
	        if (signDocInfo.getDocno() == null) {	// 신규
	        	signDocInfo.setDocstatus("1");
	        	SignDocTypeVO docType = signDocSvc.selectSignDocTypeOne(signDocInfo.getDtno());
	        	signDocInfo.setDtno(docType.getDtno());
	        	signDocInfo.setDoccontents(docType.getDtcontents());
	        	signDocInfo.setUserno(userno);
	        	// 사번, 이름, 기안/합의/결제, 직책
	            signlist = signSvc.selectSignLast(signDocInfo);
	            String signPath = "";
	            for (int i=0; i<signlist.size();i++){
	            	SignVO svo = (SignVO) signlist.get(i);
	            	signPath += svo.getUserno() + "," + svo.getUsernm() + "," + svo.getSstype() + "," + svo.getUserpos() + "||";  
	            }
	            signDocInfo.setDocsignpath(signPath);
	        } else {								// 수정
	            signDocInfo = signSvc.selectSignDocOne(signDocInfo);
	            signlist = signSvc.selectSign(signDocInfo.getDocno());
	        }
	        modelMap.addAttribute("signDocInfo", signDocInfo);
	        modelMap.addAttribute("signlist", signlist);
	        
	        return "/admin/adminMonthCafeMgrForm";
	    }
	    
	    /**
	     * 저장.
	     */
	    @RequestMapping(value = "/signDocSave")
	    public String signDocSave(HttpServletRequest request, SignDocVO signDocInfo, ModelMap modelMap) {
	        
	    	String auth = request.getSession().getAttribute("Auth").toString(); 
	    	String userno = request.getSession().getAttribute("userno").toString();
			String authno = request.getSession().getAttribute("AuthNo").toString();
			
	    	signDocInfo.setUserno(userno);
	    	
	        signSvc.insertSignDoc(signDocInfo);

	        return "redirect:/admin/cafeMgn/newCafeManager";
	    }

	    /**
	     * 읽기.
	     */
	    @RequestMapping(value = "/signDocRead")
	    public String signDocRead(HttpServletRequest request, SignDocVO SignDocVO, ModelMap modelMap) {
	        // 페이지 공통: alert
	    	String auth = request.getSession().getAttribute("Auth").toString(); 
	    	String userno = request.getSession().getAttribute("userno").toString();
			String authno = request.getSession().getAttribute("AuthNo").toString();
	        
	        etcSvc.setCommonAttribute(userno, modelMap);
	    	
	        // 개별 작업
	        
	        SignDocVO signDocInfo = signSvc.selectSignDocOne(SignDocVO);
	        List<? >signlist = signSvc.selectSign(signDocInfo.getDocno());
	        String signer = signSvc.selectCurrentSigner(SignDocVO.getDocno());
	        
	        modelMap.addAttribute("signDocInfo", signDocInfo);
	        modelMap.addAttribute("signlist", signlist);
	        modelMap.addAttribute("signer", signer);
	        
	        return "admin/SignDocRead";
	    }
	    
	    /**
	     * 삭제.
	     */
	    @RequestMapping(value = "/signDocDelete")
	    public String signDocDelete(HttpServletRequest request, SignDocVO SignDocVO) {

	        signSvc.deleteSignDoc(SignDocVO);
	        
	        return "redirect:/admin/cafeMgn/cafeManager";
	    }

	    /**
	     * 결재.
	     */
	    @RequestMapping(value = "/signSave")
	    public String signSave(HttpServletRequest request, SignVO signInfo) {

	        signSvc.updateSign(signInfo);
	        
	        return "redirect:/admin/cafeMgn/newCafeManager";
	    }
	    /**
	     * 회수.
	     */
	    @RequestMapping(value = "/signDocCancel")
	    public String signDocCancel(HttpServletRequest request, String docno) {
	        signSvc.updateSignDocCancel(docno);
	        
	        return "redirect:/admin/cafeMgn/newCafeManager";
	    }	  
	    
	    /** 기안하기 결재 경로 모달창
	     * 부서리스트.
	     */
	    @RequestMapping(value = "/popupDept")
	       public String popupDept(ModelMap modelMap) {
	        List<?> listview   = deptSvc.selectDepartment();

	        TreeMaker tm = new TreeMaker();
	        String treeStr = tm.makeTreeByHierarchy(listview);
	        
	        modelMap.addAttribute("treeStr", treeStr);
	        
	        return "etc/popupDept";
	    }

	    /**
	     *  부서리스트 for 사용자.
	     */
	    @RequestMapping(value = "/popupUser")
	    public String popupUser(ModelMap modelMap) {
	        List<?> listview   = deptSvc.selectDepartment();

	        TreeMaker tm = new TreeMaker();
	        String treeStr = tm.makeTreeByHierarchy(listview);
	        
	        modelMap.addAttribute("treeStr", treeStr);
	        
	        return "etc/popupUser";
	    }
	    
	    /**
	     * 선택된 부서의 User 리스트.
	     */
	    @RequestMapping(value = "/popupUsersByDept")
	    public String popupUsersByDept(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
	        String deptno = request.getParameter("deptno");
	        searchVO.setSearchExt1(deptno);
	        
	        List<?> listview  = userSvc.selectUserListWithDept(searchVO);
	        
	        modelMap.addAttribute("listview", listview);
	        
	        return "etc/popupUsersByDept";
	    }
	    
	    /**
	     *  부서리스트 for 사용자들.
	     */
	    @RequestMapping(value = "/popupUsers")
	    public String popupUsers(ModelMap modelMap) {
	        popupUser(modelMap);
	        
	        return "etc/popupUsers";
	    }

	    /**
	     *  부서리스트 for 사용자들 - 결재 경로 지정용.
	     */
	    @RequestMapping(value = "/popupUsers4SignPath")
	    public String popupUsers4SignPath(ModelMap modelMap) {
	        popupUser(modelMap);
	        
	        return "etc/popupUsers4SignPath";
	    }
	    
	    /**
	     * User 리스트  for 사용자들.
	     */
	    @RequestMapping(value = "/popupUsers4Users")
	    public String popupUsers4Users(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
	        popupUsersByDept(request, searchVO, modelMap);
	        
	        return "etc/popupUsers4Users";
	    }    
	
	// 월간 카페 게시일 등록
	@RequestMapping(value = "monthCafeManager/modify", method = RequestMethod.GET)
	public String monthCafeMgrModify(int powNo, SearchCriteria cri, Model model) throws Exception {
		
		powerService.updateAdminMonCafePostDate(powNo);
		
		model.addAttribute("page", cri.getPage());
		model.addAttribute("keyword", cri.getKeyword());
		return "redirect:/admin/cafeMgn/monthCafeManager";
	}
	
	// 월간 카페 게시등록 취소
	@RequestMapping(value = "monthCafeManager/cancelModify", method = RequestMethod.GET)
	public String monthCafeMgrCancelModify(int powNo, int year, int month, SearchCriteria cri, Model model) throws Exception {
		
		powerService.updateAdminMonCafePostCancel(powNo, year, month);
		
		model.addAttribute("page", cri.getPage());
		model.addAttribute("keyword", cri.getKeyword());
//		return "/admin/cafeMgn/monthCafeManager";
		return "redirect:/admin/cafeMgn/monthCafeManager";
	}
}
