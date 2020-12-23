package com.yi.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yi.domain.BoardVO;
import com.yi.domain.CafeVO;
import com.yi.domain.ImageVO;
import com.yi.domain.SearchCriteria;
import com.yi.domain.ZoneVO;
import com.yi.service.BoardService;
import com.yi.service.CafeService;
import com.yi.service.PowerLinkService;

@Controller
@RequestMapping("/user/*")
public class UserHomeController {

	// 서비스
	@Autowired
	private CafeService cafeService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	PowerLinkService powerLinkService;
	
	// 유저 메인 홈
	@RequestMapping(value = "", method = RequestMethod.GET)

	public String userHome(Model model, HttpSession session) throws Exception {
		//영업중으로 등록된 카페개수
		int cafeAllInfo = cafeService.cafeOpenAllCnt();
		session.setAttribute("cafeAllInfo", cafeAllInfo);
		
		//탐방기 개수
		int cafeReviewAllCnt = boardService.cafeReviewAllCnt();
		session.setAttribute("cafeReviewAllCnt", cafeReviewAllCnt);
		
		// 검색 '어디에서'의 지역 리스트 데이터를 출력할 model
		List<ZoneVO> zoneList = boardService.zoneList();
		session.setAttribute("zoneList", zoneList);
		
		//파워링크 & 대표이미지
//		int month = Integer.parseInt(powerLinkService.monthlyCafePostDate());
		int month = 12;
		String postDate = String.format("%02d", month);
		
		// 달이 바뀌면 자동 업데이트
		Date from = new Date();
		SimpleDateFormat fmMonth = new SimpleDateFormat("MM");
		String toMonth = fmMonth.format(from);
		
		if(!toMonth.equals(postDate)) {			
			// 파워링크(월간카페) 정보 업데이트
			cafeService.monthlyCafeUpdate(toMonth);
		}
		
		List<CafeVO> powerList = cafeService.powerLinkCafeList();
		model.addAttribute("powerList",powerList);
		
		List<ImageVO> powerImg = new ArrayList<ImageVO>();
		for(int i=0;i<powerList.size();i++) {
			int cafeNo = powerList.get(i).getCafeNo();
			powerImg.add(cafeService.imgSelect(cafeNo));
		}
		model.addAttribute("powerImg", powerImg);
		
		//당월 신상카페
		List<CafeVO> newCafeList = cafeService.newCafeList();
		model.addAttribute("newCafeList", newCafeList);
		
		List<ImageVO> newCafeImg = new ArrayList<ImageVO>();
		for(int i=0;i<newCafeList.size();i++) {
			int cafeNo = newCafeList.get(i).getCafeNo();
			newCafeImg.add(cafeService.imgSelect(cafeNo));
		}
		model.addAttribute("newCafeImg", newCafeImg);		
		
		//카페베스트리스트 + 카페 별점
		List<CafeVO> bestCafeList = cafeService.monthBestCafe();
		model.addAttribute("bestCafeList", bestCafeList);
		model.addAttribute("bestCafeNumFive", bestCafeList);
		
		List<Double> starpoint = cafeService.monthBestSPoint();
		model.addAttribute("starpoint", starpoint);
		
		List<ImageVO> bestCafeImg = new ArrayList<ImageVO>();
		for(int i=0;i<bestCafeList.size();i++) {
			int cafeNo = bestCafeList.get(i).getCafeNo();
			bestCafeImg.add(cafeService.imgSelect(cafeNo));
		}
		model.addAttribute("bestCafeImg", bestCafeImg);			
		
		//탐방기리스트
		List<BoardVO> rvlist = boardService.cafeReviewMonthBestListHome();
		model.addAttribute("rvlist", rvlist);
		List<ImageVO> rvlistImg = new ArrayList<ImageVO>();
		for(int i=0;i<rvlist.size();i++) {
			int sboardNo = rvlist.get(i).getBoardNo();
			rvlistImg.addAll(boardService.boardImgList(sboardNo));	
		}
		model.addAttribute("rvlistImg", rvlistImg);
		
		
		//실시간 카페 추천 리스트 & 대표이미지
		List<BoardVO> rclist = boardService.recommendboardList();
		model.addAttribute("rclist",rclist);
		
		List<ImageVO> rclistImg = new ArrayList<ImageVO>();
		for(int i=0;i<rclist.size();i++) {
			int sboardNo = rclist.get(i).getBoardNo();
			rclistImg.addAll(boardService.boardImgList(sboardNo));	
		}
		
		model.addAttribute("rclistImg", rclistImg);
		model.addAttribute("error", 0);
		
		//열혈무까인 리스트(종합)
		List<BoardVO> bestUserAll = boardService.bestUserAllBoard();
		model.addAttribute("bestUserAll",bestUserAll);
		
		List<Integer> bestUserAllCnt = boardService.bestUserAllBoardCnt();
		model.addAttribute("bestUserAllCnt",bestUserAllCnt);
		
		//열혈무까인 리스트(전월기준)
		List<BoardVO> bestUser = boardService.bestUserBoard();
		model.addAttribute("bestUser",bestUser);
		
		List<Integer> bestUserCnt = boardService.bestUserBoardCnt();
		model.addAttribute("bestUserCnt",bestUserCnt);
		
		return "/user/userHome";
	}
	
	
	// 레이아웃 샘플페이지 
	@RequestMapping(value = "/userpg", method = RequestMethod.GET)
	public String sample() {
		return "/user/userpg";
	}	

