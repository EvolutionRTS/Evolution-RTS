import QtQuick 1.0

MainView {
	anchors.fill: parent
	id: multiplayerContainer
	Battlelist { id: battlelistView }
	Quickmatch{ id: quickmatchView;state: "Offscreen" }
	MultiplayerMenu { id: multiplayerMenu; }
	BattleroomView { id: battleroomView; }
}
