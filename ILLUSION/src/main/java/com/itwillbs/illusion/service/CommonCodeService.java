package com.itwillbs.illusion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.CommonCodeMapper;
import com.itwillbs.illusion.vo.CommonCodeVO;

import java.util.List;

@Service
public class CommonCodeService {

	@Autowired
    private CommonCodeMapper Mapper;

    public List<CommonCodeVO> getSubRegionsByParentCode(String parentCode) {
        return Mapper.findSubCodesByParentCode(parentCode);
    }
    
//    public List<CommonCodeVO> searchLocationsByName(String keyword) {
//        return Mapper.findLocationsByName(keyword);
//    }
}    
