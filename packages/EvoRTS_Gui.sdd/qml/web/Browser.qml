import Qt 4.7
import "../views"
MainView {
	property string urlString : "http://www.evolutionrts.info/"
	id: webBrowser
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
}
