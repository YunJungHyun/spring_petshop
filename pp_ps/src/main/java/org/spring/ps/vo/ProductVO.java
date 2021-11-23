package org.spring.ps.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString(callSuper=true)
public class ProductVO {

	
	private int pnum;
	private String pname;
	private String pcnt;
	private String pprice;
	private String parentCategory;
	private String cname;
	
	private String explicateHead;
	private String explicateBody;
	private String explicateFooterLeft;
	private String explicateFooterRight;
	
}
