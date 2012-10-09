import core.*;

component accessors="true" displayname="CFUserMessage"  {
	
	// Used as a name for the key under which messages container is stored in request context;
	property name="refName" type="string";

	public function init()
	description  = "Initializes module and sets a name for the struct key under which messages container will be stored."
	{
		setRefName("cfusrmsg#createuuid()#");
		return this;
	}

	public core.IMessagesContainer function getContainer(required struct rc) {
		if (! structKeyExists(rc,getRefName())) {
			rc[getRefName()] = new messagesContainer();
		} 		
		return rc[getRefName()];
	}

	public void function add(required struct rc, required struct message)
	description = "Adds message to the container"
	{
		getContainer(rc).addMessage(message);
		return;
	}

	public boolean function has(required struct rc)
	description = "Checks that message container is defined in request context and that it qualifies as such."
	{
		return 
			structKeyExists(rc,getRefName())  && 
			ArrayLen(getContainer(rc).getMessages());
	}

	public array function get(required struct rc, string filter = "", string filterBy = "type")
	description = "Returns an array of messages if there is message container in request context, or an empty array otherwise;
	optionally it accepts a list of keywords, that are used to filter messages by their type;"
	{
		if (has(rc)) return getContainer(rc).getMessages(filter, filterBy);
		else return [];
	}

}