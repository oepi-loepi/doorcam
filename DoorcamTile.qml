import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0
import ScreenStateController 1.0

Tile {
	id: doorcamTile
	property bool dimState: screenStateController.dimmedColors
	property int oldScreenState: 5

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
				if (doc.status === 200 || doc.status === 300  || doc.status === 302) {
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
							
							if (app.debugOutput) console.log("doorcam oldScreenState : " + oldScreenState)
						
							if(oldScreenState ===1 || oldScreenState ===2 || oldScreenState ===3 || oldScreenState ===4) screenStateController.forceTestScreenState(oldScreenState)
							oldScreenState = 5	
						}
					}

					if (aString == "200"){
						if (app.doorcamFullScreen) {
							if(screenStateController.screenState === ScreenStateController.ScreenActive) oldScreenState = 1				
							if(screenStateController.screenState === ScreenStateController.ScreenDimmed) oldScreenState = 2	
							if(screenStateController.screenState === ScreenStateController.ScreenColorDimmed) oldScreenState = 3	
							if(screenStateController.screenState === ScreenStateController.ScreenOff) oldScreenState = 4	
							screenStateController.wakeup();
							screenStateController.forceTestScreenState(1)

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
				if (doc.status === 200 || doc.status === 300  || doc.status === 302) {
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
							if(screenStateController.screenState === ScreenStateController.ScreenActive) oldScreenState = 1				
							if(screenStateController.screenState === ScreenStateController.ScreenDimmed) oldScreenState = 2	
							if(screenStateController.screenState === ScreenStateController.ScreenColorDimmed) oldScreenState = 3	
							if(screenStateController.screenState === ScreenStateController.ScreenOff) oldScreenState = 3	
							screenStateController.wakeup();
							screenStateController.forceTestScreenState(1)

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

		if (app.debugOutput) console.log("doorcam: haURl2: " + haURl2)
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
		visible: !dimState
	}

	Text {
		id: mytext
		text: "DoorCam"
		color: dimmableColors.clockTileColor
		font {
			family: qfont.semiBold.name
			pixelSize: 24
		}

		anchors {
			bottom: dimState? parent.verticalCenter:parent.bottom
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

