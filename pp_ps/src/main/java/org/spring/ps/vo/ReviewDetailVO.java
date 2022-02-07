package org.spring.ps.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString(callSuper=true)
public class ReviewDetailVO {
	
	//제품 관련
	private String pid;
	private String pname;
	private String pimg;
	private int pprice;
	private float psale;
	
	private int revNum;
	private String userid;
	private String revContent;
	private float rating;
	private Date revDate;
	
	
	//주문정보관련
	private Date orderDate;
	private int cstock;
	private String orderid;
	
	//주문자 정보 관련
	private String username;

}
