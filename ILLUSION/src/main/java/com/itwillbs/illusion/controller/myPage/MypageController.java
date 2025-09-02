package com.itwillbs.illusion.controller.myPage;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.illusion.service.BoardService;
import com.itwillbs.illusion.service.CommonCodeService;
import com.itwillbs.illusion.service.MemberService;
import com.itwillbs.illusion.service.MypageService;
import com.itwillbs.illusion.service.ResumeService;
import com.itwillbs.illusion.util.PrincipalRefresher;
import com.itwillbs.illusion.vo.CommonCodeVO;
import com.itwillbs.illusion.vo.MemberVO;
import com.itwillbs.illusion.vo.ResumeVO;

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
	@Autowired
	CommonCodeService commonCodeService;
	
	@Autowired
	PrincipalRefresher principalRefresher;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	/*이력서 등록*/
	@GetMapping("resumeWrite")
	public String resumeWriteForm(Principal principal, Model model) {
		
		String id = principal.getName();
		System.out.println(id);
		
		MemberVO member = resumeService.SelectM(id);
		
		model.addAttribute("member", member);
		
	    ResumeVO resume = resumeService.getResumeForEdit(member.getMember_idx()); // 본인 확인 로직 포함
	    
	    model.addAttribute("resume", resume);
	    
		List<CommonCodeVO> degreeList = resumeService.getCodes("DEGREE");
		List<CommonCodeVO> experienceList = resumeService.getCodes("EXPERIENCE");
		List<CommonCodeVO> occupationList = resumeService.getCodes1("OCCUPATION");
		List<CommonCodeVO> positionList = resumeService.getCodes("POSITION");
		model.addAttribute("degreeList", degreeList);
        model.addAttribute("experienceList", experienceList);
        model.addAttribute("occupationList", occupationList);
        model.addAttribute("positionList", positionList);
        
        
		return "myPage/resumeWrite";
	}
	
	@PostMapping("resumeWrite")
	public String resumeWrite(@RequestParam Map<String, Object> paramMap
								, HttpSession session
								,HttpServletRequest req
								, @RequestParam("resume_img") MultipartFile file1
								,Principal principal
								, @RequestParam("member_idx") int member_idx
								) {
		
		
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
	    System.out.println("============================");
	    System.out.println(paramMap);
	    
		// 서비스 호출 - insert 시 useGeneratedKeys로 resume_idx 채워줌
		resumeService.insertResumeAndExpInfo(paramMap);
		
		return "redirect:/savedResumeDetail?resume_idx=" + paramMap.get("resume_idx") + "&member_idx="
				+ paramMap.get("member_idx");
	}


	/* 회원정보 수정 */
	@GetMapping("userInfoEdit")
	public String userInfoEdit(Model model
							,Principal principal) {
		String id = principal.getName();
		
		MemberVO member = resumeService.SelectM(id);
		model.addAttribute("member",member);
		List<CommonCodeVO> genderList = resumeService.getCodes("GENDER");
		model.addAttribute("genderList", genderList);
		
		return "myPage/userInfoEdit";
	}
	/*회원정보 수정 */
	@PostMapping("userInfoEdit")
	public String userInfoEdit(@RequestParam Map<String, Object> paramMap,
	                           HttpSession session,
	                           HttpServletRequest req,
	                           @RequestParam("profile_picture_url") MultipartFile file1,
	                           RedirectAttributes redirectAttributes) {

	    // member_idx Integer 변환
	    int memberIdx = Integer.parseInt(paramMap.get("member_idx").toString());
	    paramMap.put("member_idx", memberIdx);

	    // 성별 코드 변환
	    if (paramMap.get("gender") != null) {
	        String genderInput = paramMap.get("gender").toString();
	        Map<String, String> genderMap = Map.of("남", "GEN001", "여", "GEN002");
	        paramMap.put("gender", genderMap.getOrDefault(genderInput, null));
	    }

	    String existingFilePath = resumeService.getProfilePicturePath(memberIdx);

	    String realPath = req.getServletContext().getRealPath(virtualPath);
	    String subDir = createDirectories(realPath);
	    realPath += "/" + subDir;

	    if (!file1.isEmpty()) {
	        String fileName = UUID.randomUUID().toString() + "_" + file1.getOriginalFilename();
	        String savedPath = subDir + "/" + fileName;
	        try {
	            file1.transferTo(new File(realPath, fileName));
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        paramMap.put("profile_picture_url", savedPath);
	    } else {
	        paramMap.put("profile_picture_url", existingFilePath);
	    }

	    resumeService.updateuserInfoEdit(paramMap);
	    
	    // 로그인 세션에 회원정보 수정 즉시 반영
	    principalRefresher.refreshPrincipal();
	    
	    redirectAttributes.addFlashAttribute("msg", "회원 정보가 수정되었습니다.");
	    
	    return "redirect:/myPage";
	}



	/* 비밀번호변경 */
	@GetMapping("changePasswd")
	public String changePasswd(Model model,
							@RequestParam int member_idx,
							RedirectAttributes redirectAttributes) {
		
		System.out.println("맴버아이디" + member_idx);
		Map<String, Object> selectuserInfoEdit = resumeService.selectuserInfoEdit(member_idx);
		model.addAttribute("selectuserInfoEdit", selectuserInfoEdit);
		return "myPage/changePasswd";
	}
	@PostMapping("changePasswd")
	public String changePasswd(@RequestParam int member_idx
            				,@RequestParam String member_pw
            				,RedirectAttributes redirectAttributes) {
		
		resumeService.changePasswd(member_idx, member_pw);
		redirectAttributes.addFlashAttribute("msg", "비밀 번호가 변경되었습니다.");
		return "redirect:/myPage";
	}
	
	/* 회원탈퇴 */
	@GetMapping("deleteMember")
	public String deleteMember(Model model, @RequestParam int member_idx) {
		Map<String, Object> selectuserInfoEdit = resumeService.selectuserInfoEdit(member_idx);
		model.addAttribute("selectuserInfoEdit", selectuserInfoEdit);
		return "myPage/deleteMember";
	}
	@PostMapping("deleteMember")
	public String deleteMember(@RequestParam int member_idx,
	                           @RequestParam String member_id,
	                           @RequestParam String member_pw,
	                           HttpSession session,
	                           RedirectAttributes redirectAttributes,
	                           Model model
	                           ) {

	    // 1. DB에서 회원 정보 조회
	    Map<String, Object> user = resumeService.selectuserInfoEdit(member_idx);
	    if (user == null) {
	    	model.addAttribute("msg", "회원 정보가 존재하지 않습니다.");
	        return "myPage/deleteMember";
	    }

	    String savedId = user.get("member_id").toString();
	    String savedPw = user.get("member_pw").toString(); // 암호화된 비밀번호

	    // 2. 아이디/비밀번호 검증
	    if (!savedId.equals(member_id) || !passwordEncoder.matches(member_pw, savedPw)) {
	        model.addAttribute("msg", "탈퇴 실패: 아이디 또는 비밀번호가 일치하지 않습니다.");
	        return "myPage/deleteMember"; // redirect 없이 JSP 반환
	    }
	    // 3. 탈퇴 처리
	    boolean success = resumeService.deleteMember(member_idx); // int 기반 메서드
	    if (success) {
	    	session.invalidate();
	    	SecurityContextHolder.clearContext();
	        redirectAttributes.addFlashAttribute("msg", "정상적으로 탈퇴되었습니다.");
	        return "redirect:login";
	    } else {
	    	model.addAttribute("msg", "탈퇴 처리 중 오류가 발생했습니다.");
	        return "myPage/deleteMember";
	    }
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
