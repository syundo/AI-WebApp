package model2.mvcboard;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/mvcboard/view.do")
public class ViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ViewController() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idx = req.getParameter("idx");
        boolean isViewed = false;

        // 쿠키 검사
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("viewed" + idx)) {
                    isViewed = true;
                    break;
                }
            }
        }

        if (!isViewed) {
            // 조회수 증가
            MVCBoardDAO dao = new MVCBoardDAO();
            dao.updateVisitCount(idx);

            // 쿠키 생성 (1일 유지)
            Cookie viewCookie = new Cookie("viewed" + idx, "true");
            viewCookie.setMaxAge(60 * 60 * 24); //쿠키 유효 기간: 하루로 설정(60초 * 60분 * 24시간)
            viewCookie.setPath("/"); //모든 경로에서 접근 가능하도록 설정
            resp.addCookie(viewCookie);

            dao.close();
        }

        // 게시글 가져오기
        MVCBoardDAO dao = new MVCBoardDAO();
        MVCBoardDTO dto = dao.selectView(idx);
        dao.close();

        // 줄바꿈 처리
        dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));

        // 첨부파일 이미지 여부 판별
        String ext = null, fileName = dto.getSfile();
        if (fileName != null) {
            ext = fileName.substring(fileName.lastIndexOf(".") + 1);
        }
        List<String> mimeList = Arrays.asList("png", "jpg", "gif");
        boolean isImage = mimeList.contains(ext);

        // 뷰로 포워딩
        req.setAttribute("dto", dto);
        req.setAttribute("isImage", isImage);
        req.getRequestDispatcher("/14MVCBoard/View.jsp").forward(req, resp);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}