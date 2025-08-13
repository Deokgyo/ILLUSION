package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.illusion.vo.CommonCodeVO;

@Mapper
public interface CommonCodeMapper {

	List<CommonCodeVO> findCodesByParentCode(Map<String, Object> params);
	
//	List<CommonCodeVO> findLocationsByName(String keyword);

}
