component extends="mxunit.framework.TestCase" {

	public void function beforeTests() {
		variables.cfusrmsg = new org.CFUserMessage.CFUserMessage();
	}

	public void function Tests() 
	description = "Tests that a message is added"
	{
		// this is our request context
		var rc = {};

		// Here is a set of various messages that are used in tests
		var msg1 = {  type = "error", body = "You email is invalid!" };
		var msg2 = {  type = "error", body = "The date is out of range!" };
		var msg3 = {  type = "error", body = "Such login name does not exist." };
		var msg4 = {  type = "info", body = "There are new messages." };
		var msg5 = {  type = "info", body = "The date has changed to tomorrow." };
		var msg6 = {  type = "success", body = "Message sent successfuly." };
		var msg7 = {  type = "success", body = "You cart was updated" };

		// Check that getContainer() functions returns a container object
		

		// Make sure, that initially there are no messages at all
		assertFalse(variables.cfusrmsg.has(rc), "There must be no messages at this point");

		// Then add severall messages;
		var messagesSet1 = [msg1, msg2, msg3, msg4];
		for (var msg in messagesSet1) {
			variables.cfusrmsg.add(rc, msg);
		}

		// Check that has() returns true now
		assertTrue(variables.cfusrmsg.has(rc), "There must be messages at this point");

		// Now check that the number of messages is correct
		assertEquals(ArrayLen(messagesSet1),ArrayLen(variables.cfusrmsg.get(rc)),"The count of messages must be equal to len of messagesSet1");

		// Add some more messages
		var messagesSet2 = [msg5, msg6, msg7];
		for (var msg in messagesSet2) {
			variables.cfusrmsg.add(rc, msg);
		}
		// Make sure that the total count was updated
		assertEquals(ArrayLen(messagesSet1) + ArrayLen(messagesSet2),ArrayLen(variables.cfusrmsg.get(rc)),
			"The updated count of messages must be equal to the sum of lens of messagesSet1 and messagesSet2");

		// Now we need to check filters
		
		// There shoud be 3 messages with type error
		assertEquals(3,ArrayLen(variables.cfusrmsg.get(rc, "error")));

		// There shoud be 2 messages with type info
		assertEquals(2,ArrayLen(variables.cfusrmsg.get(rc, "info")));

		// There shoud be 2 messages with type success
		assertEquals(2,ArrayLen(variables.cfusrmsg.get(rc, "success")));

		// There shoud be 5 messages with type success + error
		assertEquals(5,ArrayLen(variables.cfusrmsg.get(rc, "success,error")));

		// There shoud be 0 messages with type "succ,successasd"
		assertEquals(0,ArrayLen(variables.cfusrmsg.get(rc, "succ,successasd")));

		debug(rc);
	}
}