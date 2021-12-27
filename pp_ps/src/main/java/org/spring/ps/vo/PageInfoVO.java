package org.spring.ps.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(callSuper=true)
public class PageInfoVO {

	private String pageName;
	private String pageHref;
}
