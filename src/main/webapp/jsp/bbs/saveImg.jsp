<%--
  Created by IntelliJ IDEA.
  User: 무능호
  Date: 2024-06-05
  Time: 오후 4:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${f_name != null}">
    {
    "img_url": "${pageContext.request.contextPath}/editor_img/${f_name}"
    }
</c:if>
<%--<%
    Object obg = request.getAttribute("f_name");
    String f_name = null;
    if(obg != null){
        f_name = (String)obg;
        System.out.println(request.getContextPath());
%>--%>
<%--
{
    "img_url": "<%=request.getContextPath()%>/editor_img/${f_name}"
}--%>
<%--
<%
    }
%>--%>
