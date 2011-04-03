import QtQuick 1.0

GenericDelegate {
	anchors.horizontalCenterOffset: ListView.isCurrentItem ? 10 : 0
	anchors.horizontalCenter: parent.horizontalCenter
}
