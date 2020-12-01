package com.yi.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yi.domain.BoardVO;
import com.yi.domain.ImageVO;
import com.yi.domain.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO{

	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "mappers.BoardMapper.";
	
	/*** 추천카페 ***/
	//추천카페 -- 리스트	(테스트용)
	@Override
	public List<BoardVO> recommendboardList() throws Exception {
		return sqlSession.selectList(namespace+"recommendboardList");
	}
	//추천카페 -- 페이징된 리스트	
	@Override
	public List<BoardVO> recommendboardListSearchCriteria(int cBoardNo, SearchCriteria cri) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cBoardNo", cBoardNo);
		map.put("cri", cri);
		return sqlSession.selectList(namespace+"recommendboardListSearchCriteria", map);
	}
	
	@Override
	public List<ImageVO> boardImgList(int sboardNo) throws Exception {
		return sqlSession.selectList(namespace+"boardImgList", sboardNo);
	}

	//추천카페 -- 등록		
	@Override
	public void recommendInsert(BoardVO vo) throws Exception {
		sqlSession.insert(namespace+"recommendInsert", vo);
	}
	@Override
	public void recommendInsertImages(String imageName, int boardNo) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("imageName", imageName);
		map.put("boardNo", boardNo);
		sqlSession.insert(namespace+"recommendInsertImages",map);		
	}	
	//추천카페 -- 상세보기
	@Override
	public BoardVO recommendReadByNo(int boardNo) throws Exception {
		return sqlSession.selectOne(namespace+"recommendReadByNo", boardNo);
	}
	
	//추천카페 -- 같은카페리스트
	@Override
	public List<BoardVO> recommendSameCafeList(BoardVO vo) throws Exception {
		return sqlSession.selectList(namespace+"recommendSameCafeList", vo);
	}
	//추천카페 -- 같은카페 등록수
	@Override
	public int recommendSameCafeCnt(BoardVO vo) throws Exception {
		return sqlSession.selectOne(namespace+"recommendSameCafeCnt", vo);
	}
	
	//추천카페 -- 같은키워드리스트
	@Override
	public List<BoardVO> recommendSameKeywordList(BoardVO vo) throws Exception {
		return sqlSession.selectList(namespace+"recommendSameKeywordList", vo);
	}
	//추천카페 -- 같은키워드 등록수
	@Override
	public int recommendSameKeywordCnt(BoardVO vo) throws Exception {
		return sqlSession.selectOne(namespace+"recommendSameKeywordCnt", vo);
	}
	//추천카페 -- 사진삭제 (수정)
	@Override
	public void removeRecommendImg(String imageName) throws Exception{
		sqlSession.delete(namespace+"removeRecommendImg",imageName);		
	}
	
	//추천카페 -- 수정
	@Override
	public void recommendUpdate(BoardVO vo) throws Exception{
		sqlSession.update(namespace + "recommendUpdate", vo);
	}
	
	@Override
	public void cafeRecommendRemove(BoardVO vo) throws Exception {
		sqlSession.update(namespace + "cafeRecommendRemove", vo);
		
	}	
	
	//추천카페 -- 전체 조회순 랭킹
	@Override
	public List<BoardVO> rcRankVoteAll() throws Exception {
		return sqlSession.selectList(namespace+"rcRankVoteAll");
	}
	//추천카페-- '당월' 추천순 랭킹
	@Override
	public List<BoardVO> rcRankVoteMonth() throws Exception {
		return sqlSession.selectList(namespace+"rcRankVoteMonth");
	}
	//추천카페-- '당월' 조회순 랭킹
	@Override
	public List<BoardVO> rcRankViewMonth() throws Exception {
		return sqlSession.selectList(namespace+"rcRankViewMonth");
	}
	//추천카페-- '당월' 댓글순 랭킹
	@Override
	public List<BoardVO> rcRankReplyMonth() throws Exception {
		return sqlSession.selectList(namespace+"rcRankReplyMonth");
	}
	//추천카페-- '전월' 추천순 랭킹
	@Override
	public List<BoardVO> rcRankVoteLastMonth() throws Exception {
		return sqlSession.selectList(namespace+"rcRankVoteLastMonth");
	}	
	
	
	/*** 공통 ***/
	//오늘 등록된 글 갯수(**커뮤니티 공통**)
	@Override
	public int todayBoardCount(int cBoardNo) throws Exception {
		return sqlSession.selectOne(namespace+"todayBoardCount", cBoardNo);
	}
	//각 서브게시물별 등록된 게시글 총 갯수(페이징시 이용)
	@Override
	public int totalSearchCount(int cBoardNo) throws Exception {
		return sqlSession.selectOne(namespace+"totalSearchCount", cBoardNo);
	}
	//각 서브게시물별 등록된 게시글 총 갯수(페이징시 이용 - join)
	@Override
	public int totalSearchCountJoin(int cBoardNo, SearchCriteria cri) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cBoardNo", cBoardNo);
		map.put("cri", cri);
		return sqlSession.selectOne(namespace+"totalSearchCountJoin", map);
	}
	
	// 유저가 등록한 게시글 갯수
	@Override
	public int totalUserBoardCount(int userNo) throws Exception {
		return sqlSession.selectOne(namespace + "totalUserBoardCount", userNo);
	}
	
	// 조회수
	@Override
	public void updateViewCnt(int boardNo) throws Exception {
		sqlSession.update(namespace+"updateViewCnt",boardNo);	
	}
	
	// 게시글 추천(좋아요) 더하기
	@Override
	public void insertVotePlusCnt(int boardNo, int userNo) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("boardNo", boardNo);
		map.put("userNo", userNo);
		sqlSession.insert(namespace + "insertVotePlusCnt", map);
	}
	// 게시글 추천(좋아요) 빼기
	@Override
	public void deleteVoteMinusCnt(int boardNo, int userNo) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("boardNo", boardNo);
		map.put("userNo", userNo);
		sqlSession.delete(namespace + "deleteVoteMinusCnt", map);
	}
	// 게시글 추천 갯수 게시판 테이블에 추가
	@Override
	public void updateBoardVoteCnt(int boardNo) throws Exception {
		sqlSession.update(namespace + "updateBoardVoteCnt", boardNo);
	}
	// 게시글 추천(좋아요) 갯수
	@Override
	public int boardVoteCnt(int boardNo) throws Exception {
		return sqlSession.selectOne(namespace + "boardVoteCnt", boardNo);
	}
	
	// 게시글 댓글 갯수 추가
	@Override
	public void updateBoardReplyCnt(int amount, int boardNo) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("amount", amount);
		map.put("boardNo", boardNo);
		
		sqlSession.update(namespace + "updateBoardReplyCnt", map);
	}
	
	// 로그인 회원 게시글 좋아요 클릭 여부
	@Override
	public int userVoteCdt(int userNo, int boardNo) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("userNo", userNo);
		map.put("boardNo", boardNo);
		
		return sqlSession.selectOne(namespace + "userVoteCdt", map);
	}

	
	/*** 탐방기 ***/
	// 경진 추가 (user) start ------------------------------------------------------------------------------------	
	//등록
	@Override  
	public void cafeReviewInsert(BoardVO vo) throws Exception {
		sqlSession.insert(namespace + "cafeReviewInsert", vo);
	}
	// 리스트
	@Override  
	public List<BoardVO> cafeReviesList(int cBoardNo, SearchCriteria cri) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cBoardNo", cBoardNo);
		map.put("cri", cri);
		return sqlSession.selectList(namespace + "cafeReviesList", map);
	}
	// 베스트 리스트
	@Override
	public List<BoardVO> cafeReviewBestList(int cBoardNo, SearchCriteria cri) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cBoardNo", cBoardNo);
		map.put("cri", cri);
		return sqlSession.selectList(namespace + "cafeReviewBestList", map);
	}
	//월간 베스트 리스트
	@Override
	public List<BoardVO> cafeReviewMonthBestList() throws Exception {
		return sqlSession.selectList(namespace + "cafeReviewMonthBestList");
	}
	// 상세보기
	@Override
	public BoardVO cafeReviewRead(int boardNo) throws Exception {
		return sqlSession.selectOne(namespace + "cafeReviewRead", boardNo);
	}
	// 상세보기에 같은 카페 탐방기 리스트
	@Override
	public List<BoardVO> cafeReviewSameList(BoardVO vo) throws Exception {
		return sqlSession.selectList(namespace + "cafeReviewSameList", vo);
	}
	// 상세보기 같은 카페 탐방기 카운트
	@Override
	public int cafeReivewSameCnt(BoardVO vo) throws Exception {
		return sqlSession.selectOne(namespace + "cafeReivewSameCnt", vo);
	}
	// 탐방기 수정
	@Override
	public void cafeReviewModify(BoardVO vo) throws Exception {
		sqlSession.update(namespace + "cafeReviewModify", vo);
	}
	// 탐방기 삭제
	@Override
	public void cafeReviewRemove(BoardVO vo) throws Exception {
		sqlSession.update(namespace + "cafeReviewRemove", vo);
	}
	// 경진 추가 (user) start ------------------------------------------------------------------------------------	
	// 경진 추가 (admin) start ------------------------------------------------------------------------------------	
	
	// 어드민 메인 탐방기, 카페 추천 cnt 
	@Override
	public int todayBoardCnt(int boardType) throws Exception {
		return sqlSession.selectOne(namespace + "todayBoardCnt", boardType);
	}
	@Override
	public int yesterBoardCnt(int boardType) throws Exception {
		return sqlSession.selectOne(namespace + "yesterBoardCnt", boardType);
	}
	
	// 어드민 탐방기, 추천글 차트
	@Override
	public List<Integer> adminBoardCntChart(int subNum, int boardType) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("subNum", subNum);
		map.put("boardType", boardType);
		
		return sqlSession.selectList(namespace + "adminBoardCntChart", map);
	}
	
	// 어드민 탐방기 추천글 list
	@Override
	public List<BoardVO> adminBoardList(int cBoardNo, SearchCriteria cri) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cBoardNo", cBoardNo);
		map.put("cri", cri);
		
		return sqlSession.selectList(namespace + "adminBoardList", map);
	}
	@Override
	public int adminTotalSearchCountJoin(int cBoardNo, SearchCriteria cri) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cBoardNo", cBoardNo);
		map.put("cri", cri);
		
		return sqlSession.selectOne(namespace + "adminTotalSearchCountJoin", map);
	}

	
	// 경진 추가 (admin) end ------------------------------------------------------------------------------------	
	
	
	// ***재승 추가 ***
	// 해당카페의 탐방기 리스트
	@Override
	public List<BoardVO> cafeReviewSameListByCafeNo(BoardVO vo) throws Exception {
		return sqlSession.selectList(namespace+"cafeReviewSameListByCafeNo", vo);
	}
	@Override
	public int cafeReivewSameCntByCafeNo(BoardVO vo) throws Exception {
		return sqlSession.selectOne(namespace + "cafeReivewSameCntByCafeNo", vo);
	}
	// 해당카페와 키워드, 지역이 같은 추천카페 리스트
	@Override
	public List<BoardVO> recommendSameKeywordListByZoneAndTheme(BoardVO boardVO) throws Exception {
		return sqlSession.selectList(namespace+"recommendSameKeywordListByZoneAndTheme", boardVO);
	}
	@Override
	public int recommendSameKeywordCntByZoneAndTheme(BoardVO boardVO) throws Exception {
		return sqlSession.selectOne(namespace+"recommendSameKeywordCntByZoneAndTheme", boardVO);
	}
	
	
	/*** 아름추가 ***/ 
	// 탐방기 월간 베스트15 Main에 쓸 리스트
	@Override
	public List<BoardVO> cafeReviewMonthBestListHome() throws Exception {
		return sqlSession.selectList(namespace+"cafeReviewMonthBestListHome");
	}
	
	@Override
	public List<BoardVO> cafeReviewVoteBestAll() throws Exception {
		return sqlSession.selectList(namespace+"cafeReviewVoteBestAll");
	}
	
	//열혈무까인 : 종합리스트
	@Override
	public List<BoardVO> bestUserAllBoard() throws Exception {
		return sqlSession.selectList(namespace+"bestUserAllBoard");
	}
	//열혈무까인 : 종합 - 게시글수
	@Override
	public List<Integer> bestUserAllBoardCnt() throws Exception {
		return sqlSession.selectList(namespace+"bestUserAllBoardCnt");
	}
	//열혈무까인 : 전월기준리스트
	@Override
	public List<BoardVO> bestUserBoard() throws Exception {
		return sqlSession.selectList(namespace+"bestUserBoard");
	}
	//열혈무까인 : 전월기준 - 게시글수 
	@Override
	public List<Integer> bestUserBoardCnt() throws Exception {
		return sqlSession.selectList(namespace+"bestUserBoardCnt");
	}
	@Override
	public int cafeReviewAllCnt() throws Exception {
		return sqlSession.selectOne(namespace+"cafeReviewAllCnt");
	}
	@Override
	public List<BoardVO> bestUserBoardInfo(int userNo) throws Exception {
		return sqlSession.selectList(namespace + "bestUserBoardInfo", userNo);
	}
	@Override
	public List<Integer> recommedBoardNo() throws Exception {
		return sqlSession.selectList(namespace + "recommedBoardNo");
	}

	


	
	
}
