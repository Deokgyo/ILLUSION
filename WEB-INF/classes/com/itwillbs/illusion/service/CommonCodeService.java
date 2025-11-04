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
    
    public Map<String, List<CommonCodeVO>> getFilterOptionsForRecruit() {
        
        Map<String, List<CommonCodeVO>> filterOptions = new HashMap<>();
       
        String[] groupIds = {"LOCATION", "OCCUPATION", "EXPERIENCE", "SALARY", "DEGREE",};
        
        // 배열을 반복하면서, 각 그룹 ID에 해당하는 대분류 코드 목록을 조회하여 Map에 담습니다.
        for (String groupId : groupIds) {
            List<CommonCodeVO> codeList = this.getCodesByParentCode(groupId, null);
            filterOptions.put(groupId, codeList);
        }
        
        return filterOptions;
    }
    
//    public List<CommonCodeVO> searchLocationsByName(String keyword) {
//        return Mapper.findLocationsByName(keyword);
//    }
    
    public List<CommonCodeVO> selectAllCommonList(List<String> codeGroups) {
    	return mapper.selectAllCommonList(codeGroups);
    }
    
}    
