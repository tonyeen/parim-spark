package net.parim.sns.modules.sys.exception;

public class UnknownAccountException extends Exception {

	private static final long serialVersionUID = 5098340649687016880L;

	public UnknownAccountException() {
		super();
	}
	
	public UnknownAccountException(String message) {
		super(message);
	}
}
