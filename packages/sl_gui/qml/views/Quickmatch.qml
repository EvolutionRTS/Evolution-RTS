import Qt 4.7

SubView {
	id: quickmatchView
	Column {
		anchors.left: parent.left
		MenuButton { text: "STANDINS" }
		Repeater {
			model: 5
			MenuButton{ text: index + " vs " + index }
		}
	}
//	MenuButton{ text: "DUMMY"; anchors.left: parent.left }
}
