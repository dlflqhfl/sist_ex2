package bbs.action;

import bbs.control.Controller;
import mybatis.dao.BbsDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DelAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String b_idx = request.getParameter("b_idx");
        String bname = request.getParameter("bname");
        String cPage = request.getParameter("cPage");

        int cnt = BbsDAO.del(b_idx);

        String path = "Controller";

        if (cnt > 0) {
            path = "Controller?type=list&bname="+bname+"&cPage="+cPage;
        }

        return path;
    }
}