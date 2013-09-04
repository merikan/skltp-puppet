(function() {
    var App = function() {
        var socket;
        

        if (!window.WebSocket) {
            window.WebSocket = window.MozWebSocket;
        }

        if (window.WebSocket) {
	
        	var hostname = location.hostname
            new StompPush("ws://" + hostname + ":61614/stomp", "/topic/SOITOOLKIT.LOG.TOPIC", appendNotification, appendDebugLog);

        } else {
            alert("Your browser does not support Web Socket.");
        }
		
        function appendNotification(newData) {
  	        var log = eval('(' + newData + ')');
			var le = log.logEvent.logEntry;
			var eiMap = {};
			if (le.extraInfo !== undefined) {
				le.extraInfo.forEach(function ( val ) {
				    eiMap[ val.name ] = val.value;
				});
			}

	        var TABLE = document.getElementById("log-event-table");

            var rowCount = TABLE.rows.length;
            var row = TABLE.insertRow(rowCount);
            
			addColumn(row, 0,  le.runtimeInfo.timestamp);
			addColumn(row, 1,  le.messageInfo.level);
			addColumn(row, 2,  le.messageInfo.message);
			addColumn(row, 3,  le.metadataInfo.endpoint);
			addColumn(row, 4,  eiMap["senderid"]);
			addColumn(row, 5,  eiMap["receiverid"]);
			addColumn(row, 6,  eiMap["time.producer"]);
			addColumn(row, 7,  le.runtimeInfo.businessCorrelationId);
			addColumn(row, 8,  le.runtimeInfo.messageId);
			addColumn(row, 9,  eiMap["endpoint_url"]);
        }

		function addColumn(row, /* colWidth, */ id, val) {
			if (val === undefined) {
				val = "-";
			}

    		var cell = row.insertCell(id);
			cell.title = val;
            cell.innerHTML = val; 
		}

        function appendDebugLog(logLevel, logMessage) {

			var table = document.getElementById("log-event-table");
            var rowCount = table.rows.length;
            var row = table.insertRow(rowCount);
            
			addColumn(row, 0,  getTs());
			addColumn(row, 1,  logLevel);
			addColumn(row, 2,  logMessage);
			
			for (i=3;i<=9;i++) addColumn(row, i,  "");
        }

        function appendTextArea(newData, textAreaName) {
            var el = document.getElementById(textAreaName);
            el.value = getTs() + ": " + newData + '\n' + el.value;
        }

        function getTs() {
            
        	var ts = new Date();
            
            var h = ts.getHours();
            if (h < 10) h = '0' + h;
            
            var m = ts.getMinutes();
            if (m < 10) m = '0' + m;
            
            var s = ts.getSeconds();
            if (s < 10) s = '0' + s;

            var ms = ts.getMilliseconds();
            if (ms < 10) {
            	ms = '00' + ms;
            } else if (ms < 100) {
            	ms = '0' + ms;
            }
 
            return h + ":" + m + ":" + s + "." + ms;
        }
    }
    window.addEventListener('load', function() { new App(); }, false);
})();
