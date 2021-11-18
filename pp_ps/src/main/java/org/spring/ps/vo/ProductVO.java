package org.spring.ps.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString(callSuper=true)
public class ProductVO {

	
	private int pnum;
	private String pname;
	private int pcnt;
	private int pprice;
	private String pslideimg;
	private int categoryNumber;

}
