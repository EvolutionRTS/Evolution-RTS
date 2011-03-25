import Qt 4.7

Item {
	property string urlString : "http://www.evolutionrts.info/"
	id: webBrowser
	width: parent.width - 24
	height: parent.height - 24
	anchors.margins: 12
	anchors.horizontalCenter: parent.horizontalCenter
	clip: true
	Item { id: headerSpace; width: parent.width; height: 1 }

	Header {
		id: header
		editUrl: webBrowser.urlString
		width: headerSpace.width; height: headerSpace.height
	}
	FlickableWebView {
		id: webView
		height: parent.height - 10
		url: webBrowser.urlString
		onProgressChanged: header.urlChanged = false
		anchors { top: headerSpace.bottom; left: parent.left; right: parent.right; bottom: parent.bottom }
	}

	ScrollBar {
		scrollArea: webView; width: 8
		anchors { right: parent.right; top: header.bottom; bottom: parent.bottom }
	}

	ScrollBar {
		scrollArea: webView; height: 8; orientation: Qt.Horizontal
		anchors { right: parent.right; rightMargin: 8; left: parent.left; bottom: parent.bottom }
	}

	states: [
		State {
			name: "Offscreen"
			PropertyChanges { target: webBrowser; 	anchors.topMargin:  4000 }
			AnchorChanges { target: webBrowser; anchors {top: mainContainer.bottom } }

		},
		State {
			name: "Onscreen"
			AnchorChanges { target: webBrowser; anchors {top: mainContainer.top } }
			PropertyChanges { target: webBrowser; 	anchors.topMargin:  12 }
		}
	]
	transitions: [
		Transition {
			AnchorAnimation{  easing.type: Easing.InOutQuad; duration: 1000  }
		}
	]
	state:  "Offscreen"
}
