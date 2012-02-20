import Qt 4.7

Rectangle {
	id: presetDelegate
	property bool isCurrent: ListView.isCurrentItem
	opacity: isCurrent ? 1.0 : 0.8
    property Item listID;

	Behavior on opacity {
		PropertyAnimation{}
	}

	color: "#0a92d5"; radius: 4
	gradient: Gradient {
		GradientStop {
			position: 0.00;
			color: "#0a92d5";
		}
		GradientStop {
			position: 1.00;
			color: "#0e7fb3";
		}
	}
	scale: activeFocus ? 1.0 : 0.95
	DText {
		id: textId
		anchors.fill: parent
		anchors.centerIn: parent
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment:Text.AlignVCenter
		text: display
		font.bold: true
		font.pointSize: 14
		color: "white"
		smooth: true
	}
	MouseArea{
		anchors.fill: parent
		onClicked: {
            listID.currentIndex = index
		}
	}
	Behavior on anchors.horizontalCenterOffset {
		PropertyAnimation{ easing.type: Easing.Linear; duration: 300 }
	}
	Behavior on scale {
		PropertyAnimation{ easing.type: Easing.Linear; duration: 300 }
	}

	property alias font_bold: textId.font.bold
	property alias font_size: textId.font.pointSize
	property alias text: textId.text
}
