component implements="IMessagesContainer" accessors="true" {
	
	property name="Messages" type="Array";
	
	public any function init() {
		setMessages([]);
		return this;
	}

	public void function addMessage(required struct message)
	description = "Adds a message to container"
	{
		ArrayAppend(variables.Messages,message);
	}

	public array function getMessages(string filter = "", string filterBy = "")
	description = "Returns (optionally filtered) messages"
	{

		if (ListLen(filter)) {
			return arrayFilter(variables.Messages, function(message) { 
				return structKeyExists(message,filterBy) && ListFindNoCase(filter,message[filterBy]);
			});
		} else {
			return variables.Messages;
		}

	}
	
}