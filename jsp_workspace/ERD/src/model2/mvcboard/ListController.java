package model2.mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.BoardPage;

/**
 * Servlet implementation class ListController
 */
@WebServlet("/mvcboard/list.do")
public class ListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 // DAO ?ƒ?„±
	       MVCBoardDAO dao = new MVCBoardDAO();

	        // ë·°ì— ? „?‹¬?•  ë§¤ê°œë³??ˆ˜ ???¥?š© ë§? ?ƒ?„±
	        Map<String, Object> map = new HashMap<String, Object>();

	        String searchField = req.getParameter("searchField");
	        String searchWord = req.getParameter("searchWord");
	        if (searchWord != null) {
	            // ì¿¼ë¦¬?Š¤?Š¸ë§ìœ¼ë¡? ? „?‹¬ë°›ì? ë§¤ê°œë³??ˆ˜ ì¤? ê²??ƒ‰?–´ê°? ?ˆ?‹¤ë©? map?— ???¥
	            map.put("searchField", searchField);
	            map.put("searchWord", searchWord);
	        }
	        int totalCount = dao.selectCount(map);  // ê²Œì‹œë¬? ê°œìˆ˜

	        /* ?˜?´ì§? ì²˜ë¦¬ start */
//	        ServletContext application = getServletContext();
//	        int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
//	        int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
	        int pageSize = 10; //?•œ ?˜?´ì§??— ì¶œë ¤?•  ê¸??˜ ê°œìˆ˜
	        int blockPage = 5; // ?˜?´ì§? ë²ˆí˜¸?˜ ê°œìˆ˜. 1.2.3.4.5
	        
	        // ?˜„?¬ ?˜?´ì§? ?™•?¸
	        int pageNum = 1;  // ê¸°ë³¸ê°?
	        String pageTemp = req.getParameter("pageNum");
	        if (pageTemp != null && !pageTemp.equals(""))
	            pageNum = Integer.parseInt(pageTemp); // ?š”ì²?ë°›ì? ?˜?´ì§?ë¡? ?ˆ˜? •

	        // ëª©ë¡?— ì¶œë ¥?•  ê²Œì‹œë¬? ë²”ìœ„ ê³„ì‚°
	        int start = (pageNum - 1) * pageSize + 1;  // ì²? ê²Œì‹œë¬? ë²ˆí˜¸
	        int end = pageNum * pageSize; // ë§ˆì?ë§? ê²Œì‹œë¬? ë²ˆí˜¸
	        map.put("start", start);
	        map.put("end", end);
	        /* ?˜?´ì§? ì²˜ë¦¬ end */

	        List<MVCBoardDTO> boardLists = dao.selectListPage(map);  // ê²Œì‹œë¬? ëª©ë¡ ë°›ê¸°
	        dao.close(); // DB ?—°ê²? ?‹«ê¸?

	        // ë·°ì— ? „?‹¬?•  ë§¤ê°œë³??ˆ˜ ì¶”ê?
	        // 1.2.3.4.5 ?˜?´ì§?ë²ˆí˜¸ ?ƒ?„±
	        String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "../mvcboard/list.do");  // ë°”ë¡œê°?ê¸? ?˜?—­ HTML ë¬¸ì?—´
	        map.put("pagingImg", pagingImg);
	        map.put("totalCount", totalCount);
	        map.put("pageSize", pageSize);
	        map.put("pageNum", pageNum);

	        // ? „?‹¬?•  ?°?´?„°ë¥? request ?˜?—­?— ???¥ ?›„ List.jspë¡? ?¬?›Œ?“œ
	        req.setAttribute("boardLists", boardLists);
	        req.setAttribute("map", map);
	        req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
