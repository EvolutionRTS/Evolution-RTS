// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

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
}
