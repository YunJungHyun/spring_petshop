package org.spring.ps.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString(callSuper=true)
public class CategoryVO {
	
	private int level;
	private String cname;
	private String ccode;
	private String ccoderef;
}
