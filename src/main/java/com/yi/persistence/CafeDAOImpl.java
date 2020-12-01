package com.yi.persistence;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yi.domain.CafeVO;
import com.yi.domain.Criteria;
import com.yi.domain.ImageVO;
import com.yi.domain.MenuKindsVO;
import com.yi.domain.MenuVO;
import com.yi.domain.SearchCriteria;
import com.yi.domain.ThemeVO;

@Repository
public class CafeDAOImpl implements CafeDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "mapper.CafeMapper.";
	
	/* 카페 추가, 검색, 삭제, 수정 */
	@Override
	public void createCafe(CafeVO vo) throws Exception {
		sqlSession.insert(namespace+"createCafe", vo);
	}

	@Override
	public CafeVO readCafe(int cafeNo) throws Exception {
		return sqlSession.selectOne(namespace+"readCafe", cafeNo);
	}

	@Override
	public List<CafeVO> list() throws Exception {
		return sqlSession.selectList(namespace+"list");
	}

	@Override
	public void updateCafe(CafeVO vo) throws Exception {
		sqlSession.update(namespace+"updateCafe", vo);
	}

	@Override
	public void deleteCafe(int cafeNo) throws Exception {
		sqlSession.delete(namespace+"deleteCafe", cafeNo);
	}

	@Override
	public List<CafeVO> listPage(int page) throws Exception {
		//1->0, 2->10, 3->20
		if(page < 0) {
			page = 1;
		}
		
		page = (page - 1) * 10;
				
		return sqlSession.selectList(namespace+"listPage", page);
	}
	
	/* 카페 이미지 검색 */
	@Override
	public ImageVO imgSelect(int cafeNo) throws Exception {
		return sqlSession.selectOne(namespace+"sumnailImg", cafeNo);
	}

	@Override
	public List<ImageVO> imgList(int cafeNo) throws Exception {
		return sqlSession.selectList(namespace+"imgList", cafeNo);
	}
	
	/* 카페 별점 검색 */
	@Override
	public int starpointSelect(int cafeNo) throws Exception {
		return sqlSession.selectOne(namespace+"pointSelect", cafeNo);
	}
	
	@Override
	public Double starpoint(int cafeNo) throws Exception {
		return sqlSession.selectOne(namespace+"starpoint", cafeNo);
	}
	
	@Override
	public int starpointByMonth(int cafeNo, int month) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("cafeNo", cafeNo);
		map.put("month", month);
		return sqlSession.selectOne(namespace+"starpointByMonth", map);
	}
	
	@Override
	public Integer starCnt(int cafeNo) throws Exception {
		return sqlSession.selectOne(namespace+"starCnt", cafeNo);
	}

	
	/* 카페 테마 순위 검색 */
	@Override
	public List<ThemeVO> rankTheme(int cafeNo) throws Exception {
		return sqlSession.selectList(namespace+"rankTheme", cafeNo);
	}

	/* 카페 메뉴 검색 */
	@Override
	public List<MenuVO> menuList(int cafeNo) throws Exception {
		return sqlSession.selectList(namespace+"menuList", cafeNo);
	}
	
	@Override
	public List<MenuKindsVO> sortNameSelect(int cafeNo) throws Exception {
		return sqlSession.selectList(namespace+"sortNameSelect", cafeNo);
	}
	
	/* 카페 탐방기 숫자 검색 */
	@Override
	public int countReviewNum(int cafeNo) throws Exception {
		return sqlSession.selectOne(namespace+"countReviewNum", cafeNo);
	}
	
