import QtQuick 1.0

Rectangle {
	color: "#000000"
	border.color: "#ffffff"
	radius: 10
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.margins: 15

	width: parent.width * 0.8
	height:  42
	DText {
		id: title
		anchors.fill: parent
		anchors.centerIn: parent
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment:Text.AlignVCenter
		font.bold: true
		font.pointSize: 20
		color: "white"
		smooth: true
	}

	property alias text: title.text
}
