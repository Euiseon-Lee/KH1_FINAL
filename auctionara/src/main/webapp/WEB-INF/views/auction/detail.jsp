<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-fluid" id="app">
        <div class="row pt-5 pb-3 border-bottom">
            <div class="col-sm">
                <h2 class="fw-bold">경매 등록</h2>
            </div>
        </div>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
    const app = Vue.createApp({
        data() {
            return {
            };
        },
        computed: {
        },
        methods: {
        },
    });
    app.mount("#app");

</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>