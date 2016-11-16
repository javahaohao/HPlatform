package com.hplatform.test.entity;

import com.hplatform.core.entity.BaseEntity;
import java.util.List;

public class MemberInfo extends BaseEntity<MemberInfo>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String memberId;
	private String level;
	private String phone;
	private String email;
	private Member member;
	public void setMemberId(String memberId){
		this.memberId=memberId;
	}
	public String getMemberId(){
		return this.memberId;
	}
	public void setLevel(String level){
		this.level=level;
	}
	public String getLevel(){
		return this.level;
	}
	public void setPhone(String phone){
		this.phone=phone;
	}
	public String getPhone(){
		return this.phone;
	}
	public void setEmail(String email){
		this.email=email;
	}
	public String getEmail(){
		return this.email;
	}
	public void setMember(Member member){
		this.member=member;
	}
	public Member getMember(){
		return this.member;
	}
}