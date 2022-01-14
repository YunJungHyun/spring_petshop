package org.spring.ps.vo;


import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(callSuper=true)
public class UserVO {

	
	private int unum;
	private String userid;
	private String userpw;
	private String username;
	private String uemail;
	
	private Date user_regdate;
	
	private int ulevel;
	private String utype;
	
	private int orderCnt;
	private int reviewCnt;
	private int qnaCnt;

   
}

