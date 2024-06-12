<%@page import="bbs.util.Paging" %>
<%@page import="mybatis.vo.BbsVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="../../css/style.css"/>
	<style type="text/css">
		#bbs {
			width: 580px;
			margin: auto;
		}

		#bbs table {
			width:580px;
			border:1px solid black;
			border-collapse:collapse;
			font-size:14px;
		}

        #bbs table caption {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        #bbs table th, #bbs table td {
            text-align: center;
            border: 1px solid black;
            padding: 4px 10px;
        }

        .no {
            width: 15%
        }

        .subject {
            width: 30%
        }

        .writer {
            width: 20%
        }

        .reg {
            width: 20%
        }

        .hit {
            width: 15%
        }

        .title {
            background: lightsteelblue
        }

        .odd {
            background: silver
        }

        /* paging */

        table tfoot ol.paging {
            list-style: none;
        }

        table tfoot ol.paging li {
            float: left;
            margin-right: 8px;
        }

        table tfoot ol.paging li a {
            display: block;
            padding: 3px 7px;
            border: 1px solid #00B3DC;
            color: #2f313e;
            font-weight: bold;
        }

        table tfoot ol.paging li a:hover {
            background: #00B3DC;
            color: white;
            font-weight: bold;
        }

        .disable {
            padding: 3px 7px;
            border: 1px solid silver;
            color: silver;
        }

        .now {
            padding: 3px 7px;
            border: 1px solid #ff4aa5;
            background: #ff4aa5;
            color: white;
            font-weight: bold;
        }

    </style>
