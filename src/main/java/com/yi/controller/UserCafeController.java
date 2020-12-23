package com.yi.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yi.domain.BoardVO;
import com.yi.domain.CafeVO;
import com.yi.domain.ImageVO;
import com.yi.domain.MenuKindsVO;
import com.yi.domain.MenuVO;
import com.yi.domain.PageMaker;
import com.yi.domain.SearchCriteria;
import com.yi.domain.ThemeVO;
import com.yi.service.BoardService;
import com.yi.service.CafeService;
import com.yi.service.PowerLinkService;
import com.yi.service.ThemeService;

@Controller
@RequestMapping("/user/*")
public class UserCafeController {
	
	// 서비스
	@Autowired
	CafeService service;
	
	@Autowired
	private CafeService cafeService;
	
	@Autowired
	ThemeService themeService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	PowerLinkService powerLinkService;
	
	// 커피무까
		@RequestMapping(value = "/mukkaCafe", method = RequestMethod.GET)
		public String cafeHome(SearchCriteria cri, Model model) throws Exception {
			
			// 영업중인 카페 번호 리스트로 가져오기
			List<Integer> openCafeNo = cafeService.openCafeNoList();
			// shuffle 이용해서 랜덤으로 숫자뿌리기
			Collections.shuffle(openCafeNo);
			
			// 위치별 -- 영업카페번호 랜덤 3곳
			int zoneCafeNo1 = openCafeNo.get(0); // 첫번째 영업중인 카페 랜덤번호
			openCafeNo.remove(0); // -- 첫번째 랜덤번호 지우기
			int zoneCafeNo2 = openCafeNo.get(0); // 새로운 영업중인 카페 랜덤번호 생성
			openCafeNo.remove(0);  // -- 두번째 랜덤번호 지우기
			int zoneCafeNo3 = openCafeNo.get(0);
			
			
			// 위치별 - 랜덤카페(1)
			CafeVO zoneCafe1 = cafeService.readCafe(zoneCafeNo1);
			ImageVO zoneImg1 = cafeService.imgSelect(zoneCafeNo1);
			model.addAttribute("zoneCafe1", zoneCafe1);
			model.addAttribute("zoneImg1",zoneImg1);
			
			// 위치별 - 랜덤카페(2)
			CafeVO zoneCafe2 = cafeService.readCafe(zoneCafeNo2);
			ImageVO zoneImg2 = cafeService.imgSelect(zoneCafeNo2);
			model.addAttribute("zoneCafe2", zoneCafe2);
			model.addAttribute("zoneImg2",zoneImg2);
			
			// 위치별 - 랜덤카페(3)
			CafeVO zoneCafe3 = cafeService.readCafe(zoneCafeNo3);
			ImageVO zoneImg3 = cafeService.imgSelect(zoneCafeNo3);
			model.addAttribute("zoneCafe3", zoneCafe3);
			model.addAttribute("zoneImg3",zoneImg3);
			
			//카페 조회순 리스트
			List<CafeVO> viewCafeList = cafeService.viewNumberCafeListAll();
			model.addAttribute("viewCafeList", viewCafeList);

			List<ImageVO> viewCafeListImg = new ArrayList<ImageVO>();
			for(int i=0;i<viewCafeList.size();i++) {
				int cafeNo = viewCafeList.get(i).getCafeNo();
				viewCafeListImg.add(cafeService.imgSelect(cafeNo));
			}
			model.addAttribute("viewCafeListImg", viewCafeListImg);		
			
			// 카페 별점 순 리스트
			List<CafeVO> starPointCafeList = cafeService.starPointCafeBest5Info();
			model.addAttribute("starPointCafeList", starPointCafeList);
			
			List<Double> starPoint = cafeService.starPointCafeBest5();
			model.addAttribute("starPoint", starPoint);	
			
			//각 대표 테마별로 영업중인카페번호 리스트 가져오기
			int [] themeNo = {1,2,3,4,5,6}; // 1:데이트, 2:뷰, 3:착한아메, 4:디저트, 5:댕댕이, 6:작업
			
			// 키워드 : 데이트 - 랜덤카페
			List<Integer> openThemeCafeNo1 = cafeService.openThemeCafeNoList(themeNo[0]);
			//Math.random 이용해서 랜덤숫자 뿌리기
			int ran1 = (int)(Math.random()*openThemeCafeNo1.size()-1);
			int tCafeNo1 = openThemeCafeNo1.get(ran1);
			openThemeCafeNo1.remove(ran1);
			
			CafeVO themeCafe1 = cafeService.readCafe(tCafeNo1);
			ImageVO themeCafeImg1 = cafeService.imgSelect(tCafeNo1);
			model.addAttribute("themeCafe1", themeCafe1);
			model.addAttribute("themeCafeImg1",themeCafeImg1);
			
			// 키워드 : 뷰 - 랜덤카페
			List<Integer> openThemeCafeNo2 = cafeService.openThemeCafeNoList(themeNo[1]);
			//Math.random 이용해서 랜덤숫자 뿌리기
			int ran2 = (int)(Math.random()*openThemeCafeNo2.size()-1);
			int tCafeNo2 = openThemeCafeNo2.get(ran2);
			openThemeCafeNo2.remove(ran2);
			
			CafeVO themeCafe2 = cafeService.readCafe(tCafeNo2);
			ImageVO themeCafeImg2 = cafeService.imgSelect(tCafeNo2);
			model.addAttribute("themeCafe2", themeCafe2);
			model.addAttribute("themeCafeImg2",themeCafeImg2);
			
			// 키워드 : 착한아메 - 랜덤카페
			List<Integer> openThemeCafeNo3 = cafeService.openThemeCafeNoList(themeNo[2]);
			//Math.random 이용해서 랜덤숫자 뿌리기
			int ran3 = (int)(Math.random()*openThemeCafeNo3.size()-1);
			int tCafeNo3 = openThemeCafeNo3.get(ran3);
			openThemeCafeNo3.remove(ran3);
			
			CafeVO themeCafe3 = cafeService.readCafe(tCafeNo3);
			ImageVO themeCafeImg3 = cafeService.imgSelect(tCafeNo3);
			model.addAttribute("themeCafe3", themeCafe3);
			model.addAttribute("themeCafeImg3",themeCafeImg3);
			
			// 키워드 : 디저트 - 랜덤카페
			List<Integer> openThemeCafeNo4 = cafeService.openThemeCafeNoList(themeNo[3]);
			//Math.random 이용해서 랜덤숫자 뿌리기
			int ran4 = (int)(Math.random()*openThemeCafeNo4.size()-1);
			int tCafeNo4 = openThemeCafeNo4.get(ran4);
			openThemeCafeNo1.remove(ran4);
			
			CafeVO themeCafe4 = cafeService.readCafe(tCafeNo4);
			ImageVO themeCafeImg4 = cafeService.imgSelect(tCafeNo4);
			model.addAttribute("themeCafe4", themeCafe4);
			model.addAttribute("themeCafeImg4",themeCafeImg4);
			
			// 키워드 : 댕댕이 - 랜덤카페
			List<Integer> openThemeCafeNo5 = cafeService.openThemeCafeNoList(themeNo[4]);
			//Math.random 이용해서 랜덤숫자 뿌리기
			int ran5 = (int)(Math.random()*openThemeCafeNo5.size()-1);
			int tCafeNo5 = openThemeCafeNo5.get(ran5);
			openThemeCafeNo5.remove(ran5);
			CafeVO themeCafe5 = cafeService.readCafe(tCafeNo5);
			ImageVO themeCafeImg5 = cafeService.imgSelect(tCafeNo5);
			model.addAttribute("themeCafe5", themeCafe5);
			model.addAttribute("themeCafeImg5",themeCafeImg5);
			
			// 키워드 : 작업 - 랜덤카페
			List<Integer> openThemeCafeNo6 = cafeService.openThemeCafeNoList(themeNo[5]);
			//Math.random 이용해서 랜덤숫자 뿌리기
			int ran6 = (int)(Math.random()*openThemeCafeNo6.size()-1);
			int tCafeNo6 = openThemeCafeNo6.get(ran6);
			openThemeCafeNo6.remove(ran6);
			
			CafeVO themeCafe6 = cafeService.readCafe(tCafeNo6);
			ImageVO themeCafeImg6 = cafeService.imgSelect(tCafeNo6);
			model.addAttribute("themeCafe6", themeCafe6);
			model.addAttribute("themeCafeImg6",themeCafeImg6);
			
			//각테마번호 배열 랜덤으로 돌리기
			int[] ranThemeNo = shuffle(themeNo); //테마번호 랜덤하게 돌리기
			List<Integer> openThemeCafeNo7 = cafeService.openThemeCafeNoList(ranThemeNo[0]);
			
			// shuffle 이용해서 랜덤으로 카페번호 뿌리기
			Collections.shuffle(openThemeCafeNo7);
			
			// 위치별 -- 영업카페번호 랜덤 3곳
			int themeGroupNo1 = openThemeCafeNo7.get(0); // 첫번째 영업중인 카페 랜덤번호
			openThemeCafeNo7.remove(0); // -- 첫번째 랜덤번호 지우기
			int themeGroupNo2 = openThemeCafeNo7.get(0); // 새로운 영업중인 카페 랜덤번호 생성
			openThemeCafeNo7.remove(0);  // -- 두번째 랜덤번호 지우기
			int themeGroupNo3 = openThemeCafeNo7.get(0);
			openThemeCafeNo7.remove(0);  // -- 세번째 랜덤번호 지우기
			int themeGroupNo4 = openThemeCafeNo7.get(0);
			
			
			// 테마별 - 랜덤카페(1)
			CafeVO themeGroupCafe1 = cafeService.readCafe(themeGroupNo1);
			ImageVO themeGroupImg1 = cafeService.imgSelect(themeGroupNo1);
			model.addAttribute("themeGroupCafe1", themeGroupCafe1);
			model.addAttribute("themeGroupImg1",themeGroupImg1);
			
			// 테마별- 랜덤카페(2)
			CafeVO themeGroupCafe2 = cafeService.readCafe(themeGroupNo2);
			ImageVO themeGroupImg2 = cafeService.imgSelect(themeGroupNo2);
			model.addAttribute("themeGroupCafe2", themeGroupCafe2);
			model.addAttribute("themeGroupImg2",themeGroupImg2);
			
			// 테마별 - 랜덤카페(3)
			CafeVO themeGroupCafe3 = cafeService.readCafe(themeGroupNo3);
			ImageVO themeGroupImg3 = cafeService.imgSelect(themeGroupNo3);
			model.addAttribute("themeGroupCafe3", themeGroupCafe3);
			model.addAttribute("themeGroupImg3",themeGroupImg3);
			
			// 테마별 - 랜덤카페(4)
			CafeVO themeGroupCafe4 = cafeService.readCafe(themeGroupNo4);
			ImageVO themeGroupImg4 = cafeService.imgSelect(themeGroupNo4);
			model.addAttribute("themeGroupCafe4", themeGroupCafe4);
			model.addAttribute("themeGroupImg4",themeGroupImg4);
			
			List<CafeVO> starPoint5 = cafeService.starPoint5Comment();
			model.addAttribute("starPoint5", starPoint5);
			
			List<Integer> starPoint5Cnt = cafeService.starPoint5CommentCnt();
			model.addAttribute("starPoint5Cnt", starPoint5Cnt);
			 
			
			return "/user/userMukkaCafeHome";
		}
		
