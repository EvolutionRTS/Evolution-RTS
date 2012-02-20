import Qt 4.7

Item {
    width: 100
	height: 35

	property int max_width
	property int max_height
	property double active_opacity: 0.6

	Rectangle {
		id: bgRect
		anchors.centerIn: parent
		radius: 5
		opacity: 0.6
		anchors.fill: parent
		MouseArea{
			anchors.fill: parent
			onClicked: {
                skirmishList.currentIndex = index
			}
		}
	}

	DText {
		id: name
		text:  skirmish_name
		color: "black"
		anchors.centerIn: parent
	}

	Item {
		id: mehID
		y: (index) * -(parent.height +4) - 20
		x: bgRect.x + 100

		width: parent.max_width
		height: 444//parent.max_height
		Rectangle {
			color: "white"
			opacity: 0.6
			anchors.fill: parent
			radius: 5
		}
		DText {
			text:  description
			anchors.margins: 15
			anchors.fill: parent
		}
		clip: true
		Item {
			id: startButton
			width: 80
			height: 30
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.bottom: parent.bottom
			anchors.margins: 10
			Rectangle {
				color: "#00c4ff"
				anchors.fill: parent
				radius: 5
				border.color: "#110101"
				DText{
					text: "Play"
					font.pointSize: 12
					anchors.centerIn: parent
				}
				MouseArea{
					anchors.fill: parent
					onClicked: {
						skirmishView.run()
					}
				}
			}
		}
		SideList {
			id: sideList
			anchors.bottom: startButton.top
			anchors.margins: 10
		}
	}


	states: [
		State {
			name: "active"
			PropertyChanges { target: mehID; 	width:  max_width }
			PropertyChanges { target: bgRect; 	color:  "white" }
			PropertyChanges { target: bgRect; 	opacity:  active_opacity }

		},
		State {
			name: "inactive"
			PropertyChanges { target: mehID; 	width:  0 }
			PropertyChanges { target: bgRect; 	color:  "purple" }
			PropertyChanges { target: bgRect; 	opacity:  active_opacity / 3.0  }
		}
	]
	transitions: [
		Transition {
			ParallelAnimation {
				PropertyAnimation{ easing.type: Easing.InOutQuad; duration: 200; exclude: mehID }
				ColorAnimation { duration: 200 }
			}
		}
	]
	state: ListView.isCurrentItem ? "active" : "inactive"

	property alias current_side: sideList.currentIndex

}
