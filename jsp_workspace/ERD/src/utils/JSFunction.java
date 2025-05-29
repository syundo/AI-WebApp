package utils;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

public class JSFunction {
    // ë©”ì‹œì§? ?•Œë¦¼ì°½?„ ?„?š´ ?›„ ëª…ì‹œ?•œ URLë¡? ?´?™?•©?‹ˆ?‹¤.
    public static void alertLocation(String msg, String url, JspWriter out) {
        try {
            String script = "<script>"  // ?‚½?…?•  ?ë°”ìŠ¤?¬ë¦½íŠ¸ ì½”ë“œ
                          + "    alert('" + msg + "');"
                          + "    location.href='" + url + "';"
                          + "</script>";
            out.println(script);  // ?ë°”ìŠ¤?¬ë¦½íŠ¸ ì½”ë“œë¥? out ?‚´?¥ ê°ì²´ë¡? ì¶œë ¥(?‚½?…)
        }
        catch (Exception e) {}
    }

    // ë©”ì‹œì§? ?•Œë¦¼ì°½?„ ?„?š´ ?›„ ?´? „ ?˜?´ì§?ë¡? ?Œ?•„ê°‘ë‹ˆ?‹¤.
    public static void alertBack(String msg, JspWriter out) {
        try {
            String script = "<script>"
                          + "    alert('" + msg + "');"
                          + "    history.back();"
                          + "</script>";
            out.println(script);
        }
        catch (Exception e) {}
    }

    // ë©”ì‹œì§? ?•Œë¦¼ì°½?„ ?„?š´ ?›„ ëª…ì‹œ?•œ URLë¡? ?´?™?•©?‹ˆ?‹¤.
    public static void alertLocation(HttpServletResponse resp, String msg, String url) {
        try {
            resp.setContentType("text/html;charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            String script = "<script>"
                          + "    alert('" + msg + "');"
                          + "    location.href='" + url + "';"
                          + "</script>";
            writer.print(script);
        }
        catch (Exception e) {}
    }

    // ë©”ì‹œì§? ?•Œë¦¼ì°½?„ ?„?š´ ?›„ ?´? „ ?˜?´ì§?ë¡? ?Œ?•„ê°‘ë‹ˆ?‹¤.
    public static void alertBack(HttpServletResponse resp, String msg) {
        try {
            resp.setContentType("text/html;charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            String script = "<script>"
                          + "    alert('" + msg + "');"
                          + "    history.back();"
                          + "</script>";
            writer.print(script);
        }
        catch (Exception e) {}
    }
}