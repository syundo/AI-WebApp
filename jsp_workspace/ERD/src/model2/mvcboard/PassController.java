package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fileupload.FileUtil;
import utils.JSFunction;

@WebServlet("/mvcboard/pass.do")
public class PassController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        req.setAttribute("mode", req.getParameter("mode"));
        req.getRequestDispatcher("/14MVCBoard/Pass.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // ë§¤ê°œë³??ˆ˜ ???¥
        String idx = req.getParameter("idx");
        String mode = req.getParameter("mode");
        String pass = req.getParameter("pass");

        // ë¹„ë?ë²ˆí˜¸ ?™•?¸
        MVCBoardDAO dao = new MVCBoardDAO();
        boolean confirmed = dao.confirmPassword(pass, idx);
        dao.close();

        if (confirmed) { // ë¹„ë?ë²ˆí˜¸ ?¼ì¹?
            if (mode.equals("edit")) { // ?ˆ˜? • ëª¨ë“œ
                HttpSession session = req.getSession();
                session.setAttribute("pass", pass); // ?„¸?…˜ ?–´?Š¸ë¦¬ë·°?Š¸?— ë¹„ë?ë²ˆí˜¸ ???¥
                resp.sendRedirect("../mvcboard/edit.do?idx=" + idx); // ?ˆ˜? • ?™”ë©´ìœ¼ë¡? ?´?™
            }
            else if (mode.equals("delete")) { // ?‚­? œ?•˜?Š” ê²½ìš°
                dao = new MVCBoardDAO();
                MVCBoardDTO dto = dao.selectView(idx);
                int result = dao.deletePost(idx); // ê²Œì‹œë¬? ?‚­? œ
                dao.close();
                if (result == 1) { // ê²Œì‹œë¬? ?‚­? œ ?„±ê³? ?‹œ
                    String saveFileName = dto.getSfile(); // ???¥?œ ?ŒŒ?¼ëª?
                    FileUtil.deleteFile(req, "/Uploads", saveFileName); // ì²¨ë? ?ŒŒ?¼?„ ?‚­? œ
                }
                JSFunction.alertLocation(resp, "?‚­? œ?˜?—ˆ?Šµ?‹ˆ?‹¤.", "../mvcboard/list.do");
            }
        }
        else {  // ë¹„ë?ë²ˆí˜¸ ë¶ˆì¼ì¹?
            JSFunction.alertBack(resp, "ë¹„ë?ë²ˆí˜¸ ê²?ì¦ì— ?‹¤?Œ¨?–ˆ?Šµ?‹ˆ?‹¤.");
        }
    }
}