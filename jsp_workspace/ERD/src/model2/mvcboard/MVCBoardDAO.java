package model2.mvcboard;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import common.DBConnPool;

public class MVCBoardDAO extends DBConnPool {
    public MVCBoardDAO() {
        super();
    }

    // ê²??ƒ‰ ì¡°ê±´?— ë§ëŠ” ê²Œì‹œë¬¼ì˜ ê°œìˆ˜ë¥? ë°˜í™˜?•©?‹ˆ?‹¤.
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0;
        String query = "SELECT COUNT(*) FROM mvcboard";
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%'";
        }
        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery(query);
            rs.next();
            totalCount = rs.getInt(1);
        }
        catch (Exception e) {
            System.out.println("ê²Œì‹œë¬? ì¹´ìš´?Š¸ ì¤? ?˜ˆ?™¸ ë°œìƒ");
            e.printStackTrace();
        }

        return totalCount;
    }

    // ê²??ƒ‰ ì¡°ê±´?— ë§ëŠ” ê²Œì‹œë¬? ëª©ë¡?„ ë°˜í™˜?•©?‹ˆ?‹¤(?˜?´ì§? ê¸°ëŠ¥ ì§??›).
    public List<MVCBoardDTO> selectListPage(Map<String,Object> map) {
        List<MVCBoardDTO> board = new ArrayList<MVCBoardDTO>();
        String query = " "
                     + "SELECT * FROM ( "
                     + "    SELECT Tb.*, ROWNUM rNum FROM ( "
                     + "        SELECT * FROM mvcboard ";

        if (map.get("searchWord") != null)
        {
            query += " WHERE " + map.get("searchField")
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }

        query += "        ORDER BY idx DESC "
               + "    ) Tb "
               + " ) "
               + " WHERE rNum BETWEEN ? AND ?";

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, map.get("start").toString());
            psmt.setString(2, map.get("end").toString());
            rs = psmt.executeQuery();

            while (rs.next()) {
                MVCBoardDTO dto = new MVCBoardDTO();

                dto.setIdx(rs.getString(1));
                dto.setName(rs.getString(2));
                dto.setTitle(rs.getString(3));
                dto.setContent(rs.getString(4));
                dto.setPostdate(rs.getDate(5));
                dto.setOfile(rs.getString(6));
                dto.setSfile(rs.getString(7));
                dto.setDowncount(rs.getInt(8));
                dto.setPass(rs.getString(9));
                dto.setVisitcount(rs.getInt(10));

                board.add(dto);
            }
        }
        catch (Exception e) {
            System.out.println("ê²Œì‹œë¬? ì¡°íšŒ ì¤? ?˜ˆ?™¸ ë°œìƒ");
            e.printStackTrace();
        }
        return board;
    }

    // ê²Œì‹œê¸? ?°?´?„°ë¥? ë°›ì•„ DB?— ì¶”ê??•©?‹ˆ?‹¤(?ŒŒ?¼ ?—…ë¡œë“œ ì§??›).
    public int insertWrite(MVCBoardDTO dto) {
        int result = 0;
        try {
            String query = "INSERT INTO mvcboard ( "
                         + " idx, name, title, content, ofile, sfile, pass) "
                         + " VALUES ( "
                         + " seq_board_num.NEXTVAL,?,?,?,?,?,?)";
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getName());
            psmt.setString(2, dto.getTitle());
            psmt.setString(3, dto.getContent());
            psmt.setString(4, dto.getOfile());
            psmt.setString(5, dto.getSfile());
            psmt.setString(6, dto.getPass());
            result = psmt.executeUpdate();
        }
        catch (Exception e) {
            System.out.println("ê²Œì‹œë¬? ?…? ¥ ì¤? ?˜ˆ?™¸ ë°œìƒ");
            e.printStackTrace();
        }
        return result;
    }

    // ì£¼ì–´ì§? ?¼? ¨ë²ˆí˜¸?— ?•´?‹¹?•˜?Š” ê²Œì‹œë¬¼ì„ DTO?— ?‹´?•„ ë°˜í™˜?•©?‹ˆ?‹¤.
    public MVCBoardDTO selectView(String idx) {
        MVCBoardDTO dto = new MVCBoardDTO();  // DTO ê°ì²´ ?ƒ?„±
        String query = "SELECT * FROM mvcboard WHERE idx=?";  // ì¿¼ë¦¬ë¬? ?…œ?”Œë¦? ì¤?ë¹?
        try {
            psmt = con.prepareStatement(query);  // ì¿¼ë¦¬ë¬? ì¤?ë¹?
            psmt.setString(1, idx);  // ?¸?ŒŒ?¼ë¯¸í„° ?„¤? •
            rs = psmt.executeQuery();  // ì¿¼ë¦¬ë¬? ?‹¤?–‰

            if (rs.next()) {  // ê²°ê³¼ë¥? DTO ê°ì²´?— ???¥
                dto.setIdx(rs.getString(1));
                dto.setName(rs.getString(2));
                dto.setTitle(rs.getString(3));
                dto.setContent(rs.getString(4));
                dto.setPostdate(rs.getDate(5));
                dto.setOfile(rs.getString(6));
                dto.setSfile(rs.getString(7));
                dto.setDowncount(rs.getInt(8));
                dto.setPass(rs.getString(9));
                dto.setVisitcount(rs.getInt(10));
            }
        }
        catch (Exception e) {
            System.out.println("ê²Œì‹œë¬? ?ƒ?„¸ë³´ê¸° ì¤? ?˜ˆ?™¸ ë°œìƒ");
            e.printStackTrace();
        }
        return dto;  // ê²°ê³¼ ë°˜í™˜
    }

    // ì£¼ì–´ì§? ?¼? ¨ë²ˆí˜¸?— ?•´?‹¹?•˜?Š” ê²Œì‹œë¬¼ì˜ ì¡°íšŒ?ˆ˜ë¥? 1 ì¦ê??‹œ?‚µ?‹ˆ?‹¤.
    public void updateVisitCount(String idx) {
        String query = "UPDATE mvcboard SET "
                     + " visitcount=visitcount+1 "
                     + " WHERE idx=?"; 
        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, idx);
            psmt.executeQuery();
        }
        catch (Exception e) {
            System.out.println("ê²Œì‹œë¬? ì¡°íšŒ?ˆ˜ ì¦ê? ì¤? ?˜ˆ?™¸ ë°œìƒ");
            e.printStackTrace();
        }
    }

    // ?‹¤?š´ë¡œë“œ ?šŸ?ˆ˜ë¥? 1 ì¦ê??‹œ?‚µ?‹ˆ?‹¤.
    public void downCountPlus(String idx) {
        String sql = "UPDATE mvcboard SET "
                + " downcount=downcount+1 "
                + " WHERE idx=? "; 
        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, idx);
            psmt.executeUpdate();
        }
        catch (Exception e) {}
    }
    // ?…? ¥?•œ ë¹„ë?ë²ˆí˜¸ê°? ì§?? •?•œ ?¼? ¨ë²ˆí˜¸?˜ ê²Œì‹œë¬¼ì˜ ë¹„ë?ë²ˆí˜¸?? ?¼ì¹˜í•˜?Š”ì§? ?™•?¸?•©?‹ˆ?‹¤.
    public boolean confirmPassword(String pass, String idx) {
        boolean isCorr = true;
        try {
            String sql = "SELECT COUNT(*) FROM mvcboard WHERE pass=? AND idx=?";
            psmt = con.prepareStatement(sql);
            psmt.setString(1, pass);
            psmt.setString(2, idx);
            rs = psmt.executeQuery();
            rs.next();
            if (rs.getInt(1) == 0) {
                isCorr = false;
            }
        }
        catch (Exception e) {
            isCorr = false;
            e.printStackTrace();
        }
        return isCorr;
    }

    // ì§?? •?•œ ?¼? ¨ë²ˆí˜¸?˜ ê²Œì‹œë¬¼ì„ ?‚­? œ?•©?‹ˆ?‹¤.
    public int deletePost(String idx) {
        int result = 0;
        try {
            String query = "DELETE FROM mvcboard WHERE idx=?";
            psmt = con.prepareStatement(query);
            psmt.setString(1, idx);
            result = psmt.executeUpdate();
        }
        catch (Exception e) {
            System.out.println("ê²Œì‹œë¬? ?‚­? œ ì¤? ?˜ˆ?™¸ ë°œìƒ");
            e.printStackTrace();
        }
        return result;
    }

    // ê²Œì‹œê¸? ?°?´?„°ë¥? ë°›ì•„ DB?— ???¥?˜?–´ ?ˆ?˜ ?‚´?š©?„ ê°±ì‹ ?•©?‹ˆ?‹¤(?ŒŒ?¼ ?—…ë¡œë“œ ì§??›).
    public int updatePost(MVCBoardDTO dto) {
        int result = 0;
        try {
            // ì¿¼ë¦¬ë¬? ?…œ?”Œë¦? ì¤?ë¹?
            String query = "UPDATE mvcboard"
                         + " SET title=?, name=?, content=?, ofile=?, sfile=? "
                         + " WHERE idx=? and pass=?";

            // ì¿¼ë¦¬ë¬? ì¤?ë¹?
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getName());
            psmt.setString(3, dto.getContent());
            psmt.setString(4, dto.getOfile());
            psmt.setString(5, dto.getSfile());
            psmt.setString(6, dto.getIdx());
            psmt.setString(7, dto.getPass());

            // ì¿¼ë¦¬ë¬? ?‹¤?–‰
            result = psmt.executeUpdate();
        }
        catch (Exception e) {
            System.out.println("ê²Œì‹œë¬? ?ˆ˜? • ì¤? ?˜ˆ?™¸ ë°œìƒ");
            e.printStackTrace();
        }
        return result;
    }
}