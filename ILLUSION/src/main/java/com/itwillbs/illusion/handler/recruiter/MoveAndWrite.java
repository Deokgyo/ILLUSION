package com.itwillbs.illusion.handler.recruiter;

import java.io.File;
import java.io.IOException;
import java.nio.file.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class MoveAndWrite {
	
	public static String moveAndRewrite(String context) {
	    if (context == null || context.isEmpty()) return context;

	    // 0단계에서 만든 물리 폴더
	    final Path TEMP_BASE = Paths.get("D:/illusion/upload/temp");
	    final Path REAL_BASE = Paths.get("D:/illusion/upload/real");

	    try {
	        Files.createDirectories(TEMP_BASE);
	        Files.createDirectories(REAL_BASE);
	    } catch (IOException ignore) {}

	    // 본문에서 /illusion/upload/temp/ 뒤의 상대경로(연/월/일/파일명) 추출
	    Pattern p = Pattern.compile("/illusion/upload/temp/([^\\s\"'>]+)");
	    Matcher m = p.matcher(context);

	    while (m.find()) {
	        String rel = m.group(1); // 예: 2025/08/31/a.png
	        Path src = TEMP_BASE.resolve(rel.replace("/", File.separator));
	        Path dst = REAL_BASE.resolve(rel.replace("/", File.separator));

	        try {
	            Files.createDirectories(dst.getParent()); // 하위 폴더 생성
	            if (Files.exists(src)) {
	                Files.move(src, dst, StandardCopyOption.REPLACE_EXISTING);
	            }
	            // 본문 경로 temp → real 치환
	            context = context.replace("/illusion/upload/temp/" + rel,
	                                      "/illusion/upload/real/" + rel);
	        } catch (IOException e) {
	            // 실패해도 나머지 계속 (본문 치환은 진행)
	        }
	    }
	    return context;
	}
}
