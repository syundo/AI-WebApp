package model2.mvcboard;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ViewController
 */
@WebServlet("/mvcboard/view.do")
public class ViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Í≤åÏãúÎ¨? Î∂àÎü¨?ò§Í∏?
        MVCBoardDAO dao = new MVCBoardDAO();
        String idx = req.getParameter("idx");
        dao.updateVisitCount(idx);  // Ï°∞Ìöå?àò 1 Ï¶ùÍ?
        MVCBoardDTO dto = dao.selectView(idx);
        dao.close();

        // Ï§ÑÎ∞îÍø? Ï≤òÎ¶¨
        dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
        
        //Ï≤®Î??åå?ùº ?ôï?û•?ûê Ï∂îÏ∂ú Î∞? ?ù¥ÎØ∏Ï? ???ûÖ ?ôï?ù∏
        String ext = null, fileName = dto.getSfile();
        if(fileName!=null) {
        	ext = fileName.substring(fileName.lastIndexOf(".")+1);
        }
        String[] mimeStr = {"png","jpg","gif"};
        List<String> mimeList = Arrays.asList(mimeStr);
        boolean isImage = false;
        if(mimeList.contains(ext)) {
        	isImage = true;
        }
        
        
        // Í≤åÏãúÎ¨?(dto) ???û• ?õÑ Î∑∞Î°ú ?è¨?õå?ìú
        req.setAttribute("dto", dto);
        req.setAttribute("isImage", isImage);
        req.getRequestDispatcher("/14MVCBoard/View.jsp").forward(req, resp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