		//각 테마번호 배열 랜덤하게 돌리기
		private int[] shuffle(int[] themeNo) {
		    for(int x=0;x<themeNo.length;x++){
		        int i = (int)(Math.random()*themeNo.length);
		        int j = (int)(Math.random()*themeNo.length);
		              
		        int tmp = themeNo[i];
		        themeNo[i] = themeNo[j];
		        themeNo[j] = tmp;
		      }	
			return themeNo;
		}
	
	/** 위치별 카페**/
	@RequestMapping(value = "/mukkaCafe/zone", method = RequestMethod.GET)
	public String cafeZoneList(SearchCriteria cri, Model model) throws Exception {
		
		List<CafeVO> list = service.listSearchCriteria(cri);
		List<ImageVO> imgList = new ArrayList<ImageVO>();
		List<Integer> starpointList = new ArrayList<Integer>();
		List<Integer> starCntList = new ArrayList<Integer>();
		List<Integer> reviewNum = new ArrayList<Integer>();
		
		for(int i=0; i<list.size();i++) {
			int cafeNo = list.get(i).getCafeNo();
			imgList.add(service.imgSelect(cafeNo));
			starpointList.add(service.starpointSelect(cafeNo));
			starCntList.add(service.starCnt(cafeNo));
			reviewNum.add(service.countReviewNum(cafeNo));
		}
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.totalSearchCount(cri));
		
