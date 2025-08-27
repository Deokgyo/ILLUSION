package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.illusion.vo.QuestionVO;
import com.itwillbs.illusion.vo.ScrapVO;

@Mapper
public interface QuestionMapper {
	
	public List<QuestionVO> getQuestionListByMemberId(
			@Param("memberIdx") int member_idx,
			@Param("clIdx") int clIdx,
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);
	
	// 회원의 질문 갯수 조회
	public int getQuestionListCountByMember(@Param("memberIdx") int member_idx);

	// 마이페이지 질문 여러건 삭제
	public int deleteAnswersByClIdxList(List<Integer> idList);
	public int deleteQuestionsByClIdxList(List<Integer> idList);
	
	public int deleteMyAnswerList(Map<String, Object> params);
	public int deleteMyQuestionList(Map<String, Object> params);
	
}
