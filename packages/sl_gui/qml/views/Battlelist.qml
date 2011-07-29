import Qt 4.7
import Sasi 1.0

MainView {
	id: battlelistView

	ListView {
		id: battleList
		delegate: BattleListDelegate{}
		model: battlelistModel
		anchors.left:  parent.left
		anchors.top: parent.top
		width: parent.width - 40
		height:  parent.height - 150
		anchors.horizontalCenter: parent.horizontalCenter
		highlightFollowsCurrentItem: true
		focus: true
		keyNavigationWraps :true
		anchors.leftMargin: 10
//		anchors.topMargin: 30
		spacing: 150
	}

	Item {
		id: battleroomContainer
		Battleroom {
			id: battleroom
			battleId: battleList.currentItem ? battleList.currentItem.current_battleId : -1
		}
		width:parent.width
		height: 120

		Rectangle {
			id: output_rect
			anchors.top: parent.top
			width: parent.width
			height: parent.height - 40
			color: "#ffffff"
			radius: 5
			TextEdit {
				id: output
				anchors.fill: parent
				anchors.margins: 5
				text: battleroom.chatText
	  //		  wrapMode: "WordWrap"
			}
		}
		Rectangle {
			id: input_rect
			anchors.top: output_rect.bottom
			width: parent.width - 80
			height: 26
			radius: 5
			anchors.topMargin: 10
			color: "#ffffff"
			TextInput {
				id: input
				text: "writeSTH and press enter"
				anchors.fill: parent
				anchors.margins: 5
				Keys.onReturnPressed:  {
//					output.text = output.text + "\n" + input.text;
					battleroom.say( input.text );
					input.text = "";
				}
			}
		}

		anchors.top: battleList.bottom
//		onBattleIdChanged: {
//			console.log( battleId );
//		}
	}
}
