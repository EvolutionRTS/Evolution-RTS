import Qt 4.7

Item {
	width: parent.width
    height: 62

	Component {
		id: sideDelegate
		Rectangle {
			height: 40
			width: 170
			opacity: 0.6
			color: "#d4dbd3"
			radius:  5

			Image {
				id: sideImage
				width: 32
				height: 32
				source: "image://side/" + display
				anchors.verticalCenter: parent.verticalCenter
				anchors.leftMargin: 5
				anchors.left: parent.left
			}

			Text {
				id: side_name
				text: display
				font.bold: true
				font.pointSize: 12
				anchors.right: parent.right
				anchors.verticalCenter: parent.verticalCenter
				anchors.rightMargin: 5
			}
			MouseArea{
				anchors.fill: parent
				onClicked: {
					ListView.view.currentIndex = index
					}
			}
		}
	}

	ListView {
		id: slist
		orientation: "Horizontal"
		delegate: sideDelegate
		model: sideModel
		anchors.fill: parent
		highlightFollowsCurrentItem: true
		focus: true
		keyNavigationWraps :true
		anchors.margins: 10
		spacing: 5
		highlight: Rectangle { opacity: 1; radius: 5; color: "red" }
//		onCurrentIndexChanged: {
////			minimap.load( myModel.name(currentIndex) )
//		}
	}
	property alias currentIndex: slist.currentIndex
}
