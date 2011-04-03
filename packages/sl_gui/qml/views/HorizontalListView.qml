import QtQuick 1.0

Item {
	Image {
		source: "image://graphics/back.png"
		id: backImg
		anchors.right: listViewId.left
		anchors.margins: 5
		anchors.verticalCenter: listViewId.verticalCenter
		MouseArea{
			anchors.fill: parent
			onClicked: {
				listViewId.currentIndex -= listViewId.currentIndex > 0 ? 1 : 0
			}
		}
	}

	ListView {
		id: listViewId
		orientation: "Horizontal"
		width: parent.width - backImg.width - forwardImg.width- 16
		height: 48
		anchors.horizontalCenter: parent.horizontalCenter
		highlightFollowsCurrentItem: true
		focus: true
		keyNavigationWraps :false
		anchors.margins: 10
		spacing: 5
		highlight: GenericDelegate { text:""  }
		clip: true
	}

	Image {
		source: "image://graphics/forward.png"
		id: forwardImg
		anchors.left: listViewId.right
		anchors.margins: 5
		anchors.verticalCenter: listViewId.verticalCenter
		MouseArea{
			anchors.fill: parent
			onClicked: {
				listViewId.currentIndex += listViewId.currentIndex < listViewId.count - 1 ? 1 : 0
			}
		}
	}
	property alias delegate: listViewId.delegate
	property alias model: listViewId.model
	property alias currentIndex: listViewId.currentIndex

	anchors.horizontalCenter: parent.horizontalCenter
	width: parent.width
	height: 50
}
