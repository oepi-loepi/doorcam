//
// Onkyo app by Oepi-Loepi
//

import QtQuick 2.1
import BasicUIControls 1.0
import qb.components 1.0

Tile {
	id: onkyoTile

	property bool dimState: screenStateController.dimmedColors

	
	Rectangle {
     		id: simplebutton
     		color: "grey"
     		width: 220; height: 20
		radius: 4
     		Text{
         		id: buttonLabel
         		anchors.centerIn: parent
         		text: "POWER ON"
     		}

		anchors {
			top: parent.top
			topMargin: 2
			horizontalCenter: parent.horizontalCenter	 		
		}

    		MouseArea{
         		id: buttonMouseArea
         		anchors.fill: parent 
         		onClicked: {app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=PWR01");}
     		}
    		visible: !dimState && !app.actPower
	}

	Rectangle {
     		id: simplebutton2
     		color: "grey"
     		width: 220; height: 20
		radius: 4
     		Text{
         		id: buttonLabel2
         		anchors.centerIn: parent
         		text: "POWER OFF"
     		}
		anchors {
			top: parent.top
			topMargin: 2
			horizontalCenter: parent.horizontalCenter		
		}

    		MouseArea{
         		id: buttonMouseArea2
         		anchors.fill: parent 
         		onClicked: {app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=PWR00");}
     		}
    		visible: !dimState&&app.actPower
	}

	Rectangle {
     		id: simplebutton3
     		color: "blue"
     		width: 53; height: 42 
		radius: 4    		
		Text{
         		id: buttonLabel3
         		anchors.centerIn: parent
         		text: "RADIO"
     		}
		anchors {
			top: simplebutton2.bottom
			topMargin: 3
			left: parent.left
			leftMargin:  5 		
		}

    		MouseArea{
         		id: buttonMouseArea3
         		anchors.fill: parent 
         		onClicked: {app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=SLI24");app.showButtons=false;app.actRadio=true}
     		}
    		visible: !dimState && app.actPower && app.showButtons
	}

	Rectangle {
     		id: simplebutton4
     		color: "green"
     		width: 53; height: 42 
		radius: 4    		     		
		Text{
         		id: buttonLabel4
         		anchors.centerIn: parent
         		text: "TV"
     		}
		anchors {
			top: simplebutton2.bottom
			topMargin: 3
			left: simplebutton3.right
			leftMargin:  2 		
		}

    		MouseArea{
         		id: buttonMouseArea4
         		anchors.fill: parent 
         		onClicked: {app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=SLI12");app.showButtons=false}
     		}
    		visible: !dimState  && app.actPower && app.showButtons

	}

	Rectangle {
     		id: simplebutton5
     		color: "magenta"
     		width: 53; height: 42 
		radius: 4    		     		
		Text{
         		id: buttonLabel5
         		anchors.centerIn: parent
         		text: "NET"
     		}
		anchors {
			top: simplebutton2.bottom
			topMargin: 3
			left: simplebutton4.right
			leftMargin:  2 		
		}

    		MouseArea{
         		id: buttonMouseArea5
         		anchors.fill: parent 
         		onClicked: {app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=SLI2b");app.showButtons=false}
     		}
    		visible: !dimState  && app.actPower && app.showButtons
	}

	Rectangle {
     		id: simplebutton6
     		color: "cyan"
     		width: 53; height: 42 
		radius: 4    		     		
		Text{
         		id: buttonLabel6
         		anchors.centerIn: parent
         		text: "BT"
     		}
		anchors {
			top: simplebutton2.bottom
			topMargin: 3
			left: simplebutton5.right
			leftMargin:  2 		
		}

    		MouseArea{
         		id: buttonMouseArea6
         		anchors.fill: parent 
         		onClicked: {app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=SLI2e");app.showButtons=false}
     		}
    		visible: !dimState  && app.actPower && app.showButtons
	}

	Rectangle {
     		id: simplebutton61
     		color: "grey"
     		width: 53; height: 42 
		radius: 4    		     		
		Text{
         		id: buttonLabel61
         		anchors.centerIn: parent
         		text: "<>"
     		}
		anchors {
			top: simplebutton2.bottom
			topMargin: 3
			left: simplebutton5.right
			leftMargin:  2 		
		}

    		MouseArea{
         		id: buttonMouseArea61
         		anchors.fill: parent 
         		onClicked: {app.showButtons = true;}
     		}
    		visible: !dimState  && app.actPower && !app.showButtons
	}


	Rectangle {
     		id: simplebutton7
     		color: "grey"
     		width: 53; height: 42 
		radius: 4    		     		
		Text{
         		id: buttonLabel7
         		anchors.centerIn: parent
         		text: app.radioStation1
     		}
		anchors {
			top: simplebutton3.bottom
			topMargin: 3
			left: parent.left
			leftMargin:  5		
		}

    		MouseArea{
         		id: buttonMouseArea7
         		anchors.fill: parent 
         		onClicked: {app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=PRS03");}
     		}
    		visible: !dimState && !app.actSelector && app.actPower && app.actRadio 
	}

	Rectangle {
     		id: simplebutton8
     		color: "grey"
     		width: 53; height: 42 
		radius: 4    		     		
		Text{
         		id: buttonLabel8
         		anchors.centerIn: parent
         		text: app.radioStation2
     		}
		anchors {
			top: simplebutton3.bottom
			topMargin: 3
			left: simplebutton7.right
			leftMargin:  2 		
		}

    		MouseArea{
         		id: buttonMouseArea8
         		anchors.fill: parent 
         		onClicked: {app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=PRS04");}
     		}
    		visible: !dimState && !app.actSelector && app.actPower && app.actRadio 
	}

	Rectangle {
     		id: simplebutton9
     		color: "grey"
     		width: 53; height: 42 
		radius: 4    		     		
		Text{
         		id: buttonLabel9
         		anchors.centerIn: parent
         		text: app.radioStation3
     		}
		anchors {
			top: simplebutton3.bottom
			topMargin: 3
			left: simplebutton8.right
			leftMargin:  2 		
		}

    		MouseArea{
         		id: buttonMouseArea9
         		anchors.fill: parent 
         		onClicked: {app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=PRS06");}
     		}
    		visible: !dimState && !app.actSelector && app.actPower && app.actRadio

	}

	Rectangle {
     		id: simplebutton10
     		color: "grey"
     		width: 53; height: 42 
		radius: 4    		     		
		Text{
         		id: buttonLabel10
         		anchors.centerIn: parent
         		text: app.radioStation4
     		}
		anchors {
			top: simplebutton3.bottom
			topMargin: 3
			left: simplebutton9.right
			leftMargin:  2 		
		}

    		MouseArea{
         		id: buttonMouseArea10
         		anchors.fill: parent 
         		onClicked: {app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=PRS08");}
     		}
    		visible: !dimState && !app.actSelector && app.actPower && app.actRadio
	}

	Rectangle {
     		id: itemText
     		color: "transparent"
     		width: 160; height: 42     		
		Text{
         		id: iText
         		width: parent.width
			font.pixelSize: app.actualArtistLong||!dimState? 12 : 22
			wrapMode: Text.WordWrap
         		text: app.actualArtist
			font.family: qfont.regular.name
			font.bold: true
			color: !dimState? "black" : "white"
     		}
		anchors {
			top: app.showButtons? simplebutton6.bottom : simplebutton.bottom
			topMargin: 3
			left: parent.left
			leftMargin:  2		
		}
    		visible: app.actSelector && app.actPower && !app.showButtons && (app.enableSleep||!dimState)

	}

	Rectangle {
     		id: titleText
     		color: "transparent"
     		width: 160; height: 42     		
		Text{
         		id: tText
         		width: parent.width
			font.pixelSize: app.actualTitleLong||!dimState? 12 : 22
			wrapMode: Text.WordWrap
         		text: app.actualTitle
			font.family: qfont.regular.name
			font.bold: true
			color: !dimState? "black" : "white"
     		}
		anchors {
			top: itemText.bottom
			topMargin: 2
			left: parent.left
			leftMargin:  2		
		}
    		visible: app.actSelector && app.actPower && !app.showButtons && (app.enableSleep||!dimState)
	}

	Text {
		id:timeText

		text: app.actualPlaytime
		font.pixelSize:  12
		font.family: qfont.regular.name
		font.bold: false
		color: colors.clockTileColor
		wrapMode: Text.WordWrap
		anchors {
			right: parent.right
			rightMargin: 2
			bottom: parent.bottom
			bottomMargin: 1
		}
		visible:  app.actSelector && dimState && app.actPower && (app.enableSleep||!dimState)
	}

	//volume control session start here, first you'll find the first button.
	IconButton {
		id: volumeDown
		anchors {
			bottom: parent.bottom
			bottomMargin: 5
			left: parent.left
			leftMargin:  2 		
		}

		iconSource: "qrc:/tsc/volume_down_small.png"
		onClicked: {
			app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=MVLDOWN1");
		}
		visible: !dimState && app.actPower
	}

	IconButton {
		id: prevButton
		anchors {
			left: volumeDown.right
			leftMargin:  2 
			bottom: parent.bottom
			bottomMargin: 5
		}

		iconSource: "qrc:/tsc/left.png"
		onClicked: {
			app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=NTCTRDN");
		}
		visible:  !dimState && app.actSelector && app.actPower	
	}

	IconButton {
		id: playButton
		anchors {
			left: prevButton.right
			leftMargin:  2 
			bottom: parent.bottom
			bottomMargin: 5
		}

		iconSource: "qrc:/tsc/play.png"
		onClicked: {
			app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=NTCPAUSE");
		}
		visible: !dimState && app.actSelector && app.actPower	
	}

	IconButton {
		id: shuffleOnButton
		anchors {
			left: playButton.right
			leftMargin:  2 
			bottom: parent.bottom
			bottomMargin: 5
		}

		iconSource: "qrc:/tsc/shuffle.png"
		onClicked: {
			app.shuffleButtonVisible = false;
			app.shuffleOnButtonVisible = false;
			app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=NTCRANDOM");
		}
		visible: !dimState && app.actSelector && app.actPower		
	}
		
	IconButton {
		id: nextButton
		anchors {
			left: shuffleOnButton.right
			leftMargin:  2 
			bottom: parent.bottom
			bottomMargin: 5

		}

		iconSource: "qrc:/tsc/right.png"
		onClicked: {
			app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=NTCTRUP");
		}
		visible: !dimState && app.actSelector && app.actPower	
	}	
	
	IconButton {
		id: volumeUp
		anchors {
			left: nextButton.right
			leftMargin: 2
			bottom: parent.bottom
			bottomMargin: 5
		}

		iconSource: "qrc:/tsc/volume_up_small.png"
		onClicked: {
			app.simpleSynchronous(app.domoticzURL1 + "/json.htm?type=command&param=onkyoeiscpcommand&idx=" + app.idxCOM +"&action=MVLUP1");		
		}
		visible: !dimState && app.actPower
	}

	Rectangle {
     		id: simplebutton11
     		color: "grey"
     		width: 50; height: 20 
		radius: 4    		     		
		Text{
         		id: buttonLabel11
         		anchors.centerIn: parent
         		text: "Setup"
     		}
		anchors {
			//left: nextButton.left
			//left: volumeUp.left
			right:parent.right
			rightMargin: 2

			bottom: parent.bottom
			bottomMargin: 5
		}

    		MouseArea{
         		id: buttonMouseArea11
         		anchors.fill: parent 
         		onClicked: {app.onkyoConfigScreen.show();}
     		}
    		visible: !dimState  && !app.actPower

	}

}
