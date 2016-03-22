package net.parim.common.message;

import java.io.Serializable;

public class Message implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String[] messages;
	private Type type = Type.info;
	private String separator = ";";
	
	public Message(String... messages){
		this.messages = messages;
	}
	
	public Message(Type type, String... messages){
		this.type = type;
		this.messages = messages;
	}
	
	public Message(String separator, Type type, String... messages){
		this.type = type;
		this.separator = separator;
		this.messages = messages;
	}
	
	public String toString(){
		return concatMessage(messages);
	}
	
	private String concatMessage(String[] messages){
		StringBuilder sb = new StringBuilder();
		for (String message : messages){
			sb.append(message).append(messages.length>1?separator:"");
		}
		return sb.toString();
	}
	
	public enum Type {
		info,
		warning,
		error,
		success
	}

	public String[] getMessages() {
		return messages;
	}

	public void setMessages(String... messages) {
		this.messages = messages;
	}

	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	public String getSeparator() {
		return separator;
	}

	public void setSeparator(String separator) {
		this.separator = separator;
	}

}
