package org.spring.ps.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter@ToString(callSuper=true)
public class AdminVO {

	private int anum;
	private String adminid;
	private String adminpw;
	private String adminname;
	
}
