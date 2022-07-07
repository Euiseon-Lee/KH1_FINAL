<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-fluid">
    <div class="row mt-4">
        <div class="col-4">
            <c:choose>
                <c:when test="${empty gpsAddressList}">
                    <div class="row mt-4">
                        <h2 class="fw-bold">먼저 내 동네를</h2>
                    </div>
                    <div class="row">
                        <h2 class="fw-bold">설정해주세요</h2>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row mt-4">
                        <h2 class="fw-bold">먼저 변경할 주소를</h2>
                    </div>
                    <div class="row">
                        <h2 class="fw-bold">선택해주세요</h2>
                    </div>
                </c:otherwise>
            </c:choose>
            <div class="row mt-2">
                <h6 class="text-muted">내 동네는 최대 2개까지 설정할 수 있습니다</h6>
            </div>
            <div class="row mt-1">
                <h6 class="text-info info">* PC 환경에선 현재 위치 불러오기가 정확하지 않을 수 있습니다</h6>
            </div>
            <c:choose>
                <c:when test="${empty gpsAddressList}">
                    <div class="row mt-4 pr-4">
                        <button type="button" class="btn btn-outline-primary rounded-pill address-save1" disabled><i class="fa-solid fa-plus"></i> 이 주소로 저장하기</button>
                        <button type="button" class="btn btn-outline-primary rounded-pill d-none address-put1" disabled><i class="fa-solid fa-plus"></i> 이 주소로 저장하기</button>
                        <button type="button" class="btn btn-primary rounded-pill text-truncate d-none address-change1"></button>
                    </div>
                    <div class="row mt-2 pr-4">
                        <button type="button" class="btn btn-outline-primary rounded-pill d-none address-save2" disabled><i class="fa-solid fa-plus"></i> 이 주소로 저장하기</button>
                        <button type="button" class="btn btn-outline-primary rounded-pill d-none address-put2" disabled><i class="fa-solid fa-plus"></i> 이 주소로 저장하기</button>
                        <button type="button" class="btn btn-primary rounded-pill text-truncate d-none address-change2"></button>
                        <button type="button" class="btn btn-outline-primary rounded-pill d-none address-create2"><i class="fa-solid fa-plus"></i> 주소2 추가하기</button>
                    </div>
                </c:when>
                <c:when test="${fn:length(gpsAddressList) == 1}">
                    <div class="row mt-4 pr-4">
                        <button type="button" class="btn btn-outline-primary rounded-pill d-none address-put1" disabled><i class="fa-solid fa-plus"></i> 이 주소로 저장하기</button>
                        <button type="button" class="btn btn-primary rounded-pill text-truncate address-change1"></button>
                    </div>
                    <div class="row mt-2 pr-4">
                        <button type="button" class="btn btn-outline-primary rounded-pill d-none address-save2" disabled><i class="fa-solid fa-plus"></i> 이 주소로 저장하기</button>
                        <button type="button" class="btn btn-outline-primary rounded-pill d-none address-put2" disabled><i class="fa-solid fa-plus"></i> 이 주소로 저장하기</button>
                        <button type="button" class="btn btn-primary rounded-pill text-truncate d-none address-change2"></button>
                        <button type="button" class="btn btn-outline-primary rounded-pill address-create2"><i class="fa-solid fa-plus"></i> 주소2 추가하기</button>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row mt-4 pr-4">
                        <button type="button" class="btn btn-outline-primary rounded-pill d-none address-put1" disabled><i class="fa-solid fa-plus"></i> 이 주소로 저장하기</button>
                        <button type="button" class="btn btn-primary rounded-pill text-truncate address-change1"></button>
                    </div>
                    <div class="row mt-2 pr-4">
                        <button type="button" class="btn btn-outline-primary rounded-pill d-none address-put2" disabled><i class="fa-solid fa-plus"></i> 이 주소로 저장하기</button>
                        <button type="button" class="btn btn-primary rounded-pill text-truncate address-change2"></button>
                    </div>
                </c:otherwise>
            </c:choose>
            <div class="row mt-4" id="finish">
                <a href="${root}/" class="text-secondary">주소 설정 종료하기 <i class="fa-solid fa-arrow-right-long pl-2"></i></a>
            </div>
        </div>
        <div class="col bg-light d-none" id="findAddress">
            <form>
                <div class="row p-3">
                    <input class="form-control-plaintext form-control-lg border-bottom" id="address" readonly>
                </div>
                <div class="row pb-3">
                    <div class="col-2">
                        <button type="button" class="btn btn-info" id="search">주소 검색</button>
                    </div>
                    <div class="col-4 p-0">
                        <button type="button" class="btn btn-primary" id="gps">현재 주소 불러오기</button>
                    </div>
                    <div class="col p-0 pt-2">
                        <input type="range" class="form-control-range custom-range circle" id="circle" min="1" max="6" value="6">
                    </div>
                    <div class="col pt-2">
                        <h6 id="km">반경 6km</h6>
                    </div>
                </div>
                <div class="row">
                    <div id="postcode" class="d-none">
                        <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="closePostcode">
                    </div>
                </div>
                <div class="row">
                    <div id="map" class="d-none"></div>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=714d787408b068ef9f0ff6126a1c0b99&libraries=services"></script>
