package model2.mvcboard;

import java.fileupload.FileUtil;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import utils.JSFunction;

@WebServlet("/mvcboard/edit.do")
@MultipartConfig(
	maxFileSize = 1024 * 1024 * 1,
	maxRequestSize = 1024 * 1024 * 10
)
public class EditController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idx = req.getParameter("idx");
        MVCBoardDAO dao = new MVCBoardDAO();
        MVCBoardDTO dto = dao.selectView(idx);
        req.setAttribute("dto", dto);
        req.getRequestDispatcher("/14MVCBoard/Edit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        // 1. ?ŒŒ?¼ ?—…ë¡œë“œ ì²˜ë¦¬ =============================
        // ?—…ë¡œë“œ ?””? ‰?„°ë¦¬ì˜ ë¬¼ë¦¬?  ê²½ë¡œ ?™•?¸
        String saveDirectory = req.getServletContext().getRealPath("/Uploads");
      
        // ?ŒŒ?¼ ?—…ë¡œë“œ
        String originalFileName = "";
        try {
        	originalFileName = FileUtil.uploadFile(req, saveDirectory);
        }
        catch (Exception e) {
        	JSFunction.alertBack(resp, "?ŒŒ?¼ ?—…ë¡œë“œ ?˜¤ë¥˜ì…?‹ˆ?‹¤.");
        	return;
		}

        // 2. ?ŒŒ?¼ ?—…ë¡œë“œ ?™¸ ì²˜ë¦¬ =============================
        // ?ˆ˜? • ?‚´?š©?„ ë§¤ê°œë³??ˆ˜?—?„œ ?–»?–´?˜´
        String idx = req.getParameter("idx");
        String prevOfile = req.getParameter("prevOfile");
        String prevSfile = req.getParameter("prevSfile");

        String name = req.getParameter("name");
        String title = req.getParameter("title");
        String content = req.getParameter("content");
            
        // ë¹„ë?ë²ˆí˜¸?Š” session?—?„œ ê°?? ¸?˜´
        HttpSession session = req.getSession();
        String pass = (String)session.getAttribute("pass");

        // DTO?— ???¥
        MVCBoardDTO dto = new MVCBoardDTO();
        dto.setIdx(idx);
        dto.setName(name);
        dto.setTitle(title);
        dto.setContent(content);
        dto.setPass(pass);
            
        // ?›ë³? ?ŒŒ?¼ëª…ê³¼ ???¥?œ ?ŒŒ?¼ ?´ë¦? ?„¤? •
        if (originalFileName != "") {             
        	String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
        	
            dto.setOfile(originalFileName);  // ?›?˜ ?ŒŒ?¼ ?´ë¦?
            dto.setSfile(savedFileName);  // ?„œë²„ì— ???¥?œ ?ŒŒ?¼ ?´ë¦?

            // ê¸°ì¡´ ?ŒŒ?¼ ?‚­? œ
            FileUtil.deleteFile(req, "/Uploads", prevSfile);
        }
        else {
            // ì²¨ë? ?ŒŒ?¼?´ ?—†?œ¼ë©? ê¸°ì¡´ ?´ë¦? ?œ ì§?
            dto.setOfile(prevOfile);
            dto.setSfile(prevSfile);
        }

        // DB?— ?ˆ˜? • ?‚´?š© ë°˜ì˜
        MVCBoardDAO dao = new MVCBoardDAO();
        int result = dao.updatePost(dto);
        dao.close();

        // ?„±ê³? or ?‹¤?Œ¨?
        if (result == 1) {  // ?ˆ˜? • ?„±ê³?
            session.removeAttribute("pass");
            resp.sendRedirect("../mvcboard/view.do?idx=" + idx);
        }
        else {  // ?ˆ˜? • ?‹¤?Œ¨
            JSFunction.alertLocation(resp, "ë¹„ë?ë²ˆí˜¸ ê²?ì¦ì„ ?‹¤?‹œ ì§„í–‰?•´ì£¼ì„¸?š”.",
                "../mvcboard/view.do?idx=" + idx);
        }
    }
}