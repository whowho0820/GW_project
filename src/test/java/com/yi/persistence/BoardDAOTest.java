package com.yi.persistence;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yi.domain.BoardKindsVO;
import com.yi.domain.BoardVO;
import com.yi.domain.CafeVO;
import com.yi.domain.Criteria;
import com.yi.domain.SearchCriteria;
import com.yi.domain.ThemeVO;
import com.yi.domain.UsersVO;
import com.yi.domain.ZoneVO;
import com.yi.persistence.BoardDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class BoardDAOTest {
	
	@Autowired
	public BoardDAO dao;
	
	@Test
	public void testDao() {
		System.out.println("BoardDAO값 "+dao);
	}
	
	//@Test
	public void testRcInsert() throws Exception{
		BoardVO vo = new BoardVO();
		vo.setBoardNo2(new BoardKindsVO(2));
		vo.setUserNo(new UsersVO(1));
		vo.setZoneNo(new ZoneVO(1));
		vo.setThemeNo(new ThemeVO(1));
		vo.setWritingTitle("테스트제목");
		vo.setWritingContent("테스트 글내용");
		vo.setAddress("대구광역시");
		System.out.println(vo.toString());
		System.out.println(vo.getBoardNo2().getBoardNo());
		dao.recommendInsert(vo);
	}
	
//	@Test
//	public void testListBoard() throws Exception{
//		dao.recommendboardList();
//	}
//	
	
	//@Test
	public void testCafeReviewInsert() throws Exception {
		BoardKindsVO boardNo2 = new BoardKindsVO();
		boardNo2.setBoardNo(1);
		UsersVO userNo = new UsersVO();
		userNo.setUserNo(2);
		CafeVO cafeNo = new CafeVO();
		cafeNo.setCafeNo(2);
		
		BoardVO vo = new BoardVO();
		vo.setBoardNo2(boardNo2);
		vo.setUserNo(userNo);
		vo.setCafeNo(cafeNo);
		vo.setWritingTitle("탐방기 테스트");
		vo.setWritingContent("<p>탐방기 테스트</p>");
		dao.cafeReviewInsert(vo);
	}
	
	//@Test
	public void testTotalUserBoardCount() throws Exception {
		dao.totalUserBoardCount(3);
	}
	
	//@Test
	public void testCafeReviesList() throws Exception {
		SearchCriteria cri = new SearchCriteria();
		cri.setPage(1);
		cri.setSearchTheme("1");
		cri.setSearchZone("1");
		System.out.println("cri -------------" + cri);
		System.out.println("cri -----------" + cri.getSearchTheme());
		List<BoardVO> list = dao.cafeReviesList(1, cri);
		for(BoardVO b : list) {
			System.out.println(b);
		}
	}
	
	//@Test
	public void testCafeReviewRead() throws Exception {
		int boardNo = 53;
		dao.cafeReviewRead(boardNo);
	}
	
	//@Test
	public void testCafeReviewSameList() throws Exception {
		CafeVO cafe = new CafeVO();
		cafe.setCafeNo(7);
		
		BoardVO vo = new BoardVO();
		vo.setCafeNo(cafe);
		vo.setBoardNo(12);
		dao.cafeReviewSameList(vo);
	}
	
	//@Test
	public void testCafeReivewSameCnt() throws Exception {
		CafeVO cafe = new CafeVO();
		cafe.setCafeNo(7);
		
		BoardVO vo = new BoardVO();
		vo.setCafeNo(cafe);
		vo.setBoardNo(12);
		dao.cafeReivewSameCnt(vo);
	}
	
	//@Test
	public void testBoardCnt() throws Exception {
		dao.todayBoardCnt(1);
		dao.yesterBoardCnt(1);
	}
	
	//@Test
	public void testUserVoteCdt() throws Exception {
		dao.userVoteCdt(1, 268);
	}
	
	@Test
	public void testAdminBoardCntChart() throws Exception {
		dao.adminBoardCntChart(1, 1);
	}
}