<script type="text/javascript">

    let lat; // 위도(x축) 변수 선언
    let lon; // 경도(y축) 변수 선언	
   
    const postcode = document.getElementById("postcode"); // 우편번호 검색을 표시할 div
    const mapContainer = document.getElementById("map"); // 지도를 표시할 div
    const mapOption = {
        center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심 좌표
        level: 8 // 지도의 확대 레벨
    };
    const map = new kakao.maps.Map(mapContainer, mapOption); // 지도 미리 생성
    const marker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(37.537187, 127.005476),
        map: map
    }); // 마커 미리 생성

    // 반경 원 객체 생성
    const circle = new kakao.maps.Circle({
        strokeWeight: 2, // 테두리 굵기
        strokeColor: "#F5303E", // 테두리 색상
        strokeOpacity: 0.7, // 테두리 불투명도
        strokeStyle: "solid", // 테두리 스타일
        fillColor: "#F5303E", // 원 색상
        fillOpacity: 0.2 // 원 불투명도
    });

    // 주소-좌표 변환 객체 생성
    const geocoder = new kakao.maps.services.Geocoder();

    // 좌표 -> 주소 변환 함수 (return을 받기 위해 Promise로 wrapping)
    const toAddress = (lon, lat) => {
    	return new Promise((resolve, reject) => {
    		geocoder.coord2Address(lon, lat, function(result, status) {
    			if (status === kakao.maps.services.Status.OK) {
                    if (!result[0].road_address) { // 도로명 주소가 없으면
                    	resolve(result[0].address.address_name);
                    } else {
                    	resolve(result[0].road_address.address_name);
                    }
    			}
    		});
    	});
    };   
    
    // 주소 -> 좌표 변환 함수 (Promise로 wrapping)
