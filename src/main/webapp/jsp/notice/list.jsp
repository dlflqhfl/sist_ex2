<%@page import="mybatis.vo.BbsVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css"/>
<style type="text/css"> 
	#bbs table {
	    width:580px;
	    margin-left:10px;
	    border:1px solid black;
	    border-collapse:collapse;
	    font-size:14px;
	    
	}
	
	#bbs table caption {
	    font-size:20px;
	    font-weight:bold;
	    margin-bottom:10px;
	}
	
	#bbs table th,#bbs table td {
	    text-align:center;
	    border:1px solid black;
	    padding:4px 10px;
	}
	
	.no {width:15%}
	.subject {width:30%}
	.writer {width:20%}
	.reg {width:20%}
	.hit {width:15%}
	.title{background:lightsteelblue}
	
	.odd {background:silver}
	
	/* paging */
	
	table tfoot ol.paging {
	    list-style:none;
	}
	
	table tfoot ol.paging li {
	    float:left;
	    margin-right:8px;
	}
	
	table tfoot ol.paging li a {
	    display:block;
	    padding:3px 7px;
	    border:1px solid #00B3DC;
	    color:#2f313e;
	    font-weight:bold;
	}
	
	table tfoot ol.paging li a:hover {
	    background:#00B3DC;
	    color:white;
	    font-weight:bold;
	}
	
	.disable {
	    padding:3px 7px;
	    border:1px solid silver;
	    color:silver;
	}
	
	.now {
	   padding:3px 7px;
	    border:1px solid #ff4aa5;
	    background:#ff4aa5;
	    color:white;
	    font-weight:bold;
	}
		
</style>
</head>
<body>
<div id="wrap">
	<header>
		<jsp:include page="/jsp/menu.jsp"/>
	</header>
	<div id="bbs">
		<table summary="공지사항 목록">
			<caption>공지사항 목록</caption>
			<thead>
				<tr class="title">
					<th class="no">번호</th>
					<th class="subject">제목</th>
					<th class="writer">글쓴이</th>
					<th class="reg">날짜</th>
					<th class="hit">조회수</th>
				</tr>
			</thead>
			
			<tfoot>
                      <tr>
                          <td colspan="4">
                              <ol class="paging">
                                  
               

<li><a href="#">이전으로</a></li>

	<li class="now">1</li>
         
	<li><a href="#">2</a></li>


 
		<li><a href="#">다음으로</a></li>
	
                              </ol>
                          </td>
						  <td>
							<input type="button" value="글쓰기"
			onclick="javascript:location.href='Controller?type=write&bname=notice'"/>
						  </td>
                      </tr>
                  </tfoot>
			<tbody>
<%
	Object obj = request.getAttribute("ar");
	if(obj != null){
		BbsVO[] ar = (BbsVO[])obj;
		for(BbsVO vo: ar){
%>			
				<tr>
					<td><%=vo.getB_idx() %></td>
					<td style="text-align: left">
						<a href="#">
					<%=vo.getSubject() %>
					</a></td>
					<td><%=vo.getWriter() %></td>
					<td><%=vo.getWrite_date() %></td>
					<td><%=vo.getHit() %></td>
				</tr>
<%
		}//for의 끝
	}else{
%>
			<tr>
				<td colspan="5">
				등록된 데이터가 없습니다.
				</td>
			</tr>
<%		
	}
%>
			</tbody>
		</table>
		
	</div>
</div>	
</body>
</html>
    