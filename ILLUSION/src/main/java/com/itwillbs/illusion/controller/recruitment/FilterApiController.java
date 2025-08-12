package com.itwillbs.illusion.controller.recruitment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.illusion.service.CommonCodeService;
import com.itwillbs.illusion.vo.CommonCodeVO;

import java.util.List;

@RestController // 이 클래스는 데이터를 반환하는 API 컨트롤러임을 선언
@RequestMapping("/api/codes")
public class FilterApiController {

	@Autowired
    CommonCodeService Service;

    @GetMapping("/{groupId}")
    public List<CommonCodeVO> getCodesByGroup(
            @RequestParam("groupId") String groupId) {
        
        List<CommonCodeVO> codeList = Service.getCodesByGroupId(groupId);
        
        return codeList;
    }
}    