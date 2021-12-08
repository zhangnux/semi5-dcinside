package vo;

import java.sql.Date;

public class User {

	private int no;
	private String id;
	private String password;
	private String name;
	private String tel;
	private String email;
	private String deleted;
	private Date createdDate;

	public User(){}
	
	public int getNo() {
		return no;
	}
	
	public void setNo(int no) {
		this.no = no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public Date getCreateDate() {
		return createdDate;
	}

	public void setCreateDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	
	
	
	
	
}
