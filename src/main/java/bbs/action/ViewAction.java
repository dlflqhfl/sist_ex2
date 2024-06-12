package bbs.action;

import mybatis.dao.BbsDAO;
import mybatis.vo.BbsVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class ViewAction implements Action {
    List<BbsVO> r_list; // 사용자가 한번이라도 읽은 게시물이 저장될 곳

    public boolean checkBbs(BbsVO vo){
        boolean value = true;
        for(BbsVO bvo : r_list){
            if(bvo.getB_idx().equals(vo.getB_idx())){
                value = false;
                break;
            }
        }
        return value;
    }

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //BbsDAO의 함수 getBbs를 호출하여
        //원글의 모든 정보를 받아온다.
        //그리고 이를 request에 담아서 view.jsp로 넘긴다.
        //이때 view.jsp에서는 request에 담긴 정보를 꺼내서
        //화면에 출력하면 된다.

        //세션을 얻어내자!

        HttpSession session = request.getSession();
        Object obj = session.getAttribute("read_list");

        if (obj == null) {
            r_list = new ArrayList<>();
            session.setAttribute("read_list", r_list);
        }

        response.setCharacterEncoding("UTF-8");

        String b_idx = request.getParameter("b_idx");
        String viewPath = null;
        String bname = request.getParameter("bname");

        BbsVO bvo = BbsDAO.getbbs(b_idx);

        if (bvo != null) {
            //조회수 증가
            if (checkBbs(bvo)) {
                BbsDAO.hit(b_idx); //조회수 증가
                r_list.add(bvo);
            }

            request.setAttribute("bvo", bvo);
            viewPath = "jsp/"+bname+"/view.jsp";
        }

        return viewPath;
    }
}