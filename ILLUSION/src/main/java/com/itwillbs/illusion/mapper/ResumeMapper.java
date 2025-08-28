package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.illusion.vo.CommonCodeVO;
import com.itwillbs.illusion.vo.CoverLetterVO;
import com.itwillbs.illusion.vo.MemberVO;
import com.itwillbs.illusion.vo.ResumeVO;
import com.itwillbs.illusion.vo.ScrapVO;
@Mapper
public interface ResumeMapper {
	
	// 이력서 수정
	public ResumeVO getResumeForEdit(Map<String, Integer> params);
	public ResumeVO getExpForEdit(Map<String, Integer> params);
	

	int insertResume(Map<String, Object> resumeMap);
	int insertResume_exp_info(Map<String, Object> resumeMap);
	int updateResume(Map<String, Object> resumeMap);
	int updateResume_exp_info(Map<String, Object> resumeMap);
    Map<String, Object> selectResume(int resumeIdx);
	Map<String, Object> selectMember(int member_idx);
	public MemberVO getMemberInfoById(String id);

	List<Map<String, Object>> selectResumeExpInfoList(int resume_idx);
	List<Map<String, Object>> selectResumelist();
	
	public MemberVO SelectM(String id);
	List<CommonCodeVO> getCommonCodeList(String groupId);
	
	public MemberVO SelectM1(String id);
	List<CommonCodeVO> getCommonCodeList1(String groupId);
	
	
	
	/* 예상면접질문 */
	List<Map<String, Object>> selectquestList();

	/* 커뮤니티 */
	List<Map<String, Object>> selectboard();
	
	
	
	
	int updateuserInfoEdit(Map<String, Object> paramMap);
	Map<String, Object> selectuserInfoEdit(int member_idx);
	
	
	
	/* 자기소개서 */
	Map<String, Object> selectcl(int cl_idx);
	List<Map<String, Object>> selectcllist();
	
	// -------------------------------------
	// ResumeVO로 이력서 list 가져오기
	public List<ResumeVO> getResumeListByMemberId(
			@Param("memberIdx") int member_idx, 
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);
	
	// 회원의 이력서 갯수 조회
	public int getResumeListCountByMember(@Param("memberIdx") int member_idx);
	
	// 마이페이지 이력서 상세내용 조회
	 public List<ResumeVO> savedResumeDetail(@Param("resumeIdx") int resumeIdx);
	
    // 마이페이지 이력서 여러건 삭제
	public int deleteMyResumes(Map<String, Object> params);
	
	// CoverLetterVO로 자소서 list 가져오기
	public List<CoverLetterVO> getCLListByMemberId(
			@Param("memberIdx") int member_idx, 
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);
	
	// 회원의 자소서 갯수 조회
	public int getCLListCountByMember(@Param("memberIdx") int member_idx);
	
    // 마이페이지 이력서 여러건 삭제
	public int deleteMyCLs(Map<String, Object> params);
	
}
