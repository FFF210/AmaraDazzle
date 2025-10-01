package dto.admin;

import dto.AdminInfo;
import dto.Brand;

public class AdminLoginResult {
	private boolean success;
	private String errorField; 
	private String errorMessage;
	private AdminInfo admin;
	
	
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public String getErrorField() {
		return errorField;
	}
	public void setErrorField(String errorField) {
		this.errorField = errorField;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	public AdminInfo getAdmin() {
		return admin;
	}
	public void setAdmin(AdminInfo admin) {
		this.admin = admin;
	} 

	
	
}
