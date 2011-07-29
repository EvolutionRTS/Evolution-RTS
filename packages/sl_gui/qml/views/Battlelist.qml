import Qt 4.7
import Sasi 1.0

SubView {
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

	property int battleId: battleList.currentItem ? battleList.currentItem.current_battleId : -1

}
