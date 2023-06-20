<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--글 한 개 조회하는 페이지--%>
<html>
<%@ include file="header2.jsp"%>
<style>
    #view {
        float: right;
    }
    div.boardOne {
        margin: auto;
        text-align: center;
        width: 600px;
    }
    div.inside {
        text-align: justify;
    }
    div#bookmark {
        display: inline-block;
        float: right;
    }
    div#boardBtn {
        float: left;
    }
    #btnDel, #btnUp {
        visibility: hidden;
    }
    #create, #cancel {
        display: none;
    }
</style>
<script>
    window.onload=function matchMember () {
        const btn1 = document.getElementById('btnDel');
        const btn2 = document.getElementById('btnUp');
        const btnCancel = document.getElementById('cancel');
        const btnBookmark = document.getElementById('create');
        if(${board.memberId} == ${memberId}) {
            btn1.style.visibility = 'visible';
            btn2.style.visibility = 'visible';
        }

        fetch("/bookmark/check", {
            method: "POST",
            headers: {
                "Content-Type" : "application/json",
            },
            body: JSON.stringify({
                postId: ${postId},
                memberId: ${memberId}
            }),
        }).then((response) => response.json())
            .then((data) => {
                console.log(data);
                if(data) {
                    btnCancel.style.display = "inline-block";
                    btnBookmark.style.display = "none";
                }
                else {
                    btnBookmark.style.display = "inline-block";
                    btnCancel.style.display = "none";
                }

            });
    }

    function deleteById() {
        fetch("/board/${memberId}/delete/${postId}", {
            method: "DELETE"
        }).then((response) => response.json())
        location.href="/board/${memberId}";
    }
    function createBookmark() {
        const btnCancel = document.getElementById('cancel');
        const btnBookmark = document.getElementById('create');
        btnCancel.style.display = "inline-block";
        btnBookmark.style.display = "none";
        fetch("/bookmark/create", {
            method: "POST",
            headers: {
                "Content-Type" : "application/json",
            },
            body: JSON.stringify({
                postId: ${postId},
                memberId: ${memberId}
            }),
        }).then((response) => console.log(response));

    }
    function cancelBookmark() {
        const btnCancel = document.getElementById('cancel');
        const btnBookmark = document.getElementById('create');
        btnBookmark.style.display = "inline-block";
        btnCancel.style.display = "none";
        fetch("/bookmark/delete", {
            method: "DELETE",
            headers: {
                "Content-Type" : "application/json",
            },
            body: JSON.stringify({
                postId: ${postId},
                memberId: ${memberId}
            }),
        }).then((response) => console.log(response));

    }
</script>

<body>
    <div class="boardOne">
        <div class="inside">
            <h3>${board.category} ${board.title}</h3>
            ${board.writer}
            <fmt:parseDate value="${board.lastModifiedDate}" pattern="yyyy-MM-dd'T'HH:mm" var="createdTime" type="both" />
            <fmt:formatDate value="${ createdTime }" pattern="yyyy-MM-dd HH:mm" var="time" />
            ${time}
            <span id="view">${board.countView}</span>
        </div>
        <hr>
        <div class="inside">
            ${board.content}
        </div>
        <div class="boardBtn">
            <div class="inside" id="boardBtn">
                <button type="button" onclick="location.href='/board/${memberId}'">목록</button>
                <button type="button" id="btnUp" onclick="location.href='/board/${memberId}/update/${postId}'">수정</button>
                <button type="button" id="btnDel" onclick="deleteById()">삭제</button>
            </div>
            <div id="bookmark">
                <button class="bookmarkBtn" id="create" type="button" onclick="createBookmark()">북마크</button>
                <button class="bookmarkBtn" id="cancel" type="button" onclick="cancelBookmark()">북마크 취소</button>
            </div>
        </div>
    </div>

</body>
</html>
