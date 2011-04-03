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

			Sidepic {
				side: display
			}

			DText {
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

	HorizontalListView {
		delegate: sideDelegate
		model: sideModel
		id: listID
	}

	property alias currentIndex: listID.currentIndex
}
