import QtQuick 1.0

import Qt 4.7

Item {
	id: subView;
	width: parent.width - 24;
	height: parent.height - 24;

	states: [
		State {
			name: "Offscreen"
			PropertyChanges { target: subView; 	anchors.rightMargin:  4000 }
			AnchorChanges { target: subView; anchors {left: multiplayerContainer.right } }

		},
		State {
			name: "Onscreen"
			AnchorChanges { target: subView; anchors {left: multiplayerContainer.left } }
			PropertyChanges { target: subView; 	anchors.rightMargin:  50 }
		}
	]
	transitions: [
		Transition {
			AnchorAnimation{  easing.type: Easing.InOutQuad; duration: 1000  }
		}
	]
	state:  "Offscreen"
	anchors.horizontalCenter: parent.horizontalCenter
}
