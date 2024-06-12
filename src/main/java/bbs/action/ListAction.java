package bbs.action;

import bbs.util.Paging;
import mybatis.dao.BbsDAO;
import mybatis.vo.BbsVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		//페이징 처리를 위한 객체생성
		Paging page = new Paging(5, 3);
		String bname = request.getParameter("bname");
		//현재페이지값 받기
		String cPage = request.getParameter("cPage");
		
		//전체페이지 수를 구하기
		page.setTotalRecord(BbsDAO.getCount(bname));		
		
		if(cPage != null) {
			//int nowPage = Integer.parseInt(cPage);
			//page.setNowPage(nowPage);
			page.setNowPage(Integer.parseInt(cPage));
			//이때!
			//게시물을 추출할 때 사용되는 begin과 end가 구해지고
			//시작페이지(startPage)와 끝페이지(endPage)도 구해졌다.
		}else
			page.setNowPage(1);
				
		BbsVO[] ar = BbsDAO.getList(
			bname, page.getBegin(), page.getEnd());
		
		//위의 배열 ar을 jsp에서 표현하기 위해 request에 저장하자
		request.setAttribute("ar", ar);
		request.setAttribute("page", page);
		
		return "/jsp/"+bname+"/list.jsp";
	}

}
