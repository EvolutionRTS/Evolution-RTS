import QtQuick 1.0

Item {
	id: multiplayerMenu
	property variant elIds: [battlelistView,quickmatchView,battleroomView]
	function load(viewID) {
		for ( var lid in elIds ) {
			var qmlItem = elIds[lid]
			if ( lid == viewID )
				qmlItem.state = "Onscreen"
			else
				qmlItem.state = "Offscreen"
		}
		state = "inactive"
	}
	function unloadAll() {
		for ( var lid in elIds ) {
			var qmlItem = elIds[lid]
			qmlItem.state = "Offscreen"
		}
		state = "active"
	}

	Row {
		id: buttonRow
//		anchors.centerIn: multiplayerContainer
		MenuButton{ text: "Browse Battles"; onClicked : load(0); }
		MenuButton{ text: "Quickmatch"; onClicked : load(1); }
		MenuButton{ text: "Back"; onClicked : unloadAll(); id:backButton;}
	}

	states: [
		State {
			name: "active"
			PropertyChanges { target: backButton; 	opacity:0 }
			PropertyChanges { target: buttonRow; 	y:500 }
			PropertyChanges { target: buttonRow; 	scale:0.8 }
//			AnchorChanges { target: buttonRow; anchors.top: parent.top }
		},
		State {
			name: "inactive"
			PropertyChanges { target: backButton; 	opacity:1 }
			PropertyChanges { target: buttonRow; 	y:600 }
			PropertyChanges { target: buttonRow; 	scale:0.6 }
//			AnchorChanges { target: buttonRow; anchors.top: parent.bottom }
		}
	]
	transitions: [
		Transition {
			AnchorAnimation{  easing.type: Easing.InOutQuad; duration: 1000  }
			PropertyAnimation{  easing.type: Easing.InOutQuad; duration: 1000  }
		}
	]
	state: "active"
//	anchors.horizontalCenter: multiplayerContainer.horizontalCenter
//	clip: true
}
