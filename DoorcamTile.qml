import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0

Tile {
	id: doorcamTile

	function init() {}

	onClicked: {
		if (app.doorcamFullScreen) {
			app.doorcamFullScreen.show();
			if (app.debugOutput) console.log("doorcam: app.doorcamFullScreen.show() called")
		}
	}

 	function getDOM() {
		if (app.debugOutput) console.log("doorcam: checking")
		var doc = new XMLHttpRequest();
		doc.onreadystatechange = function() {
			if (doc.readyState == XMLHttpRequest.DONE) {
				if (doc.status === 200 || http.status === 300  || http.status === 302) {
					if (app.debugOutput) console.log("doorcam: responseText: " +  doc.responseText)
					var JsonString = doc.responseText;
					var JsonObject= JSON.parse(JsonString);
					var aString = JsonObject.result[0].Value;
					if (app.debugOutput) console.log("doorcam: aString: " +  aString)

					if (aString == "100"){
						if (app.doorcamFullScreen) {
							//app.doorcamFullScreen.showMinimized();
							app.doorcamFullScreen.hide();
							if (app.debugOutput) console.log("doorcam: app.webcamFullScreen.hide() called")
						}
					}

					if (aString == "200"){
						if (app.doorcamFullScreen) {
							app.doorcamFullScreen.show();
							if (app.debugOutput) console.log("doorcam: app.webcamFullScreen.show() called")
						}
					}
				}
			}
		}
		var domURL2 = app.domoticzURL1
		domURL2 += "/json.htm?type=command&param=getuservariable&idx="
		domURL2 += app.domoticzIDX
		doc.open("get", domURL2);
		doc.setRequestHeader("Content-Encoding", "UTF-8");
		doc.send();
   	 }


 	function getha() {
		var doc = new XMLHttpRequest();
		doc.onreadystatechange = function() {
			if (doc.readyState == XMLHttpRequest.DONE) {
				if (doc.status === 200 || http.status === 300  || http.status === 302) {
					var JsonString = doc.responseText;

					if (app.debugOutput) console.log(JsonString)

					var JsonObject = JSON.parse(JsonString);
					//retrieve values from JSON again
					var aString = JsonObject.state;

					if (aString == "100.0"){
						if (app.doorcamFullScreen) {
							//app.doorcamFullScreen.showMinimized();
							app.doorcamFullScreen.hide();
							if (app.debugOutput) console.log("doorcam: app.webcamFullScreen.hide() called")
						}
					}

					if (aString == "200.0"){
						if (app.doorcamFullScreen) {
							app.doorcamFullScreen.show();
							if (app.debugOutput) console.log("doorcam: app.webcamFullScreen.show() called")
						}
					}

				}
			}
		}
		var haURl2 = app.haURL1
		haURl2 += "/api/states/"
		haURl2 += app.haEntity_id

		doc.open("GET", haURl2, true);
		doc.setRequestHeader("Authorization", "Bearer " + app.haToken);
		doc.setRequestHeader("Content-Type", "application/json");
		doc.send();
   	 }

	Image {
		id: tileDoorcamImage1
    		width: 200; height: 140
		source: "qrc:/tsc/doorcam_large.jpg"
		anchors {
			verticalCenter: parent.verticalCenter
			horizontalCenter: parent.horizontalCenter
		}
		cache: false
	}

	Text {
		id: mytext
		text: "DoorCam"

		font {
			family: qfont.semiBold.name
			pixelSize: 24
		}

		anchors {
			bottom: parent.bottom
			bottomMargin: 5
			horizontalCenter: parent.horizontalCenter
		}
	}

	
	Timer {
        	id: deurTimer
        	interval: 4000
        	repeat: true
        	running: true
        	triggeredOnStart: true
        	onTriggered: app.domMode? getDOM() : getha()
    	}
}

