<%@ page import="mybatis.vo.BbsVO" %>
<%@ page import="mybatis.vo.CommVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style type="text/css">
        body {
            background-color: #f3f3f3;
            font-family: Arial, sans-serif;
        }
        #bbs {
            max-width: 800px;
            margin: auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        #bbs table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        #bbs table caption {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        #bbs table th,
        #bbs table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        #bbs table th {
            background-color: #f9f9f9;
            color: #333;
        }
        .list_bg {
            background: rgb(249,250,255);
            padding: 20px;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        .list_item {
            padding: 10px;
            background: #fafafa;
            border-radius: 4px;
        }
        .subject {
            color: #007BFF;
        }
        .title {
            background: lightsteelblue;
        }
        .odd {
            background: silver;
        }
        form {
            display: flex;
            flex-direction: column;
            width: 100%;
            max-width: 600px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: white;
            box-shadow: 0 0 5px rgba(0,0,0,.1);
        }
        form input[type="text"],
        form input[type="password"] {
            height: 30px;
        }
        form textarea {
            height: 70px;
        }

        form input[type="submit"] {
            cursor: pointer;
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 4px;
            font-size: 16px;
            margin-top: 10px;
        }
        form input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div id="bbs">
    <form method="post">
        <table summary="게시판 글쓰기">
            <caption>게시판 글쓰기</caption>
            <c:set var="bvo" value="${requestScope.bvo}"/>
            <c:if test="${not empty bvo and bvo != null}">
           <%-- <%
                request.setCharacterEncoding("UTF-8");
                Object obj = request.getAttribute("bvo");

                if (obj == null) {
                    System.out.println("bvo가 null이다.");
                }

                if (obj != null) {
                    BbsVO bbs = (BbsVO) obj;
            %>--%>
            <tbody>
            <tr>
                <th>제목:</th>
                <td>${bvo.subject}</td>
            </tr>
            <c:if test="bvo.file_name != null">
                <tr>
                    <th>첨부파일:</th>
                    <td><a href="javascript:down('${bvo.file_name}')">${bvo.file_name}</a></td>
                </tr>
            <%--<% if (bbs.getFile_name() != null) { %>

            <%
                }
            %>--%>
            </c:if>

            <tr>
                <th>이름:</th>
                <td>${bvo.writer}</td>
            </tr>
            <tr>
                <th>내용:</th>
                <td>${bvo.content}</td>
            </tr>

            <tr>
                <td colspan="2">
                    <input type="button" value="수정"
                           onclick="javascript:location.href='Controller?type=edit&b_idx=>${bvo.b_idx}&bname=${param.bname}&cPage=${param.cPage}'"/>
                    <input type="button" value="삭제"
                           onclick="delbbs()"/>
                    <input type="button" value="목록"
                           onclick="javascript:location.href='Controller?type=list&b_idx=${bvo.b_idx}&bname=${param.bname}&cPage=${param.cPage}'"/>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
    <form method="post" action="Controller">
        이름:<input type="text" name="writer"/><br/>
        내용:<textarea rows="4" cols="55" name="comm"></textarea><br/>
        비밀번호:<input type="password" name="pwd"/><br/>

        <input type="hidden" name="b_idx" value=${param.b_idx}>
        <input type="hidden" name="bname" value="${param.bname}"/>
        <input type="hidden" name="cPage" value="${param.cPage}"/>
        <input type="hidden" name="type" value="comm"/>
        <input type="submit" value="저장하기"/>
    </form>

    댓글들
    <hr/>
    <c:forEach var="cvo" items="${bvo.c_list}">
    <%--<%
        for (CommVO cvo : bbs.getC_list()){
    %>--%>

    <div class = "list_bg">
        <div class="list_item">
            이름:${cvo.writer} &nbsp;&nbsp;
            날짜:${cvo.write_date}<br/>
            내용:${cvo.content}
        </div>
    </div>
    <%--<%
        }
    %>--%>
    </c:forEach>
    <form name="frm" action="Controller" method="post">
        <input type="hidden" name="type" value="del">
        <input type="hidden" name="fname"/>
        <input type="hidden" name="bname" value="${param.bname}">
        <input type="hidden" name="b_idx" value="${param.b_idx}">
        <input type="hidden" name="cPage" value="${param.cPage}">
    </form>

</div>

<script type="text/javascript">

    function down(fname) {
        //인자로 사용자가 클릭한 파일명을 받는다.
        //이것을 현재 문서안에 있는 frm이라는 폼 객체에 있는 fname이라는 이름의
        //fname이라는 hidden요소의 값(value)으로 설정한다.

        document.frm.fname.value = fname;
        document.frm.type.value = "down";
        document.frm.submit();
    }

    function delbbs(){
        if(confirm("삭제하시겠습니까?")){
            document.frm.type.value = "del";
            document.frm.submit();
        }
    }

</script>
</body>


</html>
</c:if>

<c:if test="${empty bvo or bvo == null}">
    <c:redirect url="Controller"/>
</c:if>


<%--<%
    } else {
        response.sendRedirect("Controller");
    }
%>--%>


