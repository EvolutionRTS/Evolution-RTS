import Qt 4.7

MainView {
	id: battlelistView

        Component {
            id: battleDelegate
            Rectangle {
                height: 40
                width: parent.width -20
                color: "#d4dbd3"
                radius:  5
                DText {
                        id: battleText
                        text: display
                        font.bold: true
                        font.pointSize: 12
                        anchors.centerIn: parent
                        anchors.rightMargin: 5
                }
//                MouseArea{
//                        anchors.fill: parent
//                        onClicked: {
//                                ListView.view.currentIndex = index
//                        }
//                }
            }
        }
	ListView {
                id: battleList
                delegate: battleDelegate
                model: battlelistModel
		anchors.left:  parent.left
		anchors.top: parent.top
		width: parent.width - 40
		height:  parent.height - 15
		anchors.horizontalCenter: parent.horizontalCenter
		highlightFollowsCurrentItem: true
                focus: true
		keyNavigationWraps :true
		anchors.leftMargin: 10
		anchors.topMargin: 30
		spacing: 5
//		onCurrentIndexChanged: {
////			minimap.load( skirmishModel.name(currentIndex) )
//		}
                Rectangle {
                        anchors.fill: parent
                        color: "black"
                        opacity: 0.1
                        radius: 10
                }
	}

}
