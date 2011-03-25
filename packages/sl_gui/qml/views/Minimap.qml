import Qt 4.7

Item {
	Rectangle {
		color: "black"
		radius: 5
		anchors.fill: parent
		opacity: 0.6
	}
	MinimapImage {
		id: imgBG
	}
	MinimapImage {
		id: imgBG2
	}

	clip: true

	property bool activeImage: false
	function load( mapname ) {
		if ( activeImage ) {
			imgBG2.opacity = 0.0
			imgBG.source = "image://minimaps/" + mapname
			imgBG.opacity = 1.0
		}
		else {
			imgBG.opacity = 0.0
			imgBG2.source = "image://minimaps/" + mapname
			imgBG2.opacity = 1.0
		}
		activeImage = !activeImage
	}
}
