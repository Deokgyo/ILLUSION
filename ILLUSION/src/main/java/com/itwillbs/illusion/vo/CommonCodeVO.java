package com.itwillbs.illusion.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CommonCodeVO {
	public String code_group_id;
	public String code;
	public String code_name;
	public String parent_code_id;
}
