package com.itwillbs.illusion.controller.myPage;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.print.DocFlavor.STRING;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.illusion.service.BoardService;
import com.itwillbs.illusion.service.MemberService;
import com.itwillbs.illusion.service.MypageService;
import com.itwillbs.illusion.service.ResumeService;
import com.itwillbs.illusion.util.PagingUtil;
import com.itwillbs.illusion.vo.ApplyVO;
import com.itwillbs.illusion.vo.MemberVO;
import com.itwillbs.illusion.vo.PageInfo;
import com.itwillbs.illusion.vo.RecruitFilterVO;
import com.itwillbs.illusion.vo.ResumeVO;
import com.itwillbs.illusion.vo.ScrapVO;

@Controller	
public class MypageController {
	@Autowired
	ResumeService resumeService;
	
	// 업로드 경로(이클립스 프로젝트 상의 경로)
	String virtualPath = "/resources/upload";

	@Autowired
	BoardService service;
	  
	@Autowired
	MemberService memberService;
	
	@Autowired
	MypageService mypageService;

	/* 이력서 등록 */
	@GetMapping("resumeWrite")
	public String resumeWriteForm() {
		return "myPage/resumeWrite";
	}

	@PostMapping("resumeWrite")
	public String resumeWrite(@RequestParam Map<String, Object> paramMap
								, HttpSession session
								,HttpServletRequest req
								, @RequestParam("resume_img") MultipartFile file1) {
		
		
		//1.가상의 경로에 대한 서버상의 실제 경로 알아내기
		String realPath =req.getServletContext().getRealPath(virtualPath);
		System.out.println(realPath);
		
		//2.업로드 경로관리
		String subDir = createDirectories(realPath);
		realPath += "/" + subDir;
		
		// 3. 파일 처리
		Map<String, String> savedFiles = new HashMap<>();
		MultipartFile[] files = {file1};
		String[] keys = {"resume_img"};
	    
	    for (int i = 0; i < files.length; i++) {
	        MultipartFile mFile = files[i];
	        if (!mFile.isEmpty()) {
	            String fileName = UUID.randomUUID().toString() + "_" + mFile.getOriginalFilename();
	            savedFiles.put(keys[i], subDir + "/" + fileName);
	            try {
	                mFile.transferTo(new File(realPath, fileName));
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	    }
	    
	    // 4. Map에 파일 경로 추가
	    paramMap.putAll(savedFiles);
	    
	    
		// 서비스 호출 - insert 시 useGeneratedKeys로 resume_idx 채워줌
		resumeService.insertResumeAndExpInfo(paramMap);

		return "redirect:/savedResumeDetail?resume_idx=" + paramMap.get("resume_idx") + "&member_idx="
				+ paramMap.get("member_idx");
	}

	/* 이력서 수정 */
	@GetMapping("resumeUpdate")
	public String resumeUpdate(@RequestParam int resume_idx, Model model) {
		Map<String, Object> resume = resumeService.selectResume(resume_idx);
		model.addAttribute("resume", resume);
		List<Map<String, Object>> resumeExpInfoList = resumeService.selectResumeExpInfoList(resume_idx);
		model.addAttribute("resume_exp_info_list", resumeExpInfoList);
		return "myPage/resumeUpdate";
	}

	/* 이력서 수정 */
	@PostMapping("resumeUpdate")
	public String resumeUpdate(@RequestParam Map<String, Object> paramMap, HttpSession session, int resume_idx,
			Model model) {

		Map<String, Object> resume = resumeService.selectResume(resume_idx);
		model.addAttribute("resume", resume);
		resumeService.updateResumeAndExpInfo(paramMap);

		return "redirect:/savedResumeDetail?resume_idx=" + paramMap.get("resume_idx") + "&member_idx="
				+ paramMap.get("member_idx");
	}

	/* 회원정보 수정 */
	@GetMapping("userInfoEdit")
	public String userInfoEdit(Model model, @RequestParam int member_idx) {

		System.out.println("맴버아이디" + member_idx);
		Map<String, Object> selectuserInfoEdit = resumeService.selectuserInfoEdit(member_idx);
		model.addAttribute("selectuserInfoEdit", selectuserInfoEdit);
		
		return "myPage/userInfoEdit";
	}
	/*회원정보 수정 */
	@PostMapping("userInfoEdit")
    public String userInfoEdit(@RequestParam Map<String, Object> paramMap) {

        // member_idx는 Integer로 변환
        if (paramMap.get("member_idx") instanceof String) {
            paramMap.put("member_idx", Integer.parseInt((String) paramMap.get("member_idx")));
        }
        System.out.println("paramMap = " + paramMap);
        resumeService.updateuserInfoEdit(paramMap);
        
        return "redirect:/myPage";
    }

	/* 이력서 상세보기 */
	@GetMapping("savedResumeDetail")
	public String savedResumeDetail(@RequestParam int resume_idx, @RequestParam int member_idx, Model model) {
		Map<String, Object> member = resumeService.selectMember(member_idx);
		model.addAttribute("member", member);
		Map<String, Object> resume = resumeService.selectResume(resume_idx);
		model.addAttribute("resume", resume);
		List<Map<String, Object>> resumeExpInfoList = resumeService.selectResumeExpInfoList(resume_idx);
		model.addAttribute("resume_exp_info_list", resumeExpInfoList);
		System.out.println("resumeExpInfoList = " + resumeExpInfoList);

		return "myPage/savedResumeDetail";
	}

	/* 자소서 상세보기 */
	@GetMapping("savedCLDetail")
	public String savedCLDetail(@RequestParam int cl_idx, @RequestParam int member_idx, Model model) {
		Map<String, Object> member = resumeService.selectMember(member_idx);
		model.addAttribute("member", member);
		Map<String, Object> cl = resumeService.selectCL(cl_idx);
		model.addAttribute("cl", cl);

		return "myPage/savedCLDetail";
	}

	/* 비밀번호변경 */
	@GetMapping("changePasswd")
	public String changePasswd(Model model, @RequestParam int member_idx) {
		System.out.println("맴버아이디" + member_idx);
		Map<String, Object> selectuserInfoEdit = resumeService.selectuserInfoEdit(member_idx);
		model.addAttribute("selectuserInfoEdit", selectuserInfoEdit);
		return "myPage/changePasswd";
	}

	/* 회원탈퇴 */
	@GetMapping("deleteMember")
	public String deleteMember() {
		return "myPage/deleteMember";
	}
	
	private String createDirectories(String realPath) {
		// Date 또는 LocalXXX 클래스 활용
		
		// 1. LocalXXX 클래스 활용
		// => 날짜 정보: LocalDate, 시간정보: LocalTime, 날짜 및 시간: LocalDateTime
		LocalDate today = LocalDate.now();
		// 2025-07-28
		
		// 2. 날짜 포멧을 디렉토리 형식에 맞게 변경 (ex. 2025-01-06 -> 2025/01/06)
		String datePattern = "yyyy/MM/dd";
		
		// 3. 지정한 포멧을 적용하여 날짜 형식 변경
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		String subDir = today.format(dtf);
		
		// 4. 기존 실제 업로드 경로에 서브디렉토리 결합
		realPath += "/" + subDir;
		
		try {
			// 5. 해당 디렉토리를 실제 경로상에 생성
			// 5-1) java.nio.file.Paths 클래스의 get() 메서드 호출하여 Path 객체 리턴
			Path path = Paths.get(realPath);
			
			// 5-2) Files 클래스의 createDirectories() 호출하여 실제 경로 생성
			Files.createDirectories(path);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return subDir;
	}
}
