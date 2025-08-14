package com.itwillbs.illusion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.CommonCodeMapper;
import com.itwillbs.illusion.vo.CommonCodeVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CommonCodeService {

	@Autowired
    private CommonCodeMapper mapper;
	
    public List<CommonCodeVO> getCodesByParentCode(String groupId,String parentCode) {
    	
    	Map<String, Object> params = new HashMap<>();
    	
        params.put("groupId", groupId);
        params.put("parentCode", parentCode);
        
        
        return mapper.findCodesByParentCode(params);
        
        
    }
    
//    public List<CommonCodeVO> searchLocationsByName(String keyword) {
//        return Mapper.findLocationsByName(keyword);
//    }
    
}    
