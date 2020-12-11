package com.yi.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.model.CalendarList;
import com.google.api.services.calendar.model.CalendarListEntry;
import com.yi.domain.CalendarDto;
import com.yi.service.GoogleCalendarService;

import gu.common.DateVO;
import gu.common.Field3VO;
import gu.common.Util4calen;
import gu.etc.EtcSvc;
import gu.main.IndexSvc;

@Controller
@RequestMapping("/admin/noticeMgr/*")
public class AdminNoticMgrControoler {
	
	@Autowired
    private IndexSvc indexSvc;
	
    @Autowired
    private EtcSvc etcSvc;
    
    /**
     * main page. 
     */
    @RequestMapping(value = "/gwcalendarMgr")
    public String index(HttpServletRequest request, ModelMap modelMap) {
    	
    	String auth = request.getSession().getAttribute("Auth").toString(); 
    	String userno = request.getSession().getAttribute("userId").toString();
		String authno = request.getSession().getAttribute("AuthNo").toString(); 
        
        etcSvc.setCommonAttribute(userno, modelMap);

        Date today = Util4calen.getToday(); 

        calCalen(userno, today, modelMap);
                
        List<?> listview = indexSvc.selectRecentNews();
        List<?> noticeList = indexSvc.selectNoticeListTop5();
        List<?> listtime = indexSvc.selectTimeLine();
        
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("noticeList", noticeList);
        modelMap.addAttribute("listtime", listtime);

        return "/admin/admingwcalendarMgr";
    }
    
    /**
     * week calendar in main page. 
     * Ajax.
     */
    @RequestMapping(value = "/moveDate")
    public String moveDate(HttpServletRequest request, ModelMap modelMap) {
        String userno = request.getSession().getAttribute("userno").toString();
        String date = request.getParameter("date");

        Date today = Util4calen.getToday(date);
        
        calCalen(userno, today, modelMap);
        
        return "/admin/admingwcalendarMgr";
    }
    
    private String calCalen(String userno, Date targetDay, ModelMap modelMap) {
        List<DateVO> calenList = new ArrayList<DateVO>();
        
        Date today = Util4calen.getToday();
        int month = Util4calen.getMonth(targetDay);
        int week = Util4calen.getWeekOfMonth(targetDay);
        
        Date fweek = Util4calen.getFirstOfWeek(targetDay);
        Date lweek = Util4calen.getLastOfWeek(targetDay);
        Date preWeek = Util4calen.dateAdd(fweek, -1);
        Date nextWeek = Util4calen.dateAdd(lweek, 1);

    	Field3VO fld = new Field3VO();
    	fld.setField1(userno);
        
        while (fweek.compareTo(lweek) <= 0) {
            DateVO dvo = Util4calen.date2VO(fweek);
            dvo.setIstoday(Util4calen.dateDiff(fweek, today) == 0);
            dvo.setDate(Util4calen.date2Str(fweek));
            
    		fld.setField2(dvo.getDate());
    		dvo.setList( indexSvc.selectSchList4Calen(fld) );
            
            calenList.add(dvo);
            
            fweek = Util4calen.dateAdd(fweek, 1);
        }
        
        modelMap.addAttribute("month", month);
        modelMap.addAttribute("week", week);
        modelMap.addAttribute("calenList", calenList);
        modelMap.addAttribute("preWeek", Util4calen.date2Str(preWeek));
        modelMap.addAttribute("nextWeek", Util4calen.date2Str(nextWeek));

        return "/admin/admingwcalendarMgr";
    }
	
