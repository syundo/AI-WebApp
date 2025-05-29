package com.naver.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Notice
 */
@WebServlet("/notice.do")
public class Notice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Notice() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean showNotice = true; // 공지사항 출력여부를 체크하기 위한 flag

	    // 쿠키 체크
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("noticeHidden".equals(cookie.getName())) {
	                showNotice = false;
	                break;
	            }
	        }
	    }
		
		RequestDispatcher dispatcher=request.getRequestDispatcher("notice.jsp");
		request.setAttribute("showNotice", showNotice);
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  Cookie cookie = new Cookie("noticeHidden", "true"); // 쿠키 이름 지정하여 생성( key, value 개념)
		  cookie.setMaxAge(60*60*24); //쿠키 유효 기간: 하루로 설정(60초 * 60분 * 24시간)
		  cookie.setPath("/"); //모든 경로에서 접근 가능하도록 설정
		  response.addCookie(cookie); //response에 Cookie 추가
	}

}