package net.parim.system.exception;

public class IncorrectCredentialsException extends Exception {

	private static final long serialVersionUID = 5953798418443272306L;

	public IncorrectCredentialsException() {
	}
	
	public IncorrectCredentialsException(String message) {
		super(message);
	}
}
