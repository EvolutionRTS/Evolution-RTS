import Qt 4.7

Image {
		smooth: true
		width: 0.8 * parent.width
		fillMode: Image.PreserveAspectFit
		clip:false
		source: "image://graphics/logo.png"
		anchors.horizontalCenter: bgImage.horizontalCenter

		anchors.topMargin: 50

		states: [
			State {
				name: "Offscreen"
				AnchorChanges { target: logoImage; anchors.top: parent.bottom }
			},
			State {
				name: "Onscreen"
				AnchorChanges { target: logoImage; anchors.top: parent.top }
			}
		]
		transitions: [
			Transition {
				AnchorAnimation{  easing.type: Easing.OutBounce; duration: 1000  }
			}
		]
		state:  "Offscreen"

	Timer {
			interval: 500; running: true; repeat: false
			onTriggered: logoImage.state = "Onscreen"
		}
}
