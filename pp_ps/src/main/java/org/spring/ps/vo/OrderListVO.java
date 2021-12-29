package org.spring.ps.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter@ToString(callSuper=true)
public class OrderListVO {
	
	private String orderid;
	private String userid;
	private String orderRec;
	private String userAddr1;
	private String userAddr2;
	private String userAddr3;
	private String orderPhon;
	private int amount;
	private Date orderDate;
	
	private int orderDetailNum;
	private String pid;
	private int cstock;
	
	private String pname;
	private String pimg;
	private int  pprice;
	
}
