package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fileupload.FileUtil;
import utils.JSFunction;

/**
 * Servlet implementation class WriteConntroller
 */
@WebServlet("/mvcboard/write.do")
@MultipartConfig(
	maxFileSize = 1024 * 1024 * 1,
	maxRequestSize = 1024 * 1024 * 10
)
public class WriteConntroller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WriteConntroller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/14MVCBoard/Write.jsp").forward(req, resp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 1. ?ŒŒ?¼ ?—…ë¡œë“œ ì²˜ë¦¬ =============================
        // ?—…ë¡œë“œ ?””? ‰?„°ë¦¬ì˜ ë¬¼ë¦¬?  ê²½ë¡œ ?™•?¸
        String saveDirectory = req.getServletContext().getRealPath("/Uploads");
        System.out.println(saveDirectory);
                
        // ?ŒŒ?¼ ?—…ë¡œë“œ
        String originalFileName = "";
        try {
        	originalFileName = FileUtil.uploadFile(req, saveDirectory);
        }
        catch (Exception e) {
        	JSFunction.alertLocation(resp, "?ŒŒ?¼ ?—…ë¡œë“œ ?˜¤ë¥˜ì…?‹ˆ?‹¤.",
                    "../mvcboard/write.do");
        	return;
		}

        // 2. ?ŒŒ?¼ ?—…ë¡œë“œ ?™¸ ì²˜ë¦¬ =============================
        // ?¼ê°’ì„ DTO?— ???¥
        MVCBoardDTO dto = new MVCBoardDTO(); 
        dto.setName(req.getParameter("name"));
        dto.setTitle(req.getParameter("title"));
        dto.setContent(req.getParameter("content"));
        dto.setPass(req.getParameter("pass"));

        // ?›ë³? ?ŒŒ?¼ëª…ê³¼ ???¥?œ ?ŒŒ?¼ ?´ë¦? ?„¤? •
        if (originalFileName != "") { 
        	// ?ŒŒ?¼ëª? ë³?ê²?
        	String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
        	
            dto.setOfile(originalFileName);  // ?›?˜ ?ŒŒ?¼ ?´ë¦?
            dto.setSfile(savedFileName);  // ?„œë²„ì— ???¥?œ ?ŒŒ?¼ ?´ë¦?
        }

        // DAOë¥? ?†µ?•´ DB?— ê²Œì‹œ ?‚´?š© ???¥
        MVCBoardDAO dao = new MVCBoardDAO();
        int result = dao.insertWrite(dto);
        dao.close();

        // ?„±ê³? or ?‹¤?Œ¨?
        if (result == 1) {  // ê¸??“°ê¸? ?„±ê³?
            resp.sendRedirect("../mvcboard/list.do");
        }
        else {  // ê¸??“°ê¸? ?‹¤?Œ¨
        	 JSFunction.alertLocation(resp, "ê¸??“°ê¸°ì— ?‹¤?Œ¨?–ˆ?Šµ?‹ˆ?‹¤.", "../mvcboard/write.do");
        }
	}

}
