package org.spring.ps.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter@ToString(callSuper=true)
public class OrderDetailVO {

	
	private int orderDetailNum;
	private String orderid;
	private String pid;
	private int cstock;
}
