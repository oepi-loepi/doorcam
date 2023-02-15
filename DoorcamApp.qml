import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0;
import FileIO 1.0

App {
	id: doorcamApp
	property bool  		debugOutput : false
	
	property bool  		needRestart : false
	property url 		tileUrl : "DoorcamTile.qml"
	property url 		thumbnailIcon: "qrc:/tsc/doorcam.png"
	property 			DoorcamFullScreen doorcamFullScreen
	property 			DoorcamConfigScreen doorcamConfigScreen
	property 			DoorcamTile doorcamTile

	property string 	doorcamImage1Source
	property string 	doorcamImage2Source
	property bool 		doorcamImage1Ready: false
	property bool 		doorcamImage2Ready: false
	property int 		doorcamImage1Z: 100
	property int 		doorcamImage2Z: 0
	property int 		pictureCycleCounter: 0
	property int 		pictureCountdownCounterStart: 10
	property int 		pictureCountdownCounter: 10
	property int 		doorcamTimer1Interval: 1000
	property bool 		doorcamTimer1Running: false
	property bool 		enableForceMode : false
	property bool 		domMode : true
	property string 	tmpdomMode : "Domoticz"
	property string 	tmpForceMode : "No"
	property string 	doorcamImageURL1 : "qrc:/tsc/connect.jpg"
	property string 	domoticzURL1 : "http://192.168.10.18:8080"
	property string 	domoticzIDX : "27"
	property string 	domoticzVAR : "ShowDoorCamToon"
	property string 	haURL1 : "http://192.168.10.18:8123"
	property string 	haEntity_id : "entity_id"
	property string 	haToken : "haToken"
	property bool 		cgiMode: false
	property string 	tmpcgiMode: "Yes"
	property url 		imageJPG : ""
	

// user settings from config file
	property variant doorcamSettingsJson : {
		'doorcamImageURL1': "",
		'domoticzURL1': "",
		'domoticzIDX': "",
		'domoticzVAR': "",
		'tmpForceMode': "",
		'haURL1': "",
		'haEntity_id': "",
		'haToken': "",
		'tmpdomMode': "",
		"cgiMode": ""
	}

	FileIO {
		id: doorcamSettingsFile
		source: "file:///mnt/data/tsc/doorcam_userSettings.json"
 	}

	QtObject {
		id: p
		property url doorcamFullScreenUrl : "DoorcamFullScreen.qml"
		property url doorcamConfigScreenUrl : "DoorcamConfigScreen.qml"
	}

	function init() {
		registry.registerWidget("tile", tileUrl, this, "doorcamTile", {thumbLabel: qsTr("Doorcam"), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"});
		registry.registerWidget("screen", p.doorcamFullScreenUrl, this, "doorcamFullScreen");
		registry.registerWidget("screen", p.doorcamConfigScreenUrl, this, "doorcamConfigScreen");
		doorcamImage1Source = doorcamImageURL1;
		doorcamImage2Source = doorcamImageURL1;
		doorcamImage1Z = 0;
		doorcamImage2Z = 100;
	}

	function listProperty(item){
    		for (var p in item)
    			console.log(p + ": " + item[p]);
	}


	Component.onCompleted: {
		try {
			doorcamSettingsJson = JSON.parse(doorcamSettingsFile.read());

			if (doorcamSettingsJson['tmpForceMode'] == "Yes") {
				enableForceMode = true
			} else {
				enableForceMode = false
			}

			if (doorcamSettingsJson['tmpdomMode'] == "Domoticz") {
				domMode = true
			} else {
				domMode = false
			}
			
			doorcamImageURL1 = doorcamSettingsJson['camURL'];
			domoticzURL1 = doorcamSettingsJson['domURL'];
			domoticzIDX = doorcamSettingsJson['idx'];
			domoticzVAR = doorcamSettingsJson['var'];
			haURL1 = doorcamSettingsJson['haURL'];
			haEntity_id = doorcamSettingsJson['entity_id'];
			haToken = doorcamSettingsJson['token'];

		} catch(e) {
		}
		
		try {
			doorcamSettingsJson = JSON.parse(doorcamSettingsFile.read());
			if (doorcamSettingsJson['cgiMode'] == "Yes") {
				cgiMode = true
			} else {
				cgiMode = false
			}
		} catch(e) {
		}
		if (debugOutput) console.log("cgiMode:" + cgiMode)
		listProperty(screenStateController)
	}
	
	
	function getWebcamImage() {
		if(cgiMode & (pictureCycleCounter == 0 || pictureCycleCounter ==2)){
			if (debugOutput) console.log("webcam: getWebcamImage called")
			//get the url of the jpg from the cgi stream
			var http = new XMLHttpRequest();
			if (debugOutput) console.log("webcam: doorcamImageURL1: " + doorcamImageURL1)
			http.open("GET", doorcamImageURL1, true)
			
			http.onreadystatechange = function() {
				if (http.readyState == XMLHttpRequest.DONE) {
					if (http.status === 200 || http.status === 300  || http.status === 302) {
						var response = http.responseText
						if (debugOutput) console.log ("*********webcam response: " + response)
						var wbURL = doorcamImageURL1.toString()
						var n101 = wbURL.indexOf("http://") + "http://".length
						var n102 = wbURL.indexOf("/", n101)
						
						var n201 = response.indexOf("../tmpfs") + "..".length
						var n202 = response.indexOf("\"", n201)
						imageJPG = "http://" + wbURL.substring(n101, n102)  + response.substring(n201, n202)
						if (debugOutput) console.log ("*********webcam imageJPG: " + imageJPG)
						updateDoorcamImage1();
					}
				}
			}
			http.send();
		}else{
			imageJPG = doorcamImageURL1;
			updateDoorcamImage1();
		}
	}
	

	function updateDoorcamImage1() {
		if (doorcamFullScreen.visible){
			
			if (debugOutput) console.log("doorcam: updateDoorcamImage1() called")
			switch(pictureCycleCounter) {
			case 0:
				doorcamImage2Source = ""
				doorcamImage2Source = imageJPG
				pictureCycleCounter = pictureCycleCounter + 1
				break
			case 1:
				if (doorcamImage2Ready) {
					doorcamImage2Z = 100
					doorcamImage1Z = 0
					pictureCycleCounter = pictureCycleCounter + 1
					pictureCountdownCounter = pictureCountdownCounter - 1
				}
				break
			case 2:
				doorcamImage1Source = ""
				doorcamImage1Source = imageJPG
				pictureCycleCounter = pictureCycleCounter + 1
				break
			case 3:
				if (doorcamImage1Ready) {
					doorcamImage1Z = 100
					doorcamImage2Z = 0
					pictureCycleCounter = 0
					pictureCountdownCounter = pictureCountdownCounter - 1
				}
				break
			}
		}
	}

	Timer {
		id: doorcamTimer1
		interval: doorcamTimer1Interval
		triggeredOnStart: true
		running: doorcamTimer1Running
		repeat: true
		onTriggered: getWebcamImage() 
	}

	function saveSettings() {
		if (debugOutput) console.log("doorcam: saveSettings called")
		
		if (enableForceMode == true) {
			tmpForceMode = "Yes";
		} else {
			tmpForceMode = "No";
		}

		if (domMode == true) {
			tmpdomMode = "Domoticz";
		} else {
			tmpdomMode = "HA";
		}
		
		if (cgiMode == true) {
			tmpcgiMode = "Yes";
		} else {
			tmpcgiMode = "No";
		}

 		var setJson = {
			"camURL" : doorcamImageURL1,
			"domURL" : domoticzURL1,
			"idx" : domoticzIDX,
			"var" : domoticzVAR,
			"haURL" : haURL1,
			"entity_id" : haEntity_id,
			"token" : haToken,
			"tmpForceMode" : tmpForceMode,
			"tmpdomMode" : tmpdomMode,
			"cgiMode" : tmpcgiMode
		}

		if (debugOutput) console.log("doorcam: setJson: " + setJson);
		
  		var doc3 = new XMLHttpRequest();
   		doc3.open("PUT", "file:///mnt/data/tsc/doorcam_userSettings.json");
   		doc3.send(JSON.stringify(setJson));
		if (needRestart){
			console.log("*********Doorcam restart")
			rebootTimer.running = true
		}
	}
	
	Timer {
		id: rebootTimer
		interval: 2000
		repeat:false
		running: false
		triggeredOnStart: false
		onTriggered: {
			Qt.quit()
		}
	}

}

