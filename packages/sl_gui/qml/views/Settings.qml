import Qt 4.7
MainView {
	id: settingsView

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
		DText {
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
		delegate: GenericDelegate {
			height: 40
			width: 0.4 * parent.width
		}
		model: presetModel
		anchors.top: titleRec.bottom
		anchors.horizontalCenter: titleRec.horizontalCenter
		width: 300
		height: parent.height - titleRec.height -50
		highlightFollowsCurrentItem: true
		focus: true
		keyNavigationWraps :true
		anchors.margins: 35
		spacing: 5
		onCurrentIndexChanged: {
			presetModel.use( currentIndex )
		}
	}
	property alias currentIndex: plist.currentIndex
}
