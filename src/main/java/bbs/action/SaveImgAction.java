package bbs.action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;


public class SaveImgAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        /*첨부파일 즉, 이미지파일은 multipartrequest라는 객체를
         * 생성하면 업로드가 된다. 그렇다면 우린 multipartrequest를 어떻게 만드는지만
         * 알고 있으면 된다. 이때 인자 5개짜리 생성자를 호출하여 생성한다
         * 이때 인자로 realPath가 있기에 이미지파일이 저장될 절대경로(editor_img)를 미리 준비되어야 한다*/

        ServletContext application = request.getServletContext();
        String realPath = application.getRealPath("/editor_img");
        try {
            MultipartRequest mr = new MultipartRequest(request, realPath, 1024 * 1024 * 5, "utf-8", new DefaultFileRenamePolicy());

            //저장된 정확한 경로와 파일명을 반환해야한다. 파일명을 알아내자

            File f = mr.getFile("upload");

            String f_name = null;
            if (f !=null){
                f_name = f.getName();
                request.setAttribute("f_name", f_name);
                System.out.println(f_name);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "jsp/bbs/saveImg.jsp";
    }
}