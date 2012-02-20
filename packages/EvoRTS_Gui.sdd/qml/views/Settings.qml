import Qt 4.7
MainView {
	id: settingsView

	SectionHeader {
		id: titleRec
		anchors.top: parent.top
		text: "Select settings preset"
	}

	ListView {
		id: plist
		delegate: GenericVerticalDelegate{
			height: 40
			width: 0.4 * parent.width
            listID: plist
		}
		model: presetModel
		anchors.top: titleRec.bottom
		anchors.horizontalCenter: titleRec.horizontalCenter
		width: 300
		height: parent.height - ( titleRec.height + resHeader.height + 250 )
		highlightFollowsCurrentItem: true
		focus: true
		keyNavigationWraps :true
		anchors.margins: 35
		spacing: 5
		onCurrentIndexChanged: {
			presetModel.use( currentIndex )
		}
	}

	SectionHeader {
		id: resHeader
		anchors.top: plist.bottom
		text: "Select screen resolution"
	}
	HorizontalListView {
        id: klist
		model: screenresModel
		delegate: GenericDelegate {
			height: 50
			width: 130
            listID: klist
		}
		anchors.top: resHeader.bottom
		anchors.topMargin: 15
		onCurrentIndexChanged: {
			screenresModel.use( currentIndex )
		}
	}

	function onAppLoaded()
	{
		plist.currentIndex = presetModel.lastSessionIndex();
		klist.currentIndex = screenresModel.lastSessionIndex();
	}
}
