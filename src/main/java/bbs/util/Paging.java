package bbs.util;

public class Paging {
    int nowPage = 1; //현재 페이지 값
    int numPerPage = 10; // 한페이지 당 표현할 게시물 수
    int totalRecord; // 총 게시물 수
    int pagePerBlock = 5; //페이지 묶음 보여질 페이지
    int totalPage; // 총 페이지 수

    int begin; //현재 페이지 값에 따라 bbs_t테이블에서 가져올
                // 게시물의 시작 행 번호
    int end; //현재 페이지 값에 따라 bbs_t테이블에서 가져올 게시물의 마지막 행번호

    int startPage; // 한 블럭의 시작 페이지 값
    int endPage; // 한 블럭의 마지막 페이지 값

    public Paging(int numPerPage, int pagePerBlock) {
        //인자인 지역변수를 맴버변수에 저장한다.
        this.numPerPage = numPerPage;
        this.pagePerBlock = pagePerBlock;
    }

    public Paging() {
    } //기본 생성자

    public int getNowPage() {
        return nowPage;
    }

    public void setNowPage(int nowPage) {
        //현재 페이지 값이 변경되고 있으니 begin과 end 그리고
        //start페이지와 endpage값을 구한다.
        //무슨 페이지든 간에 총 페이지를 넘어가면 안된다.
        if (nowPage > totalPage)
            nowPage = totalPage;

        this.nowPage = nowPage;

        //각 페이지의 시작 레코드의 행번호와 마지막 레코드의 행번호 지정!
        //현 페이지 값 1 : begin, end: 10
        //현재페이지 값 2: begin : 11, end : 20

        begin = (nowPage - 1) * numPerPage + 1;
        end = nowPage * numPerPage;

        //현재 페이지값에 의해 블럭의 시작페이지 값 구하기
        startPage = ((nowPage - 1) / pagePerBlock) * pagePerBlock + 1;
        endPage = startPage + pagePerBlock - 1;

        if (endPage > totalPage)
            endPage = totalPage;
    }

    public int getNumPerPage() {
        return numPerPage;
    }

    public void setNumPerPage(int numPerPage) {
        this.numPerPage = numPerPage;
    }

    public int getTotalRecord() {
        return totalRecord;
    }

    public void setTotalRecord(int totalRecord) {
        this.totalRecord = totalRecord;

        /*this.totalPage = totalRecord/numPerPage;
        if(totalRecord%numPerPage != 0){
            this.totalPage++;
        }*/
        this.totalPage = (int) Math.ceil((double) totalRecord / numPerPage);
    }

    public int getPagePerBlock() {
        return pagePerBlock;
    }

    public void setPagePerBlock(int pagePerBlock) {
        this.pagePerBlock = pagePerBlock;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getBegin() {
        return begin;
    }

    public void setBegin(int begin) {
        this.begin = begin;
    }

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }
}
