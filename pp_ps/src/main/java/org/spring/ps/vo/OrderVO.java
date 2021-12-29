package org.spring.ps.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter@ToString(callSuper=true)
public class OrderVO {
	
	private String orderid;
	private String userid;
	private String orderRec;
	private String userAddr1;
	private String userAddr2;
	private String userAddr3;
	private String orderPhon;
	private String delivery;
	private int amount;
	private Date orderDate;

}
