package com.mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/diary.do")
public class DiaryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public DiaryController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/myDiary/register.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 폼값을 DTO에 저장
		DiaryVO dVo = new DiaryVO();
		String weather = request.getParameter("weather");
		dVo.setWeather(weather);
		String title = request.getParameter("title");
		dVo.setTitle(title);
		String content = request.getParameter("content");
		dVo.setContent(content);

        // DAO를 통해 DB에 게시 내용 저장
		DiaryDAO dao = new DiaryDAO ();
        int result = dao.insertWrite(dVo);
        dao.close();

        // 성공 or 실패?
        if (result == 1) {  // 글쓰기 성공
        	response.sendRedirect("../diary.do");
        	System.out.println("일기 작성 성공");
        }
        else {  // 글쓰기 실패
        	System.out.println("일기 작성 실패");
        }
	}
}