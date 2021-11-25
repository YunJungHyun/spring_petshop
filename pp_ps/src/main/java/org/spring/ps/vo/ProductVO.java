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
	private String pcnt;
	private String pprice;
	private int pccode;
	private int pccoderef;
	private String pslideimg;
	
	private Date pregdate;
	
	private String img_fileName_arr_str;
	
	private String pexplicate;
	
	private String explicateHead;
	private String explicateBody;
	private String explicateFooterLeft;
	private String explicateFooterRight;
	
}
