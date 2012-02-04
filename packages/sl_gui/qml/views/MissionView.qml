import Qt 4.7

MainView {
    anchors.fill: parent
    id: missionView

    ListView {
        id: missionList
        delegate: MissionDelegate{}
        model: missionModel
        anchors.left:  parent.left
        anchors.top: parent.top
        width: parent.width - 40
        height:  parent.height - 50
        anchors.horizontalCenter: parent.horizontalCenter
        highlightFollowsCurrentItem: true
        focus: true
        keyNavigationWraps :true
        anchors.leftMargin: 10
//		anchors.topMargin: 30
        spacing: 320
    }
    function run(  )
    {
        missionModel.run( missionList.currentIndex )
    }

    Item {
        id: startButton
        width: 80
        height: 30
        anchors.verticalCenter: missionList.verticalCenter
        anchors.left: missionList.right
        anchors.margins: 20
        Rectangle {
            color: "#00c4ff"
            anchors.fill: parent
            radius: 5
            border.color: "#110101"
            DText{
                text: "Play"
                font.pointSize: 12
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    missionView.run()
                }
            }
        }
    }
}
