import Qt 4.7
Item {
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
		delegate: GenericDelegate {
			height: 30
			width: list.width
			font_bold:  false
			font_size: 12
		}
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
