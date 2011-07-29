import QtQuick 1.0

import "sprintf.js" as Util

Item {
	id: battleDelegate
	property int current_battleId: battleId
	property bool isCurrent: ListView.isCurrentItem
	property int height_offset: isCurrent ? 40 : 0
	Rectangle {
		id: battleBG
		height: height_offset + 100
		width: 600
//		y: parent.y + height_offset
		anchors.margins: 15
		color: isCurrent ? "#F59E00" : "#d4dbd3"
		radius:  5
		Behavior on height { PropertyAnimation{} }
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
			opacity: isCurrent ? 0.4 : 0.0
			width: 120
			height: isCurrent ? 120 : 0
			anchors.right: battleBG.right
			anchors.margins: 10
			anchors.verticalCenter: parent.verticalCenter
			MinimapImage {
				source: "image://minimaps/" + mapname
			}
			Behavior on opacity { PropertyAnimation{} }
		}
		MouseArea{
			anchors.fill: parent
			onClicked: {
				ListView.view.currentIndex = index;
			}
		}
	}
}
