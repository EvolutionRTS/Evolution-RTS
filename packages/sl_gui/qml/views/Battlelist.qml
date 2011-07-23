import Qt 4.7

MainView {
	id: battlelistView

        Component {
            id: battleDelegate
            Rectangle {
                id: battleBG
                height: 140
                width: 600
                anchors.margins: 15
                color: "#d4dbd3"
                radius:  5
                DText {
                        id: battleText
                        width: parent.width -120
                        text: "<b>Host:</b> " + founder + "<br/>" + description + "<br/>" + "Players: " + playerCurrent + " ( " + playerMax + " max )"
                        font.bold: false
                        font.pointSize: 12
                        anchors.margins: 10
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                }
                Rectangle {
                        color: "black"
                        radius: 5
                        opacity: 0.4
                        width: 120
                        height: 120
                        anchors.right: battleBG.right
                        anchors.margins: 10
                        anchors.verticalCenter: parent.verticalCenter
                        MinimapImage {
                            source: "image://minimaps/" + mapname
                        }
                }
                MouseArea{
                        anchors.fill: parent
                        onClicked: {
                                ListView.view.currentIndex = index
                        }
                }
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
                spacing: 10
	}

}
