package org.spring.ps.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString(callSuper=true)
public class BrandVO {
	
	private int bnum;
	private String bname;
	private String bimg;
	
}
