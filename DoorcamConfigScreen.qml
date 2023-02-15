import QtQuick 2.1
import qb.components 1.0

Screen {
	id: doorcamConfigScreen
	screenTitle: "Doorcam app Setup"
	property bool	tempenableCGIMode: app.cgiMode
	property url 	tempImageUrl :app.doorcamImageURL1

	onShown: {
		doorcamImageURL1.inputText = tempImageUrl ;
		domoticzURL1.inputText = app.domoticzURL1;
		domoticzIDX.inputText= app.domoticzIDX;
		domoticzVAR.inputText= app.domoticzVAR;
		enableForceModeToggle.isSwitchedOn = app.enableForceMode;
		domhaToggle.isSwitchedOn = app.domMode;

		haURL1.inputText = app.haURL1;
		haEntity_id.inputText= app.haEntity_id;
		haToken.inputText= app.haToken;
		enableCGIMode.isSwitchedOn = tempenableCGIMode

		addCustomTopRightButton("Save");
	}

	onCustomButtonClicked: {
		if (app.cgiMode != tempenableCGIMode || app.doorcamImageURL1 != tempImageUrl) app.needRestart = true 
		app.cgiMode = tempenableCGIMode;
		app.doorcamImageURL1 = tempImageUrl;
		if (app.needRestart){
			addCustomTopRightButton("Wait for reboot");
		}
		app.saveSettings();
		if (!app.needRestart){
			hide()
		}
	}


	function savedoorcamImageURL1(text) {
		if (text) {
			tempImageUrl = text;
		}
	}

	function savedomoticzURL1(text) {
		if (text) {
			app.domoticzURL1 = text;
		}
	}

	function savedomoticzIDX(text) {
		if (text) {
			app.domoticzIDX = text;
		}
	}

	function savedomoticzVAR(text) {
		if (text) {
			app.domoticzVAR = text;
		}
	}

	function savehaURL1(text) {
		if (text) {
			app.haURL1 = text;
		}
	}

	function savehaEntity_id(text) {
		if (text) {
			app.haEntity_id = text;
		}
	}

	function savehaToken(text) {
		if (text) {
			app.haToken = text;
		}
	}


	EditTextLabel4421 {
		id: doorcamImageURL1
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 300
		leftText: "URL doorcam image"

		anchors {
			left: parent.left
			top: parent.top
			leftMargin: 20
			topMargin: isNxt ? 8 : 6
		}

		onClicked: {
			qkeyboard.open("URL", doorcamImageURL1.inputText, savedoorcamImageURL1)
		}
	}

	Text {
		id: myLabel
		text: "Example of valid JPG URL: http://192.168.42.8/live/1/jpeg.jpg"
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18:14
		}
		anchors {
			left: parent.left
			top: doorcamImageURL1.bottom
			leftMargin: 20
			rightMargin: 20
			topMargin: isNxt ? 8 : 6
			bottomMargin: 20
		}
	}
	
	Text {
		id: myLabel2
		text: "Example of valid CGI URL: http://192.168.1.6/cgi-bin/hi3510/param.cgi?cmd=snap&-getpic"
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18:14
		}
		anchors {
			left: parent.left
			top: myLabel.bottom
			leftMargin: 20
			rightMargin: 20
			topMargin: isNxt ? 8 : 6
			bottomMargin: 20
		}
	}
	Text {
		id: cgiModeTXT
		width:  160
		text: "JPG Mode"
		font.family: qfont.regular.name
		font.pixelSize: isNxt ? 18:14
		anchors {
			left: myLabel.left
			top:myLabel2.bottom
			topMargin: isNxt ? 8 : 6
		}
	}

	OnOffToggle {
		id: enableCGIMode
		height:  30
		leftIsSwitchedOn: false
		anchors {
			left: cgiModeTXT.right
			leftMargin: isNxt ? 60 : 48
			top: cgiModeTXT.top		
		}
		onSelectedChangedByUser: {
			if (isSwitchedOn) {
				tempenableCGIMode = true;
			} else {
				tempenableCGIMode = false;		
			}
		}
	}

	Text {
		id: jpgModeTXT
		width:  160
		text: "CGI Mode (hi3510 camera)"
		font.family: qfont.regular.name
		font.pixelSize: isNxt ? 18:14
		anchors {
			left: enableCGIMode.right
			leftMargin: isNxt ? 65 : 25
			top: cgiModeTXT.top		
		}
	}
	Text {
		id: domhaMode
		width:  160
		text: "HA - Domoticz"
		font.pixelSize: isNxt ? 18:14
		font.family: qfont.regular.name

		anchors {
			left: parent.left
			top: cgiModeTXT.bottom
			leftMargin: 20
			topMargin: isNxt ? 20 : 16
		}
	}

	OnOffToggle {
		id: domhaToggle
		height:  30
		anchors.left: forceMode.right
		anchors.leftMargin: isNxt ? 65 : 30
		anchors.top: domhaMode.top
		leftIsSwitchedOn: false
		onSelectedChangedByUser: {
			if (isSwitchedOn) {
				app.domMode = true;
			} else {
				app.domMode = false;
			}
		}
	}


	Text {
		id: myLabel5
		text: "Example of valid URL: http://192.168.10.185:8080 :"
		font.pixelSize: isNxt ? 18:14
		font.family: qfont.regular.name
		anchors {
			left: parent.left
			top: domhaToggle.bottom
			leftMargin: 20
			topMargin: isNxt ? 8 : 6
		}
		visible: app.domMode
	}


	EditTextLabel4421 {
		id: domoticzURL1
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 300
		leftText: "URL to Domoticz"

		anchors {
			left: parent.left
			top: myLabel5.bottom
			leftMargin: 20
			topMargin: isNxt ? 8 : 6
		}

		onClicked: {
			qkeyboard.open("URL", domoticzURL1.inputText, savedomoticzURL1)
		}
		visible: app.domMode
	}

	Text {
		id: myLabel6
		text: "IDX of the doorbell variable in Domoticz created by script. Example : 27"
		font.pixelSize: isNxt ? 18:14
		font.family: qfont.regular.name
		anchors {
			left: parent.left
			top: domoticzURL1.bottom
			leftMargin: 20
			topMargin: isNxt ? 8 : 6
		}
		visible: app.domMode
	}

	EditTextLabel4421 {
		id: domoticzIDX
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 300
		leftText: "IDX of trigger parameter"
		anchors {
			left: parent.left
			top: myLabel6.bottom
			leftMargin: 20
			topMargin: isNxt ? 8 : 6
		}

		onClicked: {
			qkeyboard.open("IDX", domoticzIDX.inputText, savedomoticzIDX)
		}
		visible: app.domMode
	}

	Text {
		id: myLabel8
		text: "Name of Domoticz variable. Example of valid name:  ShowDoorCamToon "
		font.pixelSize: isNxt ? 18:14
		font.family: qfont.regular.name
		anchors {
			left: parent.left
			top: domoticzIDX.bottom
			leftMargin: 20
			topMargin: isNxt ? 8 : 6
		}
		visible: app.domMode
	}

	EditTextLabel4421 {
		id: domoticzVAR
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 300
		leftText: "Name of trigger parameter"
		anchors {
			left: parent.left
			top: myLabel8.bottom
			leftMargin: 20
			topMargin: isNxt ? 8 : 6
		}

		onClicked: {
			qkeyboard.open("Var", domoticzVAR.inputText, savedomoticzVAR)
		}
		visible: app.domMode
	}

	Text {
		id: myLabel9
		text: "Example of valid URL: http://192.168.10.185:8123 :"
		font.pixelSize: isNxt ? 18:14
		font.family: qfont.regular.name
		anchors {
			left: parent.left
			top: domhaToggle.bottom
			leftMargin: 20
			topMargin: isNxt ? 8 : 6
		}
		visible: !app.domMode
	}


	EditTextLabel4421 {
		id: haURL1
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 100
		leftText: "HA URL"
		anchors {
			left: parent.left
			top: myLabel9.bottom
			leftMargin: 20
			topMargin: isNxt ? 8 : 6
		}
		onClicked: {
			qkeyboard.open("URL", haURL1.inputText, savehaURL1)
		}
		visible: !app.domMode
	}

	Text {
		id: myLabel11
		text: "Helper Entity_id in Home Assistant. Example : input_number.showdoorcamtoon :"
		font.pixelSize: isNxt ? 18:14
		font.family: qfont.regular.name
		anchors {
			left: parent.left
			top: haURL1.bottom
			leftMargin: 20
			topMargin: isNxt ? 8 : 6
		}
		visible: !app.domMode
	}

	EditTextLabel4421 {
		id: haEntity_id
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 100
		leftText: "Entity_id"
		anchors {
			left: parent.left
			top: myLabel11.bottom
			leftMargin: 20
			topMargin: isNxt ? 8 : 6
		}

		onClicked: {
			qkeyboard.open("Entity_id", haEntity_id.inputText, savehaEntity_id)
		}
		visible: !app.domMode
	}

	Text {
		id: myLabel13
		text: "Home Assistant long-lived access token :"
		font.pixelSize: isNxt ? 18:14
		font.family: qfont.regular.name
		anchors {
			left: parent.left
			top: haEntity_id.bottom
			leftMargin: 20
			topMargin: isNxt ? 8 : 6
		}
		visible: !app.domMode
	}

	EditTextLabel4421 {
		id: haToken
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 100
		leftText: "Token"
		anchors {
			left: parent.left
			top: myLabel13.bottom
			leftMargin: 20
			topMargin: isNxt ? 8 : 6
		}

		onClicked: {
			qkeyboard.open("Token", haToken.inputText, savehaToken)
		}
		visible: !app.domMode
	}

	Text {
		id: forceMode
		width:  160
		text: "force 16:9"
		font.pixelSize: isNxt ? 18:14
		font.family: qfont.regular.name

		anchors {
			left: parent.left
			top: domoticzVAR.bottom
			leftMargin: 20
			topMargin: isNxt ? 10 : 8
		}
	}

	OnOffToggle {
		id: enableForceModeToggle
		height:  30
		anchors.left: forceMode.right
		anchors.leftMargin: isNxt ? 65 : 30
		anchors.top: forceMode.top
		leftIsSwitchedOn: false
		onSelectedChangedByUser: {
			if (isSwitchedOn) {
				app.enableForceMode = true;
			} else {
				app.enableForceMode = false;
			}
		}
	}

}
