// ✨ $(function() { ... }); 구문을 kakao.maps.load()로 감싸줍니다.

// 1. 카카오맵 API 로딩이 완료되면, 이 안의 함수를 실행시켜 줍니다.
kakao.maps.load(function() {
    
    // 2. 이제 이 안에서는 'kakao' 객체가 100% 준비된 상태임이 보장됩니다.
    
    // --- 지도 생성 및 주소 변환 로직 (기존 코드) ---
    var mapContainer = document.getElementById('map');
    if (!mapContainer) return; // 지도를 표시할 div가 없으면 종료

    var mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 3
    };
    var map = new kakao.maps.Map(mapContainer, mapOption); 

    const address = $("#map").data("address");

    if (address) {
        // 주소-좌표 변환 객체를 생성합니다.
        var geocoder = new kakao.maps.services.Geocoder();

        // 주소로 좌표를 검색합니다.
        geocoder.addressSearch(address, function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                map.setCenter(coords);

                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                var infowindow = new kakao.maps.InfoWindow({
                    content: `<div style="width:150px;text-align:center;padding:6px 0;">${address}</div>`
                });
                infowindow.open(map, marker);

            } else {
                console.error("주소 검색 실패:", status);
            }
        });
    }
});