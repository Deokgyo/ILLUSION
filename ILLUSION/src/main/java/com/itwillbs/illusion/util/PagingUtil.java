package com.itwillbs.illusion.util;

import com.itwillbs.illusion.vo.PageInfo;

public class PagingUtil {

    public static PageInfo getPageInfo(int pageNum, int listLimit, int pageListLimit, int listCount) {
        
        // 1. 최대 페이지 번호 계산
        int maxPage = (int) Math.ceil((double) listCount / listLimit);
        if (maxPage == 0) maxPage = 1; // 게시물이 없을 경우 기본 1페이지
        
        // 2. 현재 페이지 번호 유효성 검사 (음수 또는 최대 페이지 초과 방지)
        if (pageNum < 1) pageNum = 1;
        if (pageNum > maxPage) pageNum = maxPage;

        // 3. 시작 페이지 번호 계산
        int startPage = ((pageNum - 1) / pageListLimit) * pageListLimit + 1;
        
        // 4. 끝 페이지 번호 계산
        int endPage = startPage + pageListLimit - 1;

        // 5. 만약 끝 페이지가 최대 페이지보다 크면, 끝 페이지를 최대 페이지로 교체
        if (endPage > maxPage) {
            endPage = maxPage;
        }

        // 6. 계산된 모든 값을 PageInfo 객체에 담아 반환
        return new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
    }
}
