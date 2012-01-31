import QtQuick 1.0

import "sprintf.js" as Util

Item {
    id: missionDelegate
//    property int current_battleId: battleId
    property bool isCurrent: ListView.isCurrentItem
//    property int height_offset: isCurrent ? 40 : 0
    Rectangle {
        id: missionBG
        height: 300
        width: 800
//		y: parent.y + height_offset
        anchors.margins: 15
        color: isCurrent ? "#F59E00" : "#d4dbd3"
        radius:  5
        Behavior on height { PropertyAnimation{} }
        DText {
            id: missionText
            width: parent.width -330
            height: parent.height
            text: Util.sprintf("<b>%s</b><br/>%s", title, intro);
            font.bold: false
            font.pointSize: 10
            anchors.margins: 10
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            wrapMode: Text.Wrap
        }
        Rectangle {
            color: "black"
            radius: 5
//            opacity: isCurrent ? 0.4 : 0.0
            opacity: 0.4
            width: 310
            height: 198
            anchors.right: missionBG.right
            anchors.margins: 5
            anchors.verticalCenter: parent.verticalCenter
            Image {
                source: "image://vfs/" + image
                width: 300
                height: 188
                anchors.centerIn: parent
            }
            Behavior on opacity { PropertyAnimation{} }
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                ListView.view.currentIndex = index;
//                multiplayerMenu.load(2);
            }
        }
    }
}
