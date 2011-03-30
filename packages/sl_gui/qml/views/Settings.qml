import Qt 4.7
Item {
	id: settingsView
	width: parent.width - 24
	height: parent.height - 24
	anchors.horizontalCenter: parent.horizontalCenter
	Component {
		id: presetDelegate
		Rectangle {
			anchors.horizontalCenterOffset: ListView.isCurrentItem ? 10 : 0
			anchors.horizontalCenter: parent.horizontalCenter
			id: presetDelegate
			height: 40
			width: 0.4 * parent.width
			property bool isCurrent: ListView.isCurrentItem
			opacity: isCurrent ? 1.0 : 0.8
			Behavior on opacity {
				PropertyAnimation{}
			}

			color: "#0a92d5"; radius: 4
			gradient: Gradient {
				GradientStop {
					position: 0.00;
					color: "#0a92d5";
				}
				GradientStop {
					position: 1.00;
					color: "#0e7fb3";
				}
			}
			scale: activeFocus ? 1.0 : 0.95
			Text {
				id: mapname
				anchors.fill: parent
				anchors.centerIn: parent
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment:Text.AlignVCenter
				text: display
				font.bold: true
				font.pointSize: 14
				color: "white"
				smooth: true
			}
			MouseArea{
				anchors.fill: parent
				onClicked: {
					ListView.view.currentIndex = index
					}
			}
			Behavior on anchors.horizontalCenterOffset {
				PropertyAnimation{ easing.type: Easing.Linear; duration: 300 }
			}
			Behavior on scale {
				PropertyAnimation{ easing.type: Easing.Linear; duration: 300 }
			}
		}
	}

	Rectangle {
		color: "#000000"
		border.color: "#ffffff"
		radius: 10
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.margins: 15
		id: titleRec
		width: parent.width * 0.8
		height:  42
		Text {
			id: title
			anchors.fill: parent
			anchors.centerIn: parent
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment:Text.AlignVCenter
			text: "Select settings preset"
			font.bold: true
			font.pointSize: 20
			color: "white"
			smooth: true
		}
	}

	ListView {
		id: plist
		delegate: presetDelegate
		model: presetModel
		anchors.top: titleRec.bottom
		anchors.horizontalCenter: titleRec.horizontalCenter
//		anchors.fill: parent
		width: 300
		height: parent.height - titleRec.height -50
		highlightFollowsCurrentItem: true
		focus: true
		keyNavigationWraps :true
		anchors.margins: 35
		spacing: 5
		onCurrentIndexChanged: {
//			minimap.load( maplistModel.name(currentIndex) )
		}
	}

	states: [
		State {
			name: "Offscreen"
			PropertyChanges { target: settingsView; 	anchors.topMargin:  4000 }
			AnchorChanges { target: settingsView; anchors {top: mainContainer.bottom } }

		},
		State {
			name: "Onscreen"
			AnchorChanges { target: settingsView; anchors {top: mainContainer.top } }
			PropertyChanges { target: settingsView; 	anchors.topMargin:  12 }
		}
	]
	transitions: [
		Transition {
			AnchorAnimation{  easing.type: Easing.InOutQuad; duration: 1000  }
		}
	]
	state:  "Offscreen"

	property alias currentIndex: plist.currentIndex
}
