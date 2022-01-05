package org.spring.ps.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString(callSuper=true)
public class ReviewVO {
	
	private int revNum;
	private String userid;
	private String pid;
	private String revContent;
	private float rating;
	private Date revDate;
	
	
	//주문정보관련
	private String orderid;

}
