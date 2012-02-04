import Qt 4.7
import "sprintf.js" as Util

Item {
    id: missionDelegate
    property bool isCurrent: ListView.isCurrentItem

    Rectangle {
        id: missionBG
        height: 300
        width: 800
//		y: parent.y + height_offset
        anchors.margins: 15
        color: isCurrent ? "#F59E00" : "#d4dbd3"
        radius:  5
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
                source: image
                width: 300
                height: 188
                anchors.centerIn: parent
            }
//            Behavior on opacity { PropertyAnimation{} }
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                missionList.currentIndex = index;
            }
        }
    }
}