	/*
	 * private Logger logger =
	 * LoggerFactory.getLogger(AdminNoticMgrControoler.class);
	 * 
	 * // 캘린더리스트
	 * 
	 * @RequestMapping(value="/calendarMgr", method=RequestMethod.GET) public String
	 * coding(Model model) { logger.info("calendarList"); try { Calendar service =
	 * GoogleCalendarService.getCalendarService(); CalendarList calendarList =
	 * service.calendarList().list().setPageToken(null).execute();
	 * List<CalendarListEntry> items = calendarList.getItems();
	 * model.addAttribute("items", items); } catch (IOException e) {
	 * e.printStackTrace(); } return "/admin/admincalendarMgr"; } // 캘린더 생성 처리
	 * 
	 * @RequestMapping(value="/calendarAdd.do", method=RequestMethod.POST) public
	 * String calendarAdd(CalendarDto calDto) {
	 * logger.info("calendarAdd "+calDto.toString()); try { Calendar service =
	 * GoogleCalendarService.getCalendarService();
	 * com.google.api.services.calendar.model.Calendar calendar = new
	 * com.google.api.services.calendar.model.Calendar();
	 * calendar.setSummary(calDto.getSummary());
	 * calendar.setTimeZone("America/Los_Angeles");
	 * service.calendars().insert(calendar).execute(); } catch (IOException e) {
	 * e.printStackTrace(); } return "redirect:/coding.do"; }
	 * 
	 * // 캘린더 삭제 처리
	 * 
	 * @RequestMapping(value="/calendarRemove.do", method=RequestMethod.POST) public
	 * String calendarRemove(HttpServletRequest req) {
	 * logger.info("calendarRemove"); String[] chkVal =
	 * req.getParameterValues("chkVal"); try { Calendar service =
	 * GoogleCalendarService.getCalendarService(); for (String calendarId : chkVal)
	 * { service.calendars().delete(calendarId).execute(); } } catch (IOException e)
	 * { e.printStackTrace(); } return "redirect:/coding.do"; } // 캘린더 수정 처리
	 * 
	 * @RequestMapping(value="/calendarModify.do", method=RequestMethod.POST) public
	 * String calendarModify(CalendarDto calDto) {
	 * logger.info("calendarModify "+calDto.toString()); try { Calendar service =
	 * GoogleCalendarService.getCalendarService();
	 * com.google.api.services.calendar.model.Calendar calendar =
	 * service.calendars().get(calDto.getCalendarId()).execute();
	 * calendar.setSummary(calDto.getSummary());
	 * service.calendars().update(calendar.getId(), calendar).execute(); } catch
	 * (IOException e) { e.printStackTrace(); } return "redirect:/coding.do"; }
	 */

	/*
	 * // 캘린더 이동처리
	 * 
	 * @RequestMapping(value="/schdule.do", method=RequestMethod.GET) public String
	 * schdule(Model model, String calendarId, String title) {
	 * logger.info("schdule"); model.addAttribute("calendarId", calendarId);
	 * model.addAttribute("title", title); return "/admin/admincalendarMgr2"; }
	 */	
	
	/*
	 * @Autowired private BoardService service;
	 * 
	 * // 일정관리1
	 * 
	 * @RequestMapping(value = "calendarMgr", method = RequestMethod.GET) public
	 * String calendarMgr(SearchCriteria cri, Model model) throws Exception { int
	 * cBoardNo = 2; cri.setPerPageNum(10);
	 * 
	 * List<BoardVO> list = service.adminBoardList(cBoardNo, cri); PageMaker
	 * pageMaker = new PageMaker(); pageMaker.setCri(cri);
	 * pageMaker.setTotalCount(service.adminTotalSearchCountJoin(cBoardNo, cri));
	 * 
	 * model.addAttribute("list", list); model.addAttribute("cri", cri);
	 * model.addAttribute("pageMaker", pageMaker); return "/admin/admincalendarMgr";
	 * }
	 * 
	 * // 일정관리2
	 * 
	 * @RequestMapping(value = "calendarMgr2", method = RequestMethod.GET) public
	 * String calendarMgr2(SearchCriteria cri, Model model) throws Exception { int
	 * cBoardNo = 2; cri.setPerPageNum(10);
	 * 
	 * List<BoardVO> list = service.adminBoardList(cBoardNo, cri); PageMaker
	 * pageMaker = new PageMaker(); pageMaker.setCri(cri);
	 * pageMaker.setTotalCount(service.adminTotalSearchCountJoin(cBoardNo, cri));
	 * 
	 * model.addAttribute("list", list); model.addAttribute("cri", cri);
	 * model.addAttribute("pageMaker", pageMaker); return
	 * "/admin/admincalendarMgr2"; }
	 */
	
}
