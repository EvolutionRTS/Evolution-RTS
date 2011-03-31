import QtQuick 1.0

Image {
	id: sideImage
	width: 32
	height: 32
	sourceSize.width: 32
	sourceSize.height: 32
	source: "image://sides/" + side
	anchors.verticalCenter: parent.verticalCenter
	anchors.leftMargin: 5
	anchors.left: parent.left
	property string side
}
