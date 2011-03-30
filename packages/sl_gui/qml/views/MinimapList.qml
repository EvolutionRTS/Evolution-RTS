import Qt 4.7
Item {
	Component {
		id: mapDelegate
		Rectangle {
			anchors.horizontalCenterOffset: ListView.isCurrentItem ?  10 : 0
			anchors.horizontalCenter: parent.horizontalCenter
			id: albumDelegateRec
			height: 30
			width: parent.width
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

	Minimap {
		id: minimap
		anchors.margins: 10
		anchors.left: parent.left
		anchors.top: parent.top
		width: 276
		height: 276
	}

	ListView {
		id: list
		delegate: mapDelegate
		model: maplistModel
		anchors.left:  minimap.left
		anchors.top: minimap.bottom
		width: parent.width -25
		height:  parent.height - minimap.height - 15
		anchors.horizontalCenter: minimap.horizontalCenter
		highlightFollowsCurrentItem: true
		focus: true
		keyNavigationWraps :true
		anchors.margins: 10
		spacing: 5
		onCurrentIndexChanged: {
			minimap.load( maplistModel.name(currentIndex) )
		}
	}

	property alias currentIndex: list.currentIndex
}
