A very simple plug-in to show messages (like errors, info, success) to user interacting with the application.

Tested for usage with Adobe ColdFusion 10. Will not work on previous versions because it uses some functions (ArrayFilter) and objects instantiation techniques that were added in ACF10. Should be ok for Railo 4 (but not tested).

It is designed to be used with any ColdFusion MVC framework that supports a concept of request context (a struct that is passed to all pages in the request). 

When there are messages which you want to convey to the user, you use API functions to store them. Usually messages are created and stored by a model CFC or a controller CFC; then all stored messages can be easily displayed in a view. Multiple messages can be stored during a single request (from any part of the application). 

Under the hood messages are stored in a special container which is a transient CFC which means it only exists till the end of request. But of cause you can pass this container between requests using whatever technique works for you. The container is created automatically, messages storage and retrieval is also done automatically so all you need to do is use 3 simple API functions of the module and you do not interact directly with the message container.

***Usage***

Instantiate module (it is a singleton object, no parameters required) and store it either in a bean factory or application scope (or wherever you store you singleton objects).

***API***

In examples, it is assumed that the module is stored in `application` scope under name `messenger`.

**public void function add (required struct rc, required struct message)**

The `add()` function adds a message to the message container. It takes two parameters: 1) request context 2) the message. Be careful to set all the keys you need in your message struct. An example:

    application.messenger.add( rc = rc, message =  { type = "error", body = "Invalid password or email." })

**public boolean function has(required struct rc)**

The `has()` functions returns true if there are messages stored, and false if there are none. It takes a single parameter – a request context. An example:

    <cfif application.messenger.has(rc)>
    <p>There are some messages for you</p>
    </cfif>

**public array function get(required struct rc, string filter = "", string filterBy = "type")**

The `get()` function returns all messages stored for the request. Again, it accepts a request context and optionally a filter and a filterBy params; filter param is a list of keywords against which a filter should be run; filterBy is a name of a key in your message structure which will be checked by the filter (the default value is "type"). If there are no messages stored, the function returns an empty array. An example:

    <ul>
    <cfloop array="#application.messenger.get(rc = rc, filter = 'error')#" index="message">
      <li>#message.body#</li>
    </cfloop>
    </ul>

There are also two functions that are not so likely to be used often:

**public core.IMessagesContainer function getContainer(required struct rc)**

The `getContainer()` function returns a container object if you need to do something with it.

**public string function getRefName()**

The `getRefName()` is a automatically generated function and it returns a name of the key under which message container object is stored in request context. 

The module is tested using MXUnit framework.