// 검색시 페이징 처리 DAOImpl
	
	@Override
	public List<CafeVO> listSearchCriteria(SearchCriteria cri) throws Exception {
		return sqlSession.selectList(namespace+"listSearchCriteria", cri);
	}

	@Override
	public int totalSearchCount(SearchCriteria cri) throws Exception {
		return sqlSession.selectOne(namespace+"totalSearchCount", cri);
	}
	
	// 경진 추가 (user) start ----------------------------------------------------------------------------------------
	// 카페 이름 검색
	@Override
	public List<CafeVO> searchCafeByName(String cafeName) throws Exception {
		//List<CafeVO> list = sqlSession.selectList(namespace + "searchCafeByName", cafeName);
		//System.out.println("list------------------------"+list);
		return sqlSession.selectList(namespace + "searchCafeByName", cafeName);
	}
	
	// 메인메뉴 카페 검색
	@Override
	public List<CafeVO> cafeMainSearch(int zoneNo, String themeNos, SearchCriteria cri) throws Exception {
		List<String> themeNums = new ArrayList<String>();
		if(themeNos.indexOf(",") > 0) {			
			String[] themeNo = themeNos.split(",");
			for(String t : themeNo) {
				themeNums.add(t);
			}
		} 
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("zoneNo", zoneNo);
		map.put("themeNums", themeNums);
		map.put("cri", cri);
		
		return sqlSession.selectList(namespace + "cafeMainSearch", map);
	}

	@Override
	public int cafeMainSearchTotalCnt(int zoneNo, String themeNos, SearchCriteria cri) throws Exception {
		List<String> themeNums = new ArrayList<String>();
		if(themeNos.indexOf(",") > 0) {			
			String[] themeNo = themeNos.split(",");
			for(String t : themeNo) {
				themeNums.add(t);
			}
		} 
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("zoneNo", zoneNo);
		map.put("themeNums", themeNums);
		map.put("cri", cri);
		return sqlSession.selectOne(namespace + "cafeMainSearchTotalCnt", map);
	}
	
	// 카페 베스트
	@Override
	public List<Double> monthBestSPoint() throws Exception {
		return sqlSession.selectList(namespace + "monthBestSPoint");
	}

	@Override
	public List<CafeVO> monthBestCafe() throws Exception {
		return sqlSession.selectList(namespace + "monthBestCafe");
	}
	
	@Override
	public int cafeWishCnt(int cafeNo) throws Exception {
		return sqlSession.selectOne(namespace + "cafeWishCnt", cafeNo);
	}

	@Override
	public int cafeCommentCnt(int cafeNo) throws Exception {
		return sqlSession.selectOne(namespace + "cafeCommentCnt", cafeNo);
	}
	
	// 파워링크 (월간카페)
	@Override
	public List<CafeVO> monthlyCafeList() throws Exception {
		return sqlSession.selectList(namespace + "monthlyCafeList");
	}
	// 파워링크(월간카페) 게시 상태 PowerLink데이터랑 동일하게 유지할 update문
	@Override
	public void monthlyCafeUpdate() throws Exception {
		sqlSession.update(namespace + "monthlyCafeUpdate");
	}
	// 경진 추가 (user) end ----------------------------------------------------------------------------------------
	// 경진 추가 (admin) start ----------------------------------------------------------------------------------------
	@Override
	public int cafeWaitingCnt(CafeVO vo) throws Exception {
		return sqlSession.selectOne(namespace + "cafeWaitingCnt", vo);
	}
	
	@Override
	public int cafeWaitingCntAndKeyword(CafeVO vo, SearchCriteria cri) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("cri", cri);
		
		return sqlSession.selectOne(namespace + "cafeWaitingCntAndKeyword", map);
	}
	
	// 신규 카페 승인 list
	@Override
	public List<CafeVO> adminNewCafeList(CafeVO vo, SearchCriteria cri) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("cri", cri);
		
		return sqlSession.selectList(namespace + "adminNewCafeList", map);
	}
	
	// 카페 차트
	@Override
	public List<Integer> adminCafeCntChart(int subNum) throws Exception {
		return sqlSession.selectList(namespace + "adminCafeCntChart", subNum);
	}	
	
	//사업자등록번호 조회
	@Override
	public int selectAdminCafeByOwnerNo(String ownerNo) throws Exception {
		return sqlSession.selectOne(namespace + "selectAdminCafeByOwnerNo", ownerNo);
	}
	
	// 신규 카페 승인
	@Override
	public void updateNewCafeCdt(int cafeNo) throws Exception {
		sqlSession.update(namespace + "updateNewCafeCdt", cafeNo);
	}
	
	// 어드민 카페 list
	@Override
	public List<CafeVO> adminCafeList(CafeVO vo, SearchCriteria cri) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("cri", cri);
		
		return sqlSession.selectList(namespace + "adminCafeList", map);
	}
	
	// 카페 운영/폐업 update
	@Override
	public void updateCafeCdt(CafeVO vo) throws Exception {
		sqlSession.update(namespace + "updateCafeCdt", vo);
	}

	// 경진 추가 (admin) end ----------------------------------------------------------------------------------------


	/**************** 아름추가  ********************/
	@Override
	public List<CafeVO> rcSearchCafeByName(String cafeName) throws Exception {
		return sqlSession.selectList(namespace + "rcSearchCafeByName",cafeName);
	}

	//파워링크
	@Override
	public List<CafeVO> powerLinkCafeList() throws Exception {
		return sqlSession.selectList(namespace+"powerLinkCafeList");
	}
	//당월 신상카페 - 등록일기준
	@Override
	public List<CafeVO> newCafeList() throws Exception {
		return sqlSession.selectList(namespace+"newCafeList");
	}

	@Override
	public List<Integer> openCafeNoList() throws Exception {
		return sqlSession.selectList(namespace+"openCafeNoList");
	}

	@Override
	public List<CafeVO> viewNumberCafeListAll() throws Exception {
		return sqlSession.selectList(namespace+"viewNumberCafeListAll");
	}

	
	@Override
	public List<CafeVO> starPointCafeBest5Info() throws Exception {
		return sqlSession.selectList(namespace+"starPointCafeBest5Info");
	}
	
	@Override
	public List<Double> starPointCafeBest5() throws Exception {
		return sqlSession.selectList(namespace + "starPointCafeBest5");
	}

	@Override
	public List<Integer> openThemeCafeNoList(int themeNo) throws Exception {
		return sqlSession.selectList(namespace+"openThemeCafeNoList", themeNo);
	}

	@Override
	public int cafeOpenAllCnt() throws Exception {
		return sqlSession.selectOne(namespace+"cafeOpenAllCnt");
	}

	@Override
	public List<CafeVO> themeCafeSearchListAll(SearchCriteria cri) throws Exception {
		return sqlSession.selectList(namespace+"themeCafeSearchListAll",cri);
	}

	@Override
	public List<CafeVO> starPoint5Comment() throws Exception {
		return sqlSession.selectList(namespace+"starPoint5Comment");
	}

	@Override
	public List<Integer> starPoint5CommentCnt() throws Exception {
		return sqlSession.selectList(namespace+"starPoint5CommentCnt");
	}

	@Override
	public List<CafeVO> themeCafeListThemeName(SearchCriteria cri) throws Exception {
		return sqlSession.selectList(namespace+"themeCafeListThemeName",cri);
	}


}
