import QtQuick 1.0

import "sprintf.js" as Util

Item {
	id: battleDelegate
	property int current_battleId: battleId
	Rectangle {

		id: battleBG
		height: 140
		width: 600
		anchors.margins: 15
		color: ListView.isCurrentItem ? "red" : "#d4dbd3"
		radius:  5
		DText {
			id: battleText
			width: parent.width -120
			text: Util.sprintf("<b>Host:</b> %s<br/>%s<br/><b>Players:</b> %d (%d max)", founder, description, playerCurrent, playerMax);
			font.bold: false
			font.pointSize: 12
			anchors.margins: 10
			anchors.left: parent.left
			anchors.verticalCenter: parent.verticalCenter
		}
		Rectangle {
			color: "black"
			radius: 5
			opacity: 0.4
			width: 120
			height: 120
			anchors.right: battleBG.right
			anchors.margins: 10
			anchors.verticalCenter: parent.verticalCenter
			MinimapImage {
				source: "image://minimaps/" + mapname
			}
		}
		MouseArea{
			anchors.fill: parent
			onClicked: {
				ListView.view.currentIndex = index;
			}
		}
	}
}
