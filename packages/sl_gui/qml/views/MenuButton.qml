import Qt 4.7

Image {
	id: menu_button
	width: 217
	height: 49
	property alias text: but_text.text
	signal clicked()
	property alias mouseAreaButton: mouseAreaButton

	Text {
		id: but_text
		anchors.horizontalCenter: parent.horizontalCenter
		color: "white"
		font.weight: Font.Bold
		font.capitalization: Font.AllUppercase
		font.pixelSize: 22
		anchors.verticalCenter: parent.verticalCenter
		anchors.verticalCenterOffset: -3
	}
	MouseArea {
		id: mouseAreaButton
		anchors.fill: parent
		hoverEnabled: true
		onEntered: { parent.state = "rollover" }
		onExited: { parent.state = "plain"  }
		onClicked: { parent.state = "clicked"
			butTimer.start()
			menu_button.clicked() }

	}
	Timer {
		id: butTimer
			interval: 100; running: false; repeat: false
			onTriggered: parent.state = "plain"
		}
	states: [
		State {
			name: "plain"
			PropertyChanges { target: menu_button; source: "image://graphics/menu_button.png" }
		},
		State {
			name: "rollover"
			PropertyChanges { target: menu_button; source: "image://graphics/menu_button_rollover.png" }
		},
		State {
			name: "clicked"
			PropertyChanges { target: menu_button; source: "image://graphics/menu_button_clicked.png" }
		}
	]
	state: "plain"

	//	transitions: [
//		Transition {

//		}
//	]
}
