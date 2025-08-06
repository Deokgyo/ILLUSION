package com.itwillbs.illusion.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.itwillbs.illusion.vo.RecruitVO;

public interface RecruitMapper {

	@Mapper
	public List<RecruitVO> selectRecruitList();
	
	public RecruitVO selectRecruitIndex(int recruit_idx);

}
