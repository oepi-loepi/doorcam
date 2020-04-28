import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0

Tile {
	id: doorcamTile

	function init() {}

	onClicked: {
		if (app.doorcamFullScreen) {
			app.doorcamFullScreen.show();
			console.log("webcam: app.doorcamFullScreen.show() called")
		}
	}

 	function getDOM() {
        	var doc = new XMLHttpRequest();
        	doc.onreadystatechange = function() {
            		if (doc.readyState == XMLHttpRequest.DONE) {
				var JsonString = doc.responseText;
        			var JsonObject= JSON.parse(JsonString);

        			//retrieve values from JSON again
        			var aString = JsonObject.result[0].Value;

				if (aString == "100"){
					if (app.doorcamFullScreen) {
						//app.doorcamFullScreen.showMinimized();
						app.doorcamFullScreen.hide();
						console.log("webcam: app.webcamFullScreen.hide() called")
					}
				}

				if (aString == "200"){
					if (app.doorcamFullScreen) {
						app.doorcamFullScreen.show();
						console.log("webcam: app.webcamFullScreen.show() called")
					}
				}

				//mainText.text = doc.responseText;
            		}
        	}
		var domURL2 = app.domoticzURL1
		domURL2 += "/json.htm?type=command&param=getuservariable&idx="
		domURL2 += app.domoticzIDX
		doc.open("get", domURL2);
        	doc.setRequestHeader("Content-Encoding", "UTF-8");
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
        	onTriggered: getDOM()
    	}
}

