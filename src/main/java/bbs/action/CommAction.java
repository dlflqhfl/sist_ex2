package bbs.action;

import mybatis.dao.CommDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CommAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String b_idx = request.getParameter("b_idx");
        String writer = request.getParameter("writer");
        String content = request.getParameter("comm");
        String pwd = request.getParameter("pwd");
        String cPage = request.getParameter("cPage");
        String bname = request.getParameter("bname");

        String ip = request.getRemoteAddr();

        int cnt = CommDAO.insertComm(b_idx, writer, content, pwd, ip);
        String path = "Controller";
        if (cnt > 0) {
            path = "Controller?type=view&b_idx="+b_idx+"&cPage="+cPage+"&bname="+bname;
        }

        return path;
    }
}