		model.addAttribute("cri", cri);
		model.addAttribute("list", list);
		model.addAttribute("imgList", imgList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("starpoint", starpointList);
		model.addAttribute("starCnt", starCntList);
		model.addAttribute("reviewNum", reviewNum);
		
		return "/user/userMukkaCafeZoneList";
	}
	/**카페 상세정보**/
	@RequestMapping(value = "/mukkaCafe/zone/read", method = RequestMethod.GET)
	public String cafeZoneRead(int cafeNo, boolean flag, SearchCriteria cri, Model model) throws Exception {
		/* 카페 기본 정보 검색 */
		CafeVO cafe = service.readCafe(cafeNo);
		
		/* 카페 테마 순위 검색 */
		List<ThemeVO> themeList = service.rankTheme(cafeNo);

		List<Integer> themeRank = new ArrayList<Integer>();
		for(int i=0;i<themeList.size();i++) {
			themeRank.add(themeList.get(i).getThemeNo());
		}
		
		/* 카페 이미지 리스트 검색 */
		List<ImageVO> imgList = service.imgList(cafeNo);
		
		/* 카페 별점 검색 */
		Double starpoint = service.starpoint(cafeNo);//소수점 점수
		int starpointSelect = service.starpointSelect(cafeNo);//반올림 점수
		
		/* 카페 별점 변화 추이(월별) */
		List<Integer> pointList = new ArrayList<Integer>();
		for(int i=1;i<13;i++) {
			int point = service.starpointByMonth(cafeNo, i);
			pointList.add(point);
			if(point == 0) {
				break;
			}
		}
		/* 카페 메뉴 검색 */
		List<MenuKindsVO> menuName = service.sortNameSelect(cafeNo);
		List<MenuVO> menuList = service.menuList(cafeNo);
		
		
		model.addAttribute("cafe", cafe);
		model.addAttribute("themeRank", themeList);
		model.addAttribute("imgList", imgList);
		model.addAttribute("starpoint", starpoint);
		model.addAttribute("starpointSelect", starpointSelect);
		model.addAttribute("pointList", pointList);
		model.addAttribute("menuName", menuName);
		model.addAttribute("menuList", menuList);
		
		/* 같은 카페의 탐방기 */
		BoardVO boardVO = new BoardVO();
		boardVO.setCafeNo(cafe);
		
		List<BoardVO> sameVo = boardService.cafeReviewSameListByCafeNo(boardVO);
		int sameCnt = boardService.cafeReivewSameCntByCafeNo(boardVO);

		model.addAttribute("sameBoard", sameVo);
		model.addAttribute("sameCnt", sameCnt);

		//(same)해당지역+해당키워드글List
		List<BoardVO> sameKeyword = boardService.recommendSameKeywordListByZoneAndTheme(boardVO);
		model.addAttribute("sameKeyword", sameKeyword);
		
		//(same)해당지역+해당키워드글 : 개수
		int sameKeywordCnt = boardService.recommendSameKeywordCntByZoneAndTheme(boardVO);
		model.addAttribute("sameKeywordCnt", sameKeywordCnt);
		
		//(same)해당키워드에 이미지
		List<ImageVO> klistImg = new ArrayList<ImageVO>();
		for(int i=0;i<sameKeyword.size();i++) {
			int sboardNo = sameKeyword.get(i).getBoardNo();
		    klistImg.addAll(boardService.boardImgList(sboardNo));
		    }
		model.addAttribute("klistImg", klistImg);
		
		return "/user/userMukkaCafeZoneRead";
	}
	

