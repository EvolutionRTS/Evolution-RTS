import Qt 4.7
import Sasi 1.0


SubView {
	id: battleroomView
	Battleroom {
		id: battleroom
		battleId: battlelistView.battleId
	}
	anchors.fill: parent

	Column {
		id: battleroomViewCol1
		anchors.left: parent.left
		width: parent.width - 80
		spacing: 10
		anchors.top: parent.top
		height: parent.height * 0.60
		Rectangle {
			id: output_rect
			width: parent.width
			height: parent.height - input_rect.height
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
			width: parent.width
			height: 26
			radius: 5
			color: "#ffffff"
			TextInput {
				id: input
				text: "writeSTH and press enter"
				anchors.fill: parent
				anchors.margins: 5
				Keys.onReturnPressed:  {
					battleroom.say( input.text );
					input.text = "";
				}
			}
		}
	}
//	MenuButton { text:"list"; onClicked: multiplayerMenu.load(0); anchors.left: battleroomViewCol1.right}
}
