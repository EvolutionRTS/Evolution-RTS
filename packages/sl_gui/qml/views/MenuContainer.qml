import Qt 4.7

Column {
	width: 225
	anchors.left: parent.left
	anchors.leftMargin: 0.04 * parent.width
	spacing: 20
	anchors.verticalCenter:  parent.verticalCenter

	property variant elIds: [webBrowser, skirmishView,settingsView,welcomeView,battlelistView]
	function load(viewID) {
		for ( var lid in elIds ) {
			var qmlItem = elIds[lid]
			if ( lid == viewID )
				qmlItem.state = "Onscreen"
			else
				qmlItem.state = "Offscreen"
		}
	}

	MenuButton{ text: "Skirmish"; onClicked : load(1) }
	MenuButton{ text: "Play online" ; onClicked : load(4) }
	MenuButton{ text: "Settings" ; onClicked : load(2) }
	MenuButton{ text: audioManager.isActive() ? "Audio On" : "Audio Off";
		onClicked: { audioManager.toggleActive();
				text = audioManager.isActive() ? "Audio On" : "Audio Off" }
	}
	MenuButton{ text: "How to play" }
	MenuButton{ text: "Website"; onClicked : load(0) }
	MenuButton{ text: "Quit"; onClicked: Qt.quit() }

	add: Transition {
			 NumberAnimation {
				 properties: "y"
				 easing.type: Easing.OutBounce
				 duration: 2000

			 }
		 }
}
