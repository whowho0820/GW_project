package com.yi.domain;

import java.util.ArrayList;
import java.util.Date;

public class BoardVO {
	private int boardNo; // 게시글번호
	private BoardKindsVO boardNo2; // 게시판번호
	private KeywordcateVO keySortNo; // 키워드분류번호
	private UsersVO userNo; // 회원번호
	private ZoneVO zoneNo; // 지역번호
	private ThemeVO themeNo; // 테마번호
	private CafeVO cafeNo; // 카페번호
	private Condition writingLockCondition;// 글 잠금여부
	private String writingTitle;// 글제목
	private Date registrationDate;// 작성일
	private Date updateDate;// 수정일
	private int viewNumber;// 조회수
	private int voteNumber;// 추천수
	private String writingContent;// 글내용
	private String address; // 추가된주소(무까인 추천 -> 새로운 카페 주소)
	private ArrayList<ImageVO> files; // 이미지, Image 테이블에서 파일 이름을 가져옴
	private ArrayList<String> stringFiles; // -- 임시로 생성
	private Condition boardDelCdt; // 삭제여부판단
	private int replyCnt;

	public BoardVO() {
		// TODO Auto-generated constructor stub
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public BoardKindsVO getBoardNo2() {
		return boardNo2;
	}

	public void setBoardNo2(BoardKindsVO boardNo2) {
		this.boardNo2 = boardNo2;
	}

	public KeywordcateVO getKeySortNo() {
		return keySortNo;
	}

	public void setKeySortNo(KeywordcateVO keySortNo) {
		this.keySortNo = keySortNo;
	}

	public UsersVO getUserNo() {
		return userNo;
	}

	public void setUserNo(UsersVO userNo) {
		this.userNo = userNo;
	}

	public ZoneVO getZoneNo() {
		return zoneNo;
	}

	public void setZoneNo(ZoneVO zoneNo) {
		this.zoneNo = zoneNo;
	}

	public ThemeVO getThemeNo() {
		return themeNo;
	}

	public void setThemeNo(ThemeVO themeNo) {
		this.themeNo = themeNo;
	}

	public Condition getWritingLockCondition() {
		return writingLockCondition;
	}

	public void setWritingLockCondition(Condition writingLockCondition) {
		this.writingLockCondition = writingLockCondition;
	}

	public String getWritingTitle() {
		return writingTitle;
	}

	public void setWritingTitle(String writingTitle) {
		this.writingTitle = writingTitle;
	}

	public Date getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public int getViewNumber() {
		return viewNumber;
	}

	public void setViewNumber(int viewNumber) {
		this.viewNumber = viewNumber;
	}

	public int getVoteNumber() {
		return voteNumber;
	}

	public void setVoteNumber(int voteNumber) {
		this.voteNumber = voteNumber;
	}

	public String getWritingContent() {
		return writingContent;
	}

	public void setWritingContent(String writingContent) {
		this.writingContent = writingContent;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public CafeVO getCafeNo() {
		return cafeNo;
	}

	public void setCafeNo(CafeVO cafeNo) {
		this.cafeNo = cafeNo;
	}

	public ArrayList<ImageVO> getFiles() {
		return files;
	}

	public void setFiles(ArrayList<ImageVO> files) {
		this.files = files;
	}

	public Condition getBoardDelCdt() {
		return boardDelCdt;
	}

	public void setBoardDelCdt(Condition boardDelCdt) {
		this.boardDelCdt = boardDelCdt;
	}

	public ArrayList<String> getStringFiles() {
		return stringFiles;
	}

	public void setStringFiles(ArrayList<String> stringFiles) {
		this.stringFiles = stringFiles;
	}

	public int getReplyCnt() {
		return replyCnt;
	}

	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}

	@Override
	public String toString() {
		return String.format(
				"BoardVO [boardNo=%s, boardNo2=%s, keySortNo=%s, userNo=%s, zoneNo=%s, themeNo=%s, cafeNo=%s, writingLockCondition=%s, writingTitle=%s, registrationDate=%s, updateDate=%s, viewNumber=%s, voteNumber=%s, writingContent=%s, address=%s, files=%s, stringFiles=%s, boardDelCdt=%s, replyCnt=%s]",
				boardNo, boardNo2, keySortNo, userNo, zoneNo, themeNo, cafeNo, writingLockCondition, writingTitle,
				registrationDate, updateDate, viewNumber, voteNumber, writingContent, address, files, stringFiles,
				boardDelCdt, replyCnt);
	}

}