/*     function toLatLng(address) {
    	console.log(address);
        const callback = function(results, status) {
            if (status === kakao.maps.services.Status.OK) {
                const result = results[0]; // 첫번째 결과값을 활용
                lat = result.x;
                lon = result.y;
            }
        };
        geocoder.addressSearch(address, callback);
    }; */

    const toLatLng = address => {
    	return new Promise((resolve, reject) => {
    		geocoder.addressSearch(address, function(results, status) {
    			if (status === kakao.maps.services.Status.OK) {
    				resolve(results[0]); // 첫번째 결과값을 활용
    			}
    		});
    	});
    }; 
    
    // 반경과 좌표 정보를 DB에 저장하는 함수
    function postAddress() {
        $.ajax({
            url: "http://localhost:8080/auctionara/address",
            type: "post",
            data: JSON.stringify({
                memberNo: 13, // 임시
                gpsLatitude: lat,
                gpsLongitude: lon,
                gpsCircle: $("#circle").val(),
            }),
            contentType: 'application/json',
            success: function(resp) {}
        });
    };

    // 마커와 원을 넣은 지도를 표시하는 함수
    function showMap() {
        const coords = new kakao.maps.LatLng(lat, lon); // 좌표 객체 생성
        
        // 맵 표시
        mapContainer.classList.remove("d-none");
        map.relayout();
        
        map.setCenter(coords); // 맵의 중심을 좌표로 변경
        marker.setPosition(coords); // 마커의 위치를 좌표로 변경

        // 원 중심과 반경을 변경
        circle.setOptions({
            center: coords,
            radius: $("#circle").val() * 1000,
        });
        circle.setMap(map);
    };


    // [주소 검색]을 통해 좌표와 주소를 얻는 함수
    function daumPostcode() {
        $("#address").val(""); // <input> 지우기
        mapContainer.className += " d-none"; // 맵 숨기기
        $("#postcode").removeClass("d-none"); // 우편 번호 검색창 열기
        
        new daum.Postcode({
            oncomplete: function(data) {
            	$("#postcode").addClass("d-none"); // 우편 번호 검색창 닫기
                const addr = data.address; // 선택한 주소값
                $("#address").val(addr); // <input>에 주소 넣기
                
                // 반경 범위 변경
                if($("#address").val().substring(0,5) == "서울특별시" || $("#address").val().substring(0,2) == "서울") {
                	$("#circle").val("6").trigger("change"); 
                	$("#circle").attr("max", 6);
                } else {
                	$("#circle").val("12").trigger("change");
                	$("#circle").attr("max", 12);
                };

                (async () => { 
                	try {
                        const result = await toLatLng(addr); // 주소 -> 좌표 변환
                        lat = result.y;
                        lon = result.x;
                        showMap(); // 지도 & 원 표시
                        
                        if (!$(".address-save1").hasClass("d-none")) {
                        	$(".address-save1").attr("disabled", false); // 주소1 저장 버튼 클릭 가능하게 전환 
                        };
                        if (!$(".address-save2").hasClass("d-none")) {
                        	$(".address-save2").attr("disabled", false); // 주소2 저장 버튼 클릭 가능하게 전환 
                        };
                        if (!$(".address-put1").hasClass("d-none")) {
                        	$(".address-put1").attr("disabled", false); // 주소1 수정 버튼 클릭 가능하게 전환 
                        };                        
                        if (!$(".address-put2").hasClass("d-none")) {
                        	$(".address-put2").attr("disabled", false); // 주소2 수정 버튼 클릭 가능하게 전환 
                        };
                	} catch (e) {
                		console.log(e);
                	}
                })();
            },
        	onresize : function(size) {
        		postcode.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(postcode);        
	};

    function gps() {
        $("#address").val(""); // <input> 지우기
        $("#postcode").addClass("d-none"); // 우편 번호 검색창 닫기

        // geolocation 사용 가능 여부 확인
        if (navigator.geolocation) {
            // GeoLocation으로 접속 위치 받아오기
            navigator.geolocation.getCurrentPosition(function(position) {
                lat = position.coords.latitude;
                lon = position.coords.longitude;

                showMap(); // 지도 & 원 표시
                
                (async () => { 
                	try {
                		// 좌표로 주소를 구해 <input>에 넣기
                		const result = await toAddress(lon, lat);
                		$("#address").val(result);
                		
                        if (!$(".address-save1").hasClass("d-none")) {
                        	$(".address-save1").attr("disabled", false); // 주소1 저장 버튼 클릭 가능하게 전환 
                        };
                        if (!$(".address-save2").hasClass("d-none")) {
                        	$(".address-save2").attr("disabled", false); // 주소2 저장 버튼 클릭 가능하게 전환 
                        };
                        if (!$(".address-put1").hasClass("d-none")) {
                        	$(".address-put1").attr("disabled", false); // 주소1 수정 버튼 클릭 가능하게 전환 
                        };                        
                        if (!$(".address-put2").hasClass("d-none")) {
                        	$(".address-put2").attr("disabled", false); // 주소2 수정 버튼 클릭 가능하게 전환 
                        };
                        
                        // 반경 범위 변경
                        if($("#address").val().substring(0,5) == "서울특별시" || $("#address").val().substring(0,2) == "서울") {
                        	$("#circle").val("6").trigger("change"); 
                        	$("#circle").attr("max", 6);
                        } else {
                        	$("#circle").val("12").trigger("change");
                        	$("#circle").attr("max", 12);
                        };                   
                	} catch (e) {
                		console.log(e);
                	}
                })();
            });
        } else { // GeoLocation을 사용할 수 없을 때 처리
        }
    };
	
    // 원 반경 변경 함수
    function circleChange() {
        if ($("#address").val() != "") {
            showMap();
        }
    };

    // 주소1 수정 함수
    function postAddress1() {
        $.ajax({
            url: "http://localhost:8080/auctionara/address/change1",
            type: "put",
            data: JSON.stringify({
                memberNo: 13, // 임시
                gpsLatitude: lat,
                gpsLongitude: lon,
                gpsCircle: $("#circle").val(),
            }),
            contentType: 'application/json',
            success: function(resp) {}
        });
    };

    // 주소2 수정 함수
    function postAddress2() {
        $.ajax({
            url: "http://localhost:8080/auctionara/address/change2",
            type: "put",
            data: JSON.stringify({
                memberNo: 13, // 임시
                gpsLatitude: lat,
                gpsLongitude: lon,
                gpsCircle: $("#circle").val(),
            }),
            contentType: 'application/json',
            success: function(resp) {}
        });
    };

    // DB에 저장된 반경과 주소 표시
	<c:if test="${fn:length(gpsAddressList) == 1}">
	    (async () => {
	    	const address1 = await toAddress(${gpsAddressList[0].gpsLongitude}, ${gpsAddressList[0].gpsLatitude});
	    	$(".address-change1").text("주소1 : [반경 " + ${gpsAddressList[0].gpsCircle} + "km] " + address1); 
	    })();
	</c:if>
	<c:if test="${fn:length(gpsAddressList) == 2}">
	    (async () => {
	    	const address1 = await toAddress(${gpsAddressList[0].gpsLongitude}, ${gpsAddressList[0].gpsLatitude});
	    	const address2 = await toAddress(${gpsAddressList[1].gpsLongitude}, ${gpsAddressList[1].gpsLatitude});
	    	$(".address-change1").text("주소1 : [반경 " + ${gpsAddressList[0].gpsCircle} + "km] " + address1); 
	    	$(".address-change2").text("주소2 : [반경 " + ${gpsAddressList[1].gpsCircle} + "km] " + address2); 
	    })();
	</c:if>
	
	// 주소가 없을 시 바로 주소 선택 화면 출력
	<c:if test="${empty gpsAddressList}">
		$("#findAddress").removeClass("d-none");
	</c:if>
	
	// DB에 주소 정보가 없을 시 주소 설정 종료 버튼 숨기기
	if($(".address-save1").length > 0) {
		$("#finish").addClass("d-none");
	}
	
    // <input> 클릭 시
    $("#address").click(function() {
    	daumPostcode();
    });
    
    // [주소 검색] 클릭 시
    $("#search").click(function() {
    	daumPostcode();
    });
    
    // [현재 주소 불러오기] 클릭 시
    $("#gps").click(function() {
    	gps();
    });
    
    // 우편번호 검색 닫기 버튼 클릭 시
    $("#closePostcode").click(function() {
        $("#postcode").addClass("d-none");
    });

    // 주소1 버튼 클릭 시
    $(".address-change1").click(function() {
    	$("#address").val(""); // <input> 지우기
    	mapContainer.className += " d-none"; // 맵 숨기기
        $(".address-change1").addClass("d-none");
        $(".address-put1").removeClass("d-none");        
        $(".address-put2").addClass("d-none");
        $(".address-save2").addClass("d-none");         
        $(".address-put1").attr("disabled", true);
        $("#findAddress").removeClass("d-none");
        
        if($(".address-change2").text() == "") {
        	$(".address-create2").removeClass("d-none");
        } else {
        	$(".address-change2").removeClass("d-none");
        }
    });

    // 주소2 버튼 클릭 시
    $(".address-change2").click(function() {
    	$("#address").val(""); // <input> 지우기
    	mapContainer.className += " d-none"; // 맵 숨기기
        $(".address-change2").addClass("d-none");
        $(".address-put2").removeClass("d-none");
        $(".address-change1").removeClass("d-none");
        $(".address-put1").addClass("d-none");       	 
        $(".address-put2").attr("disabled", true);
        $("#findAddress").removeClass("d-none");
    });

    // 주소2 생성 버튼 클릭 시
    $(".address-create2").click(function() {
    	$("#address").val(""); // <input> 지우기
    	mapContainer.className += " d-none"; // 맵 숨기기    	
        $(".address-create2").addClass("d-none");
        $(".address-save2").removeClass("d-none");
        $(".address-save2").attr("disabled", true);
        $(".address-change1").removeClass("d-none");
        $(".address-put1").addClass("d-none"); 
        $("#findAddress").removeClass("d-none");
    });
    
    // 주소1 저장 버튼 클릭 시
    $(".address-save1").click(function() {
    	$(".address-change1").text("주소1 : [반경 " + $("#circle").val() + "km] " + $("#address").val());
    	$("#address").val(""); // <input> 지우기
        $(".address-save1").addClass("d-none");
        $(".address-change1").removeClass("d-none");
        $(".address-create2").removeClass("d-none");
        $("#finish").removeClass("d-none");
        $("#findAddress").addClass("d-none");
        postAddress();
    });

    // 주소2 저장 버튼 클릭 시
    $(".address-save2").click(function() {
    	$(".address-change2").text("주소2 : [반경 " + $("#circle").val() + "km] " + $("#address").val());
    	$("#address").val(""); // <input> 지우기
        $(".address-save2").addClass("d-none");
        $(".address-change2").removeClass("d-none");
        $("#findAddress").addClass("d-none");
        postAddress();
    });

    // 주소1 수정 버튼 클릭 시
    $(".address-put1").click(function() {
    	$(".address-change1").text("주소1 : [반경 " + $("#circle").val() + "km] " + $("#address").val());
    	$("#address").val(""); // <input> 지우기
    	mapContainer.className += " d-none"; // 맵 숨기기
        $(".address-put1").addClass("d-none");
        $(".address-change1").removeClass("d-none");
        $("#findAddress").addClass("d-none");
        postAddress1();
    });

    // 주소2 수정 버튼 클릭 시
    $(".address-put2").click(function() {
    	$(".address-change2").text("주소2 : [반경 " + $("#circle").val() + "km] " + $("#address").val());
    	$("#address").val(""); // <input> 지우기
    	mapContainer.className += " d-none"; // 맵 숨기기
        $(".address-put2").addClass("d-none");
        $(".address-change2").removeClass("d-none");
        $("#findAddress").addClass("d-none");
        postAddress2();
    });
    
    // 반경 변경 시
    $("#circle").change(function() {
    	 $("#km").text("반경 " + $("#circle").val() + "km");
    	 circleChange();
    });

</script>
<style scoped>
    #map {
        width: 100%;
        height: 500px;
        margin-top: 10px;
    }

    #postcode {
        width: 100%;
        height: 300px;
        margin: 5px 0;
        position: relative;
    }

    #closePostcode {
        cursor: pointer;
        position: absolute;
        right: 0px;
        top: -1px;
        z-index: 1;
    }

    .info {
        font-size: 0.75em;
    }

</style>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
