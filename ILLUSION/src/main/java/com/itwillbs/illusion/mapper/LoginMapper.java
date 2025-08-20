package com.itwillbs.illusion.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginMapper {
	
	public Map<String, Object> selectMemberById(String member_id);
}