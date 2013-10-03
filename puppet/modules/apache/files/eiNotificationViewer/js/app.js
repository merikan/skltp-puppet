(function() {
    var App = function() {
        var socket;
        

        if (!window.WebSocket) {
            window.WebSocket = window.MozWebSocket;
        }

        if (window.WebSocket) {
	
        	var hostname = location.hostname
			hostname = "33.33.33.33"
            new StompPush("ws://" + hostname + ":61614/stomp", "/topic/DEMO.EI.NOTIFY.TOPIC", appendNotification, appendDebugLog);

        } else {
            alert("Your browser does not support Web Socket.");
        }
		
        function appendNotification(newData) {
  	        var soapEnv = eval('(' + newData + ')');
			var et = soapEnv["soap:Envelope"]["soap:Body"]["ns2:ProcessNotification"]["ns2:engagementTransaction"];
			//var et = soapEnv.Envelope.Body.engagementTransaction;
			var e  = et.engagement;

	        var TABLE = document.getElementById("ei-event-table");

            var rowCount = TABLE.rows.length;
            var row = TABLE.insertRow(rowCount);
            
			addColumn(row, 0,  e.registeredResidentIdentification);
			addColumn(row, 1,  e.serviceDomain);
			addColumn(row, 2,  e.categorization);
			addColumn(row, 3,  e.businessObjectInstanceIdentifier);
			addColumn(row, 4,  e.mostRecentContent);
			addColumn(row, 5,  e.logicalAddress);
			addColumn(row, 6,  e.sourceSystem);
			addColumn(row, 7,  e.dataController);
			addColumn(row, 8,  e.clinicalProcessInterestId);
			addColumn(row, 9,  et.deleteFlag);
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

			var table = document.getElementById("ei-event-table");
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
