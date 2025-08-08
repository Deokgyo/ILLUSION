package com.itwillbs.illusion.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BoardVO {
	private int board_idx;
	private String board_title;
	private int member_idx;
	private String board_type;
	private String board_content;
	private Date board_create_at;
	private Date board_update_date;
	private int board_viewcnt;
	
}