	/** 테마별 카페 **/
	@RequestMapping(value = "/mukkaCafe/theme", method = RequestMethod.GET)
	public String cafeThemeList(SearchCriteria cri, Model model) throws Exception {
		List<CafeVO> list = service.themeCafeSearchListAll(cri);
		List<ImageVO> imgList = new ArrayList<ImageVO>();
		List<Integer> starpointList = new ArrayList<Integer>();
		List<Integer> reviewNum = new ArrayList<Integer>();
		List<ThemeVO> themeList = new ArrayList<ThemeVO>();
				
		
		for(int i=0; i<list.size();i++) {
			int cafeNo = list.get(i).getCafeNo();
			imgList.add(service.imgSelect(cafeNo));
			starpointList.add(service.starpointSelect(cafeNo));
			reviewNum.add(service.countReviewNum(cafeNo));
			//themeList.addAll(service.rankTheme(cafeNo));
		}
		

		List<CafeVO> cafeNoAll = service.themeCafeListThemeName(cri);
		for(int i=0; i<cafeNoAll.size();i++) {
			int cafeNo = cafeNoAll.get(i).getCafeNo();
			//System.out.println("test----------"+cafeNo);
			themeList.addAll(service.rankTheme(cafeNo));
		}
		
		System.out.println("test--------------------------------------------------------"+cafeNoAll.size());
		System.out.println("test--------------------------------------------------------"+themeList.toString());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.totalSearchCount(cri));
		
