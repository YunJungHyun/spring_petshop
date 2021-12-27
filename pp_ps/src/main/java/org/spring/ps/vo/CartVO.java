package org.spring.ps.vo;


import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(callSuper=true)
public class CartVO {
	
	
	private int cnum;
	private String userid;
	private String pid;
	private int cstock;
	private Date addDate;
	

}
