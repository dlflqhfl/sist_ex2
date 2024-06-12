package bbs.action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import mybatis.dao.BbsDAO;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class EditAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //현재 객체를 호출하는 곳이 적어도.. 두 군데다.
        // 1) view.jsp에서 [수정]버튼을 눌렀을 때 : get방식
        // 2) edit.jsp에서 [저장]버튼을 눌렀을 때 : post방식
        // 이 두 곳에서 호출될 때, 각각의 경우에 따라 다르게 동작해야 한다.
        // 이를 구분하기 위해 request에 특정한 값을 저장하자.
        // 이 값은 view.jsp에서 [수정]버튼을 눌렀을 때는 "edit"라는 문자열을 저장하고
        // edit.jsp에서 [저장]버튼을 눌렀을 때는 "update"라는 문자열을 저장하자.
        // 이렇게 저장된 값은 이곳(EditAction)에서 꺼내어 어떤 동작을 할지 결정하면 된다.
        // 이때, 이 값은 jsp에서도 사용되어야 하므로 request에 저장하자.
        // 이 값은 jsp에서도 사용되어야 하므로 request에 저장하자.
        String enc_type = request.getContentType();
        String viewPath = null;

        if (enc_type == null){
            //view.jsp에서 [수정]버튼을 눌렀을 때
            String b_idx = request.getParameter("b_idx");
            String bname = request.getParameter("bname");

            BbsDAO vo = BbsDAO.getbbs(b_idx);
            request.setAttribute("bvo", vo);

            viewPath = "jsp/"+bname+"/edit.jsp";
        }else if (enc_type.startsWith("multipart")){
            try {//첨부된 파일이 저장될 곳을 절대경로로 만들어야 한다.
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
                String b_idx = mr.getParameter("b_idx");
                String title = mr.getParameter("title");
                String content = mr.getParameter("content");
                String bname2 = mr.getParameter("bname");

                //첨부파일은 이미 서버에 저장된 상태이지만
                //새로 업로드된 파일명을 DB에 수정작업을 해야한다.

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

                int cnt = BbsDAO.edit(b_idx, title, content,
                        fname, oname, ip);

                viewPath = "/jsp/"+bname2+"/edit_success.jsp";

            }catch(Exception e) {
                e.printStackTrace();
            }
        }
        return viewPath;
    }
}
