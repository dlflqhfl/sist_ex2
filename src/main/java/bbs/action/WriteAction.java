package bbs.action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import mybatis.dao.BbsDAO;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class WriteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		// bname이라는 파라미터 값 받기
		String bname = request.getParameter("bname");
		String viewPath = null;
		
		// 글쓰기 화면으로 이동하거나 데이터들을 더 받아서 DB에 저장하거나
		// 둘 중 하나를 하게 된다.
		// 현재 액션객체를 호출하는 곳이 두군데나 된다.
		//  1) list.jsp에서 [글쓰기]버튼을 클릭했을 때 get방식으로 오게된다.
		//  2) write.jsp에서 [저장]버튼을 클릭했을 때 post방식으로 오게된다.
		
		String enc_type = request.getContentType();
		System.out.println("type:"+enc_type);
		
		if(enc_type == null) {
			viewPath = "/jsp/"+bname+"/write.jsp";
		}else if(enc_type.startsWith("multipart")) {
			//파일첨부가 된 상태에서 현재 객체가 불려진 경우
			// 폼에 enctype이 multipart....로 지정되었다면
			// 절대로 request.getParameter()로 값을 받지 못한다.
			//String title = request.getParameter("title");
			//System.out.println("TITLE:"+title);
			//위의 결과는 null이다.
			//반드시 cos.jar라는 라이브러리에 있는 MultipartRequest를
			// 이용해야 한다.
			try {
				//첨부된 파일이 저장될 곳을 절대경로로 만들어야 한다.
				ServletContext application = 
						request.getServletContext();
				
				String realPath = 
						application.getRealPath("/upload");

				File directory = new File(realPath);
				if (!directory.exists()){
					directory.mkdir();
				}
				
				//첨부파일과 다른 파라미터들을 받기 위해
				//MultipartRequest객체를 생성
				MultipartRequest mr = 
					new MultipartRequest(request, 
						realPath, 100*1024*1024, "utf-8",
						new DefaultFileRenamePolicy());
				//이때 이미 첨부파일은 upload라는 폴더에 저장된 상태다.
				
				//나머지 파라미터 값들 받기
				String title = mr.getParameter("title");
				String writer = mr.getParameter("writer");
				String content = mr.getParameter("content");
				String bname2 = mr.getParameter("bname");
				
				//이미 업로드된 첨부파일이 파일명이 변경됐을 것 같은 느낌...
				File f = mr.getFile("file");
				String fname = null;
				String oname = null;
				
				//만약! 파일첨부하지 않았다면 f에는 null이다.
				if(f != null) {
					fname = f.getName();// 현재 저장된 파일명
					
					//원래 파일명
					oname = mr.getOriginalFileName("file");
				}
				
				// 요청자의 ip
				String ip = request.getRemoteAddr();
				
				int cnt = BbsDAO.add(title, writer, content,
						fname, oname, ip, bname2);

				viewPath = "/jsp/"+bname2+"/add_success.jsp";

			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return viewPath;
	}
}