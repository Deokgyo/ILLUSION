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

@RestController
@RequestMapping("/api/codes")
public class FilterApiController {

	@Autowired
    CommonCodeService Service;

    @GetMapping
    public List<CommonCodeVO> getCodesByGroup(
            @RequestParam("groupId") String groupId,
            @RequestParam(value = "parentCode", required = false) String parentCode) {
        
        return Service.getCodesByParentCode(groupId, parentCode);
    }
}    