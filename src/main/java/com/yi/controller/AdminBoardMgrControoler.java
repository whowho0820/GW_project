package com.yi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yi.domain.BoardVO;
import com.yi.domain.CafeCdt;
import com.yi.domain.CafeVO;
import com.yi.domain.PageMaker;
import com.yi.domain.SearchCriteria;
import com.yi.service.BoardService;
import com.yi.service.CafeService;

import com.yi.domain.PowerLinkVO;
import com.yi.service.CafeService;
import com.yi.service.PowerLinkService;

@Controller
@RequestMapping("/admin/boardMgr/*")
public class AdminBoardMgrControoler {

	@Autowired
	private CafeService service;
	
	@Autowired
	private PowerLinkService powerService;
	
	// 자료실 관리
	@RequestMapping(value = "cafeReviewMgr", method = RequestMethod.GET)
	public String cafeMgr(SearchCriteria cri, Model model) throws Exception {
		CafeVO vo = new CafeVO();
		vo.setCafeCdt(CafeCdt.WAITING);
		
		List<CafeVO> list = service.adminNewCafeList(vo, cri);
		PageMaker pageMater = new PageMaker();
		pageMater.setCri(cri);
		pageMater.setTotalCount(service.cafeWaitingCntAndKeyword(vo, cri));
		
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pageMaker", pageMater);
		
		return "/admin/adminCafeReviewMgr";
	}
	
	// 자료실 관리(등록 승인)
	@RequestMapping(value = "cafeReviewMgr/modify", method = RequestMethod.GET)
	public String cafeMgrModify(int cafeNo ,SearchCriteria cri, Model model) throws Exception {
		
		service.updateNewCafeCdt(cafeNo);
		
		model.addAttribute("page", cri.getPage());
		model.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/boardMgr/cafeReviewMgr";
	}
	
	// 자유게시판 관리
	@RequestMapping(value = "cafeRecomMgr", method = RequestMethod.GET)
	public String userMgr(SearchCriteria cri, Model model) throws Exception {
		CafeVO vo = new CafeVO();
		vo.setCafeCdt(CafeCdt.WAITING); // select 조건 -> where c.cafe_cdt != #{vo.cafeCdt} 이기 때문에 WAITING를 사용
		
		List<CafeVO> list = service.adminCafeList(vo, cri);
		PageMaker pageMater = new PageMaker();
		pageMater.setCri(cri);
		pageMater.setTotalCount(service.cafeWaitingCntAndKeyword(vo, cri));
		
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pageMaker", pageMater);
		return "/admin/adminCafeRecomMgr";
	}
	
	// 자유게시판 관리(운영/폐업 등록)
	@RequestMapping(value = "cafeRecomMgr/modify", method = RequestMethod.GET)
	public String userMgrModify(int cafeNo, int cafeCdt, SearchCriteria cri, Model model) throws Exception {
		CafeVO vo = new CafeVO();
		vo.setCafeNo(cafeNo);
		
		if(cafeCdt == 2) {
			vo.setCafeCdt(CafeCdt.CLOSING);
		} 
		
		service.updateCafeCdt(vo);
		
		model.addAttribute("page", cri.getPage());
		model.addAttribute("keyword", cri.getKeyword());
		return "redirect:/admin/boardMgr/cafeRecomMgr";
	}
	
	
	// 공지사항
	@RequestMapping(value = "noticeMgr", method = RequestMethod.GET)
	public String noticeMgr(SearchCriteria cri, Model model) throws Exception {
		cri.setPerPageNum(20);
		
		List<PowerLinkVO> list = powerService.selectAdminMonCafeList(cri);
		
		PageMaker pageMater = new PageMaker();
		pageMater.setCri(cri);
		pageMater.setTotalCount(powerService.selectAdminMonCafeTotalCnt(cri));
		
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pageMaker", pageMater);
		return "/admin/adminnoticeMgr";
	}	
	
	// 공지사항(게시일 등록)
	@RequestMapping(value = "noticeMgr/modify", method = RequestMethod.GET)
	public String noticeMgrModify(int powNo, SearchCriteria cri, Model model) throws Exception {
		
		powerService.updateAdminMonCafePostDate(powNo);
		
		model.addAttribute("page", cri.getPage());
		model.addAttribute("keyword", cri.getKeyword());
		return "redirect:/admin/boardMgr/noticeMgr";
	}	
	
	// 공지사항(게시일 등록 취소)
	@RequestMapping(value = "noticeMgr/cancelModify", method = RequestMethod.GET)
	public String noticeMgrCancelModify(int powNo, int year, int month, SearchCriteria cri, Model model) throws Exception {
		
		powerService.updateAdminMonCafePostCancel(powNo, year, month);
		
		model.addAttribute("page", cri.getPage());
		model.addAttribute("keyword", cri.getKeyword());
		return "redirect:/admin/boardMgr/noticeMgr";
	}	
}
