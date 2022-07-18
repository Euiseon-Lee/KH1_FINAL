<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
</div>
</div>
<div class="container-fluid bg-light mt-5">
    <div class="container pl-5">
        <footer>
            <div class="row py-5">
                <div class="col-6">
                    <a class="navbar-brand mb-3" href="${root}/">
                        <img src="${root}/image/logo.png" alt="logo">
                    </a>
                    <ul class="nav flex-column">
                        <li class="nav-item text-muted">경매나라는 이웃 간의</li>
                        <li class="nav-item text-muted">합리적인 중고거래를 지원합니다.</li>
                    </ul>
                </div>
                <div class="col-2">
                    <h6 class="mb-3">경매나라</h6>
                    <ul class="nav flex-column">
                        <li class="nav-item mb-2"><a href="${root}/" class="nav-link p-0 text-muted">홈</a></li>
                        <li class="nav-item mb-2"><a href="${root}/auction/write" class="nav-link p-0 text-muted">경매 등록</a></li>
                        <li class="nav-item mb-2"><a href="${root}/mypage/index" class="nav-link p-0 text-muted">마이 페이지</a></li>
                    </ul>
                </div>
                <div class="col-2">
                    <h6 class="mb-3">KH 파이널 1조</h6>
                    <ul class="nav flex-column">
                        <li class="nav-item mb-2 text-muted">이의선</li>
                        <li class="nav-item mb-2 text-muted">설강은</li>
                        <li class="nav-item mb-2 text-muted">천지연</li>
                        <li class="nav-item mb-2 text-muted">한상혁</li>
                    </ul>
                </div>
                <div class="col-2">
                    <h6 class="mb-3">About more</h6>
                    <ul class="nav flex-column">
                        <li class="nav-item mb-2"><a href="https://github.com/Euiseon-Lee/KH1_FINAL" target="_blank" class="nav-link p-0 text-muted"><i class="fa-brands fa-github fa-2x"></i></a></li>
                    </ul>
                </div>
            </div>
            <div class="row border-top pt-3 pb-5 w-100 pr-0">
                <p class="text-muted text-center w-100">Copyright © by KH 파이널 1조 All right Reserved</p>
            </div>
        </footer>
    </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
