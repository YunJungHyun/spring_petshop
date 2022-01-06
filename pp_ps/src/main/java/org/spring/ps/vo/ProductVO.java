package org.spring.ps.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString(callSuper=true)
public class ProductVO {

	
	private int pnum;
	
	private String pid;
	
	private String pname;
	private String pbrand;
	private int pcnt;
	private int pprice;
	private int pccode;
	private int pccoderef;
	private String pimg;
	private float prating;
	private float psale;
	
	
	private String pstate;
	
	private Date pregdate;
	
	
	private String pexplicate;
	
	private int reviewCnt;
	
}
