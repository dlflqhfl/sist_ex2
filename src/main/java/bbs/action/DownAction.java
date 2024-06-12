package bbs.action;

import javax.servlet.ServletContext;
import javax.servlet.ServletInputStream;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

public class DownAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //전달되어 오는 파라미터 받기(fname)

        String fname = request.getParameter("fname");

        //위 파일은 서버의 절대경로 ../upload/ 에 저장되어 있으므로
        //이 파일을 읽어들여서 클라이언트에게 전송하면 된다.

        ServletContext application = request.getServletContext();

        //절대경로를 얻어낸다.
        String realPath = application.getRealPath("/upload/" + fname);
        System.out.println(realPath);

        File f = new File(realPath);

        //실제 파일 존재여부 확인
        if (f.exists()) {
            byte[] buf = new byte[1024 * 8];

            //서버 입장에서는 실제 존재하는 파일의 내욜을 읽기 하여
            //요청한 사용자에게 응답으로 보내야한다.
            //응답할때는 파일의 내용을 읽어들여서 응답해야하므로
            //인풋스트림이 필요하고

            FileInputStream fis = null;
            BufferedInputStream bis = null;

            //요청한 곳으로 파일의 내용을 주기 위해 필요한 스트림
            //서블릿아웃풋스트림이 필요하다.

            ServletOutputStream sos = null; //접속자에게 응답으로 다운로드를 시켜야한다
            //이때 response로 얻을 수 있는 스트림이
            //servletoutputstream이기 때문에 선언되어야 하는 스트림
            BufferedOutputStream bos = null;

            try {
                //접속자 화면에 다운로드 창을 보여준다
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + new String(fname.getBytes("utf-8"), "8859_1"));

                //먼저 파일로부터 자원을 읽기할 스트림 생성
                fis = new FileInputStream(f);
                bis = new BufferedInputStream(fis);

                //응답객체를 통해 아웃풋 스트림 얻기
                sos = response.getOutputStream();
                bos = new BufferedOutputStream(sos);

                int size = -1;

                while ((size = bis.read(buf)) != -1) {
                    bos.write(buf, 0, size);
                }
                bos.flush();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (bos != null) bos.close();
                    if (bis != null) bis.close();
                    if (fis != null) fis.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }
}
