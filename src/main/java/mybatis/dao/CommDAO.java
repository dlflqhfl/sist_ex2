package mybatis.dao;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.Map;

public class CommDAO {

    public static int insertComm(String b_idx, String writer, String content, String pwd, String ip) {
        Map<String, String> map = new HashMap<>();

        map.put("b_idx", b_idx);
        map.put("writer", writer);
        map.put("content", content);
        map.put("pwd", pwd);
        map.put("ip", ip);

        SqlSession ss = FactoryService.getFactory().openSession();

        int cnt = ss.insert("comm.add", map);

        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();

        return cnt;
    }
}
