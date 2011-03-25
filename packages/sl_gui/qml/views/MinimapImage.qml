import Qt 4.7

Image {
	source: ""
	width: parent.width - 20
	height: parent.height - 20
	anchors.centerIn: parent
	Behavior on opacity { PropertyAnimation{} }
}
