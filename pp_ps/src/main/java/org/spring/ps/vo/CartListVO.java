package org.spring.ps.vo;


import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(callSuper=true)
public class CartListVO {
	
	
	private int cnum;
	private String userid;
	private String pid;
	private int cstock;
	private Date addDate;
	
	private String pname;
	private String pprice;
	private String pimg;
}
