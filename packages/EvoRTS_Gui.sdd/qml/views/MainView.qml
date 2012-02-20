import QtQuick 1.0

import Qt 4.7

Item {
	id: mainView;
	width: parent.width - 24;
	height: parent.height - 24;

	states: [
		State {
			name: "Offscreen"
			PropertyChanges { target: mainView; 	anchors.topMargin:  4000 }
			AnchorChanges { target: mainView; anchors {top: mainContainer.bottom } }

		},
		State {
			name: "Onscreen"
			AnchorChanges { target: mainView; anchors {top: mainContainer.top } }
			PropertyChanges { target: mainView; 	anchors.topMargin:  12 }
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