	// 커뮤니티 
	@RequestMapping(value = "/community", method = RequestMethod.GET)
	public String communityHome(Model model) throws Exception {
		//탐방기리스트
		List<BoardVO> rvBestlist = boardService.cafeReviewVoteBestAll();
		model.addAttribute("rvBestlist", rvBestlist);
		
		List<ImageVO> rvBestlistImg = new ArrayList<ImageVO>();
		for(int i=0;i<rvBestlist.size();i++) {
			int sboardNo = rvBestlist.get(i).getBoardNo();
			rvBestlistImg.addAll(boardService.boardImgList(sboardNo));	
		}
		model.addAttribute("rvBestlistImg", rvBestlistImg);
		
		//열혈무까인 리스트(종합)
		List<BoardVO> bestUserAll = boardService.bestUserAllBoard();
		model.addAttribute("bestUserAll",bestUserAll);
		
		List<BoardVO> bestUserBoardInfo = new ArrayList<BoardVO>();
		for(int i=0;i<3;i++) { //3명만
			int bestUserNo = bestUserAll.get(i).getUserNo().getUserNo();
			bestUserBoardInfo.addAll(boardService.bestUserBoardInfo(bestUserNo));
		}
		model.addAttribute("bestUserBoardInfo", bestUserBoardInfo);
		
		List<ImageVO> bestUserBoardImg = new ArrayList<ImageVO>();
		for(int i=0;i<bestUserBoardInfo.size();i++) {
			int sboardNo = bestUserBoardInfo.get(i).getBoardNo();
			bestUserBoardImg.addAll(boardService.boardImgList(sboardNo));	
		}
		
		model.addAttribute("bestUserBoardImg", bestUserBoardImg);	
		
		
		//추천 카페 리스트 - 주천수(종합) & 대표이미지
		List<BoardVO> rcBestlist = boardService.rcRankVoteAll();
		model.addAttribute("rcBestlist",rcBestlist);
		
		List<ImageVO> rcBestlistImg = new ArrayList<ImageVO>();
		for(int i=0;i<rcBestlist.size();i++) {
			int sboardNo = rcBestlist.get(i).getBoardNo();
			rcBestlistImg.addAll(boardService.boardImgList(sboardNo));	
		}
		
		model.addAttribute("rcBestlistImg", rcBestlistImg);	
		
		
		// 추천카페 글번호 뽑기
		List<Integer> recommendBoardNo = boardService.recommedBoardNo();
		Collections.shuffle(recommendBoardNo);
		int boardNo = recommendBoardNo.get(0);
		
		BoardVO vo = boardService.recommendReadByNo(boardNo);
		model.addAttribute("ranRecommend", vo);
		
		return "/user/userCommunityHome";
	}
	
	
}
