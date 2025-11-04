package com.itwillbs.illusion.vo;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PaymentVO {
	private int pmnt_idx;
	private int member_idx;
	private int pmnt_amount;
	private int tk_amount;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime pmnt_date;
	private int refund_amount;
	private int refund_tk_amount;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime refund_date;
	private String pmnt_status;

}