		model.addAttribute("cri", cri);
		model.addAttribute("list", list);
		model.addAttribute("imgList", imgList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("starpoint", starpointList);
		model.addAttribute("reviewNum", reviewNum);
		model.addAttribute("themeList", themeList);
				
		return "/user/userMukkaCafeThemeList";
	}
	
	
	// 경진 추가 --------------------------------------------------------------------------------------------------------------
	// 메인 메뉴 검색
	@RequestMapping(value = "/mukkaCafe/search", method = RequestMethod.GET)
	public String cafeMainSearch(int zoneNo, String themeNos, SearchCriteria cri, Model model) throws Exception {
		
		List<CafeVO> list = service.cafeMainSearch(zoneNo, themeNos, cri);
		List<ImageVO> imgList = new ArrayList<ImageVO>();
		List<Integer> starpointList = new ArrayList<Integer>();
		List<Integer> reviewNum = new ArrayList<Integer>();
		
		for(int i=0; i<list.size(); i++) {
			int cafeNo = list.get(i).getCafeNo();
			imgList.add(service.imgSelect(cafeNo));
			starpointList.add(service.starpointSelect(cafeNo));
			reviewNum.add(service.countReviewNum(cafeNo));
		}
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.cafeMainSearchTotalCnt(zoneNo, themeNos, cri));
				
		model.addAttribute("cri", cri);
		model.addAttribute("list", list);
		model.addAttribute("imgList", imgList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("starpoint", starpointList);
		model.addAttribute("reviewNum", reviewNum);
		model.addAttribute("zoneNo", zoneNo);
		model.addAttribute("themeNos", themeNos);
		
		return "/user/userMukkaCafeSearchList";
	}
	
	// 무까베스트
	@RequestMapping(value = "/mukkaCafe/mukkaBest", method = RequestMethod.GET)
	public String cafeBestList(Model model) throws Exception {
		List<Double> bestStarPoint = service.monthBestSPoint();
		List<CafeVO> bestCafe = service.monthBestCafe();
		
		Map<Integer, List<ThemeVO>> map = new HashMap<Integer, List<ThemeVO>>();
		for(int i=0; i<bestCafe.size(); i++) {
			List<ThemeVO> theme = themeService.cafeThemeRank(bestCafe.get(i).getCafeNo());
			map.put(bestCafe.get(i).getCafeNo(), theme);
		}
		
		List<Integer> sameCnts = new ArrayList<Integer>();
		for(int i=0; i<3; i++) {
			int sameCnt = service.countReviewNum(bestCafe.get(i).getCafeNo());
			sameCnts.add(sameCnt);
		}
		
		int wishCnt = service.cafeWishCnt(bestCafe.get(0).getCafeNo());
		int commentCnt = service.cafeCommentCnt(bestCafe.get(0).getCafeNo());
		
		model.addAttribute("bestSP", bestStarPoint);
		model.addAttribute("bestCafe", bestCafe);
		model.addAttribute("themeMap", map);
		model.addAttribute("sameCnts", sameCnts);
		model.addAttribute("wishCnt", wishCnt);
		model.addAttribute("commentCnt", commentCnt);
		
		return "/user/userMukkaCafeBestList";
	}
	
	// 월간 카페
	@RequestMapping(value = "/mukkaCafe/monthCafe", method = RequestMethod.GET)
	public String cafeMonthList(Model model) throws Exception {
		int month = Integer.parseInt(powerLinkService.monthlyCafePostDate());
		String postDate = String.format("%02d", month);
		
		// 달이 바뀌면 자동 업데이트
		Date from = new Date();
		SimpleDateFormat fmMonth = new SimpleDateFormat("MM");
		String toMonth = fmMonth.format(from);
		
		if(!toMonth.equals(postDate)) {			
			// 파워링크(월간카페) 정보 업데이트
			service.monthlyCafeUpdate(toMonth);
		}
		
		List<CafeVO> list = service.monthlyCafeList();
		
		model.addAttribute("list", list);
		
		return "/user/userMukkaCafeMonth";
	}
	
}
