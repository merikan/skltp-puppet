function StompPush (url, topic, displayMessage, displayLog) {

	var client;
    
	// this allows to display logs directly on the web page
    var log = function(str) {
    	displayLog("INFO", str);
    };  
    var logError = function(str) {
    	displayLog("ERROR", str);
    };  

    // the client is notified when it is connected to the server.
    var onconnect = function(frame) {
      log("Connected to WebSocket, subscribe to Stomp destination: " + topic)

      client.subscribe(topic, function(message) {
   	    displayMessage(message.body);
      });
    };

	log("Connects to WebSocket: " + url);
    client = Stomp.client(url);
    
    client.debug = function(str) {
//    	log(str);
    };

    client.connect("", "", onconnect);
}