package utils;

public class BoardPage {
    public static String pagingStr(int totalCount, int pageSize, int blockPage,
            int pageNum, String reqUrl) {
        String pagingStr = "";

        // ?‹¨ê³? 3 : ? „ì²? ?˜?´ì§? ?ˆ˜ ê³„ì‚°
        int totalPages = (int) (Math.ceil(((double) totalCount / pageSize)));

        // ?‹¨ê³? 4 : '?´? „ ?˜?´ì§? ë¸”ë¡ ë°”ë¡œê°?ê¸?' ì¶œë ¥
        int pageTemp = (((pageNum - 1) / blockPage) * blockPage) + 1;
        if (pageTemp != 1) {
            pagingStr += "<a href='" + reqUrl + "?pageNum=1'>[ì²? ?˜?´ì§?]</a>";
            pagingStr += "&nbsp;";
            pagingStr += "<a href='" + reqUrl + "?pageNum=" + (pageTemp - 1)
                         + "'>[?´? „ ë¸”ë¡]</a>";
        }

        // ?‹¨ê³? 5 : ê°? ?˜?´ì§? ë²ˆí˜¸ ì¶œë ¥
        int blockCount = 1;
        while (blockCount <= blockPage && pageTemp <= totalPages) {
            if (pageTemp == pageNum) {
                // ?˜„?¬ ?˜?´ì§??Š” ë§í¬ë¥? ê±¸ì? ?•Š?Œ
                pagingStr += "&nbsp;" + pageTemp + "&nbsp;";
            } else {
                pagingStr += "&nbsp;<a href='" + reqUrl + "?pageNum=" + pageTemp
                             + "'>" + pageTemp + "</a>&nbsp;";
            }
            pageTemp++;
            blockCount++;
        }

        // ?‹¨ê³? 6 : '?‹¤?Œ ?˜?´ì§? ë¸”ë¡ ë°”ë¡œê°?ê¸?' ì¶œë ¥
        if (pageTemp <= totalPages) {
            pagingStr += "<a href='" + reqUrl + "?pageNum=" + pageTemp
                         + "'>[?‹¤?Œ ë¸”ë¡]</a>";
            pagingStr += "&nbsp;";
            pagingStr += "<a href='" + reqUrl + "?pageNum=" + totalPages
                         + "'>[ë§ˆì?ë§? ?˜?´ì§?]</a>";
        }

        return pagingStr;
    }
}