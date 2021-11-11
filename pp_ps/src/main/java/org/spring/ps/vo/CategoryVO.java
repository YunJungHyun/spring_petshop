package org.spring.ps.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString(callSuper=true)
public class CategoryVO {
	
	private int cnum;
	private String cname;
	private String ctype;
	private String csort;
}
