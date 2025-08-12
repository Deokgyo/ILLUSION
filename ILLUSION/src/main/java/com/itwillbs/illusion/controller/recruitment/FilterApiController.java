package com.itwillbs.illusion.controller.recruitment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.illusion.service.CommonCodeService;
import com.itwillbs.illusion.vo.CommonCodeVO;

import java.util.List;

@RestController // 이 클래스는 데이터를 반환하는 API 컨트롤러임을 선언
public class FilterApiController {

	@Autowired
    private CommonCodeService Service;

    @GetMapping("/api/locations/sub-regions")
    public List<CommonCodeVO> getSubRegions(
            @RequestParam("location") String location) {
        
        List<CommonCodeVO> subRegionList = Service.getSubRegionsByParentCode(location);
        return subRegionList; // 조회된 List를 JSON으로 변환하여 응답
    }
    
//    @GetMapping("/api/locations/search")
//    public List<CommonCodeVO> searchLocations(
//            @RequestParam("keyword") String keyword) {
//        
//        List<CommonCodeVO> searchResultList = Service.searchLocationsByName(keyword);
//        return searchResultList;
//    }

}    