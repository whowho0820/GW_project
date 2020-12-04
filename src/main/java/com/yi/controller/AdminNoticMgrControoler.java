package com.yi.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.model.CalendarList;
import com.google.api.services.calendar.model.CalendarListEntry;
import com.yi.domain.CalendarDto;
import com.yi.service.GoogleCalendarService;

@Controller
@RequestMapping("/admin/noticeMgr/*")
public class AdminNoticMgrControoler {
	
    private Logger logger = LoggerFactory.getLogger(AdminNoticMgrControoler.class);    

    // 캘린더리스트
    @RequestMapping(value="/calendarMgr", method=RequestMethod.GET)
    public String coding(Model model) {
        logger.info("calendarList");
        try {
            Calendar service = GoogleCalendarService.getCalendarService();
            CalendarList calendarList = service.calendarList().list().setPageToken(null).execute();
            List<CalendarListEntry> items = calendarList.getItems();
            model.addAttribute("items", items);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "/admin/admincalendarMgr";
    }
    // 캘린더 생성 처리
    @RequestMapping(value="/calendarAdd.do", method=RequestMethod.POST)
    public String calendarAdd(CalendarDto calDto) {
        logger.info("calendarAdd "+calDto.toString());   
        try {
            Calendar service = GoogleCalendarService.getCalendarService();
            com.google.api.services.calendar.model.Calendar calendar = new com.google.api.services.calendar.model.Calendar();
            calendar.setSummary(calDto.getSummary());
            calendar.setTimeZone("America/Los_Angeles");
            service.calendars().insert(calendar).execute();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "redirect:/coding.do";
    }  

    // 캘린더 삭제 처리
    @RequestMapping(value="/calendarRemove.do", method=RequestMethod.POST)
    public String calendarRemove(HttpServletRequest req) {
        logger.info("calendarRemove");
        String[] chkVal = req.getParameterValues("chkVal");
        try {
            Calendar service = GoogleCalendarService.getCalendarService();
            for (String calendarId : chkVal) {
                service.calendars().delete(calendarId).execute();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "redirect:/coding.do";
    }    
    // 캘린더 수정 처리
    @RequestMapping(value="/calendarModify.do", method=RequestMethod.POST)
    public String calendarModify(CalendarDto calDto) {
        logger.info("calendarModify "+calDto.toString());    
        try {
            Calendar service = GoogleCalendarService.getCalendarService();
            com.google.api.services.calendar.model.Calendar calendar = service.calendars().get(calDto.getCalendarId()).execute();
            calendar.setSummary(calDto.getSummary());
            service.calendars().update(calendar.getId(), calendar).execute();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "redirect:/coding.do";
    }    

    // 캘린더 이동처리
    @RequestMapping(value="/schdule.do", method=RequestMethod.GET)
    public String schdule(Model model, String calendarId, String title) {
        logger.info("schdule");
        model.addAttribute("calendarId", calendarId);
        model.addAttribute("title", title);
        return "/admin/admincalendarMgr2";
    }    	
	
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
