package org.spring.ps.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString(callSuper=true)
public class QnAVO {
	
	
	private String qnaid;
	private String userid;
	private String parentid;
	private String qnaContent;
	private Date qnaDate;
	
	private String pid;

	private String username;
	private String pname;
	private String pimg;
	
	private String cname;
	private String subcname;
	
	private int eachCnt;
}
