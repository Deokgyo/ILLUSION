package com.itwillbs.illusion.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.illusion.vo.CommonCodeVO;

@Mapper
public interface CommonCodeMapper {

	List<CommonCodeVO> findCodesByGroupId(String groupId);
	
//	List<CommonCodeVO> findLocationsByName(String keyword);

}
