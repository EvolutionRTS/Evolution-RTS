import Qt 4.7

Item {
	id: skirmishView
	width: parent.width - 24
	height: parent.height - 24
	anchors.horizontalCenter: parent.horizontalCenter

	ListView {
		id: skirmishList
		delegate: SkirmishDelegate{
			max_width: parent.width - minimapList.width - width
			max_height: height
		}
		model: skirmishModel
		anchors.left:  parent.left
		anchors.top: parent.top
		width: parent.width - 350
		height:  parent.height - 15
		anchors.horizontalCenter: parent.horizontalCenter
		highlightFollowsCurrentItem: true
		focus: false
		keyNavigationWraps :true
		anchors.leftMargin: 10
		anchors.topMargin: 30
		spacing: 5
		onCurrentIndexChanged: {
//			minimap.load( skirmishModel.name(currentIndex) )
		}
	}
	MinimapList {
		id: minimapList
		width:  350
		anchors.right: parent.right
		anchors.margins: 10

		height: parent.height
		focus: true
		opacity: 1
	}

	function run(  )
	{
		skirmishModel.run( skirmishList.currentIndex, skirmishList.currentItem.current_side, minimapList.currentIndex )
	}

	states: [
		State {
			name: "Offscreen"
			PropertyChanges { target: skirmishView; 	anchors.topMargin:  4000 }
			AnchorChanges { target: skirmishView; anchors {top: mainContainer.bottom } }

		},
		State {
			name: "Onscreen"
			AnchorChanges { target: skirmishView; anchors {top: mainContainer.top } }
			PropertyChanges { target: skirmishView; 	anchors.topMargin:  12 }
		}
	]
	transitions: [
		Transition {
			AnchorAnimation{  easing.type: Easing.InOutQuad; duration: 1000  }
		}
	]
	state:  "Offscreen"
}