</head>
<body>
<div id="wrap">
    <header>
        <jsp:include page="/jsp/menu.jsp"/>
    </header>
    <div id="bbs">
        <table summary="게시판 목록">
            <caption>게시판 목록</caption>
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
                        <%--<%
                            //페이징을 위해 request에 page라는 이름으로 저장한 객체를 얻어낸다.
                            Object obj = request.getAttribute("page");
                            Paging pvo = null;
                            if (obj != null) {
                                pvo = (Paging) obj;
                                if (pvo.getStartPage() < pvo.getPagePerBlock()) {
                                    request.setAttribute("cPage", pvo.getNowPage());
                        %>--%>
                        <c:set var="page" value="${requestScope.page}"/>
                        <c:if test="${page.startPage < page.pagePerBlock}">
                        <li class="disable">&lt</li>
                        </c:if>
                        <%--<%
                        } else {
                        %>--%>
                        <c:if test="${page.startPage >= page.pagePerBlock}">
                            <li><a href="Controller?type=list&bname=bbs&cPage=${page.nowPage-page.pagePerBlock}">&lt;</a></li>
                        </c:if>
                        <c:forEach begin="${page.startPage}" end="${page.endPage}" varStatus="i">
                            <c:choose>
                                <c:when test="${i.index eq page.nowPage}">
                                    <li class="now">${i.index}</li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="Controller?type=list&bname=bbs&cPage=${i.index}">${i.index}</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <c:if test="${page.endPage < page.totalPage}">
                            <li><a href="Controller?type=list&bname=bbs&cPage=${page.nowPage+page.pagePerBlock}">&gt;</a></li>
                        </c:if>
                        <c:if test="${page.endPage >= page.totalPage}">
                            <li class="disable">&gt;</li>
                        </c:if>
<%--
                       <%
                            }

                            for (int i = pvo.getStartPage(); i <= pvo.getEndPage(); i++) {

                                //현재페이지 값과 i가 같으면 현재페이지를 의미하는 클래스를 적용하고
                                //그렇지 않으면 링크를 걸어준다.
                                if (pvo.getNowPage() == i) {
                        %>

                        <li class="now"><%=i %>
                        </li>
                        <% } else { %>
                        <li><a href="Controller?type=list&bname=bbs&cPage=<%=pvo.getNowPage()%>"><%=i %>
                        </a></li>
                        <%
                                }//if문의 끝
                            }//for의 끝

                            // 다음 블럭으로 이동하는 기능을 부여해야 할지? 하지 말아야 할지?를
                            // endPage가 totalPage보다 작을 경우에만 이동할 수 있도록 하자!
                            if (pvo.getEndPage() < pvo.getTotalPage()) {
                        %>&ndash;%&gt;
                        <li><a href="Controller?type=list&bname=bbs&cPage=<%=pvo.getNowPage()+pvo.getPagePerBlock()%>">&gt;</a>
                        </li>
                        <% } else { %>
                        <li class="disable">&gt;</li>
                        <%
                                }
                            }//if문의 끝&ndash;%&gt;--%>
                    </ol>
                </td>
                <td>
                    <input type="button" value="글쓰기"
                           onclick="javascript:location.href='Controller?type=write&bname=bbs'"/>
                </td>
            </tr>
            </tfoot>
            <tbody>
            <c:forEach var="ar" items="${ar}" varStatus="i">
                <tr>
                    <td>${page.totalRecord -((page.nowPage-1)*page.numPerPage+i.index) }</td>
                    <%-- 총 게시물 - (현재페이지 - 1) X (페이지당 표시할 게시물 + 인덱스 값)
                    총게시물의 수 그리고 페이지가 1일때 0을 뺴야하니까 -1 현제페이지에 -1 을 한 값에 * 페이지의 게시물수 10을 곱한다
                    그러면 현제 페이지 전꺼 까지의 게시글 수가 사라지고 거기다 각 번호를 호출하기 위해서는 인덱스 값을 더해줘야 한다.
                    그러면 총 게시물 수에서 현재 게시글의 번호값이 나온다. 맨앞에 첫 번째 게시글이 총 게시글의 수 이고 그 다음것이
                    총 게시글에서 1을 뺀 것 그러기에 현제 게시글 앞에 있는 게시글의 수를 빼주면 되는데 이는 내 게시글의 인덱스 값을
                    빼주면 해결이 된다. 그러면 현제 게시글의 번호가 나오게 된다. 만약 n페이지라면 그전페이지까지를 뺴주고(내 페이지 -1
                    * 1페이지 당 게시글 수) 총 페이지에서 이 그 값을 빼주고 거기에 index값을 빼주면 내 번호가 나오게 된다.
                    --%>
                    <td style="text-align: left">
                        <a href="Controller?type=view&bname=${param.bname}&b_idx=${ar.b_idx}&cPage=${page.nowPage}">
                                ${ar.subject}
                            <c:if test="${fn:length(ar.c_list) > 0}">
                                (${fn:length(ar.c_list)})
                            </c:if>
                        </a>
                    </td>
                    <td>${ar.writer}</td>
                    <td>${ar.write_date}</td>
                    <td>${ar.hit}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty ar}">
                <tr>
                    <td colspan="5">
                        등록된 데이터가 없습니다.
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
<%--        <%
                Object obj2 = request.getAttribute("ar");
                if (obj2 != null) {
                    BbsVO[] ar = (BbsVO[]) obj2;
                    for (BbsVO vo : ar) {
            %>
            <tr>
                <td><%=vo.getB_idx() %>
                </td>
                <td style="text-align: left">
                    <a href="Controller?type=view&bname=${param.bname}&b_idx=<%=vo.getB_idx()%>&cPage=<%=pvo.getNowPage()%>">
                        <%=vo.getSubject() %>
                        <%
                        if(vo.getC_list().size() > 0){
                        %>
                        (<%=vo.getC_list().size()%>)
                        <%
                            };
                        %>
                    </a></td>
                <td><%=vo.getWriter() %>
                </td>
                <td><%=vo.getWrite_date() %>
                </td>
                <td><%=vo.getHit() %>
                </td>
            </tr>
            <%
                }//for의 끝
            } else {
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
</div>--%>
</body>
</html>