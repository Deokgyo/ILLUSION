kakao.maps.load(function() {
    

    var mapContainer = document.getElementById('map');
    if (!mapContainer) return; // 지도를 표시할 div가 없으면 종료

    var mapOption = { 
        center: new kakao.maps.LatLng(35.158417, 129.062022),
        level: 3
    };
    var map = new kakao.maps.Map(mapContainer, mapOption);
    
	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new kakao.maps.MapTypeControl();
	
	// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT); 
	
	// -------------------------------------------------------

    const address = $("#map").data("address");
    const name = $("#map").data("name");

    if (address) {
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
                    content: `<div style="width:150px;text-align:center;padding:10px 0;">${name}</div>`
                });
                infowindow.open(map, marker);

            } else {
                console.error("주소 검색 실패:", status);
                alert("회사 주소가 일치하지 않습니다.");
            }
        });
    }
});