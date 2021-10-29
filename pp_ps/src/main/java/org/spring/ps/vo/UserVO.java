package org.spring.ps.vo;


import java.util.List;
import java.util.Map;

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
	private String uadress;
	
    private String user_pet_info;
    private String user_prod_info;
    
   
}

