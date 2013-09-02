(function() {
    var App = function() {
        var socket;
        

        if (!window.WebSocket) {
            window.WebSocket = window.MozWebSocket;
        }

        if (window.WebSocket) {
	
        	var hostname = location.hostname
			hostname = "33.33.33.33"
            alert("Connecting to hardcoded Web Socket node: " + hostname);
//        	socket = new Sock("ws://" + hostname + ":8080/websocket", appendWebSocketTextArea, appendDebugTextArea);
            new StompPush("ws://" + hostname + ":61614/stomp", "/topic/SOITOOLKIT.LOG.TOPIC", appendNotification, appendDebugLog);
//            new MqttPush(hostname, "61614", "/wsone.notify", appendMqttNotificationTextArea, appendDebugTextArea);

        } else {
            alert("Your browser does not support Web Socket.");
        }

/*
        function send(event) {
        	socket.send(event);
        }
        document.forms.inputform.addEventListener('submit', send, false);

        function appendWebSocketTextArea(newData) {
        	appendTextArea(newData, 'responseText');
        }
*/
		
        function appendNotification(newData) {
//        	appendTextArea(newData, 'stompNotification');
  	        var log = eval('(' + newData + ')');
			var le = log.logEvent.logEntry;
			var eiMap = {};
			le.extraInfo.forEach(function ( val ) {
			    eiMap[ val.name ] = val.value;
			});

	        var TABLE = document.getElementById("log-event-table");

			var TBL_HDR = TABLE.rows[0].childNodes;
//			alert("Cells: " + TBL_HDR.length);
//			console.log("Cells: " + TBL_HDR.length);
			var TBL_COL_WIDTHS = [];
			for (var i = 0; i < TBL_HDR.length; i++) {
				var cell = TBL_HDR[i];
				var width = cell.width;
				if (width !== undefined) {
//					console.log("th width: " + cell.width);
					TBL_COL_WIDTHS.push(width);
				}
			}
/*
			for (var i = 0; i < TBL_HDR.length; i++) {
				var cell = TBL_HDR[i];
//				console.log("Cell type: " + cell.constructor.name);
				if (cell instanceof th) {
//					console.log("th width: " + cell.width);
					TBL_COL_WIDTHS.push(cell.width);
				}
			}
*/
            var rowCount = TABLE.rows.length;
            var row = TABLE.insertRow(rowCount);
            
			addColumn(row, TBL_COL_WIDTHS[0], 0,  le.runtimeInfo.timestamp);
			addColumn(row, TBL_COL_WIDTHS[1], 1,  le.messageInfo.level);
			addColumn(row, TBL_COL_WIDTHS[2], 2,  le.messageInfo.message);
			addColumn(row, TBL_COL_WIDTHS[3], 3,  le.metadataInfo.endpoint);
			addColumn(row, TBL_COL_WIDTHS[4], 4,  eiMap["senderid"]);
			addColumn(row, TBL_COL_WIDTHS[5], 5,  eiMap["receiverid"]);
			addColumn(row, TBL_COL_WIDTHS[6], 6,  eiMap["time.producer"]);
			addColumn(row, TBL_COL_WIDTHS[7], 7,  le.runtimeInfo.businessCorrelationId);
			addColumn(row, TBL_COL_WIDTHS[8], 8,  le.runtimeInfo.messageId);
			addColumn(row, TBL_COL_WIDTHS[9], 9,  eiMap["endpoint_url"]);
//			addColumn(row, TBL_COL_WIDTHS[10], 10, newData);
        }

		function addColumn(row, colWidth, id, val) {
			if (val === undefined) {
				val = "-";
			}

			var maxLength = 30;
			var displayText;
			if (val.length > maxLength) {
				displayText = val.substring(0, maxLength - 3) + "...";
			} else {
				displayText = val;
			}
    		var cell = row.insertCell(id);
			cell.style.width = colWidth + "px";
    		cell.innerHTML = "<div width='" + colWidth + "' class='tooltip-x' title='" + val + "'><span width='" + colWidth + "' title=''>" + displayText + "</span></div>";
//"<a class='showTip' alt='" + val + "' href='#'>" + val + "</a>";
		}
/*
        function appendMqttNotificationTextArea(newData) {
        	appendTextArea(newData, 'mqttNotification');
        }
*/
        function appendDebugLog(logLevel, logMessage) {
//        	appendTextArea(newData, 'debug');

			var table = document.getElementById("log-event-table");
            var rowCount = table.rows.length;
            var row = table.insertRow(rowCount);
            
			var TBL_HDR = table.rows[0].childNodes;
			var TBL_COL_WIDTHS = [];
			for (var i = 0; i < TBL_HDR.length; i++) {
				var cell = TBL_HDR[i];
				var width = cell.width;
				if (width !== undefined) {
//					console.log("th width: " + cell.width);
					TBL_COL_WIDTHS.push(width);
				}
			}

			addColumn(row, TBL_COL_WIDTHS[0], 0,  getTs());
			addColumn(row, TBL_COL_WIDTHS[1], 1,  logLevel);
			addColumn(row, TBL_COL_WIDTHS[2], 2,  logMessage);
			
			for (i=3;i<=9;i++) addColumn(row, TBL_COL_WIDTHS[i], i,  "");
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
