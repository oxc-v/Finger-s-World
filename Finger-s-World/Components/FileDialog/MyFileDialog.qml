// 自定义文件对话框

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.folderlistmodel

import "../Buttons"

Dialog {
    id: fileBrowser

    background: Rectangle {
        color: "#ffffff"
        radius: 10
    }
    height: Screen.desktopAvailableHeight / 2
    width: height
    modal: true
    closePolicy: Dialog.NoAutoClose
    focus: true
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    padding: 10
    clip: true

    property var file
    property url folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
    property int itemWidth: 25 * pixDens
    property int itemHeight: 10 * pixDens
    property int scaledMargin: 2 * pixDens
    property int fontSize: 5 * pixDens
    property int pixDens: Math.ceil(Screen.pixelDensity)

    Rectangle {
        id: root
        color: "#ffffff"
        anchors.fill: parent
        property bool showFocusHighlight: false
        property variant folders: folders1
        property variant view: view1
        property alias folder: folders1.folder
        property color textColor: "black"

        FolderListModel {
            id: folders1
            folder: fileBrowser.folder
        }

        FolderListModel {
            id: folders2
            folder: fileBrowser.folder
        }

        SystemPalette {
            id: palette
        }

        Component {
            id: folderDelegate

            Rectangle {
                id: wrapper
                function launch() {
                    var path = "file://";
                    if (filePath.length > 2 && filePath[1] === ':') // Windows drive logic, see QUrl::fromLocalFile()
                        path += '/';
                    path += filePath;
                    if (root.folders.isFolder(index))
                        fileBrowser.down(path);
                    else {
                        fileBrowser.file = path
                        fileBrowser.accepted()
                        fileBrowser.close()
                    }
                }
                width: root.width
                height: fileBrowser.itemHeight
                color: "transparent"

                Rectangle {
                    id: highlight; visible: false
                    anchors.fill: parent
                    color: palette.highlight
                    gradient: Gradient {
                        GradientStop { id: t1; position: 0.0; color: palette.highlight }
                        GradientStop { id: t2; position: 1.0; color: Qt.lighter(palette.highlight) }
                    }
                }

                Item {
                    width: fileBrowser.itemHeight + 10; height: fileBrowser.itemHeight + 10
                    Image {
                        source: "qrc:/Images/Icon/folder.png"
                        fillMode: Image.PreserveAspectFit
                        anchors.fill: parent
                        anchors.margins: fileBrowser.scaledMargin
                        visible: root.folders.isFolder(index)
                    }
                }

                Text {
                    id: nameText
                    anchors.fill: parent; verticalAlignment: Text.AlignVCenter
                    text: fileName
                    anchors.leftMargin: fileBrowser.itemHeight + fileBrowser.scaledMargin
                    font.pixelSize: fileBrowser.fontSize
                    color: (wrapper.ListView.isCurrentItem && root.showFocusHighlight) ? palette.highlightedText : root.textColor
                    elide: Text.ElideRight
                }

                MouseArea {
                    id: mouseRegion
                    anchors.fill: parent
                    onPressed: {
                        root.showFocusHighlight = false;
                        wrapper.ListView.view.currentIndex = index;
                    }
                    onClicked: { if (root.folders == wrapper.ListView.view.model) launch() }
                }

                states: [
                    State {
                        name: "pressed"
                        when: mouseRegion.pressed
                        PropertyChanges { target: highlight; visible: true }
                        PropertyChanges { target: nameText; color: palette.highlightedText }
                    }
                ]
            }
        }

        ListView {
            id: view1
            anchors.top: root.top
            anchors.bottom: root.bottom
            x: 0
            width: parent.width
            model: folders1
            delegate: folderDelegate
            highlight: Rectangle {
                color: palette.highlight
                visible: root.showFocusHighlight && view1.count != 0
                gradient: Gradient {
                    GradientStop { id: t1; position: 0.0; color: palette.highlight }
                    GradientStop { id: t2; position: 1.0; color: Qt.lighter(palette.highlight) }
                }
                width: view1.currentItem == null ? 0 : view1.currentItem.width
            }
            highlightMoveVelocity: 1000
            pressDelay: 100
            focus: true
            clip: true
            state: "current"
            states: [
                State {
                    name: "current"
                    PropertyChanges { target: view1; x: 0 }
                },
                State {
                    name: "exitLeft"
                    PropertyChanges { target: view1; x: -root.width }
                },
                State {
                    name: "exitRight"
                    PropertyChanges { target: view1; x: root.width }
                }
            ]
            transitions: [
                Transition {
                    to: "current"
                    SequentialAnimation {
                        NumberAnimation { properties: "x"; duration: 250 }
                    }
                },
                Transition {
                    NumberAnimation { properties: "x"; duration: 250 }
                    NumberAnimation { properties: "x"; duration: 250 }
                }
            ]
            Keys.onPressed: fileBrowser.keyPressed(event.key)
        }

        ListView {
            id: view2
            anchors.top: root.top
            anchors.bottom: root.bottom
            x: parent.width
            width: parent.width
            model: folders2
            delegate: folderDelegate
            highlight: Rectangle {
                color: palette.highlight
                visible: root.showFocusHighlight && view2.count != 0
                gradient: Gradient {
                    GradientStop { position: 0.0; color: palette.highlight }
                    GradientStop { position: 1.0; color: Qt.lighter(palette.highlight) }
                }
                width: view1.currentItem == null ? 0 : view1.currentItem.width
            }
            highlightMoveVelocity: 1000
            clip: true
            pressDelay: 100
            states: [
                State {
                    name: "current"
                    PropertyChanges { target: view2; x: 0 }
                },
                State {
                    name: "exitLeft"
                    PropertyChanges { target: view2; x: -root.width }
                },
                State {
                    name: "exitRight"
                    PropertyChanges { target: view2; x: root.width }
                }
            ]
            transitions: [
                Transition {
                    to: "current"
                    SequentialAnimation {
                        NumberAnimation { properties: "x"; duration: 250 }
                    }
                },
                Transition {
                    NumberAnimation { properties: "x"; duration: 250 }
                }
            ]
            Keys.onPressed: fileBrowser.keyPressed(event.key)
        }

        Keys.onPressed: {
            fileBrowser.keyPressed(event.key)
            if (event.key === Qt.Key_Return || event.key === Qt.Key_Select || event.key === Qt.Key_Right) {
                root.view.currentItem.launch();
                event.accepted = true;
            } else if (event.key === Qt.Key_Left) {
                fileBrowser.up();
            }
        }
    }

    // 路径标题
    header: Rectangle {
        height: fileBrowser.itemHeight
        Layout.fillWidth: true
        radius: 10
        Rectangle {
            anchors.fill: parent
            id: titleBar
            anchors.margins: 10

            Rectangle {
                id: upButton
                width: fileBrowser.itemHeight
                height: fileBrowser.itemHeight
                color: "transparent"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: fileBrowser.scaledMargin

                Image { anchors.fill: parent; anchors.margins: fileBrowser.scaledMargin; source: "qrc:/Images/Icon/left.png" }
                TapHandler { id: upRegion; onTapped: fileBrowser.up() }
                states: [
                    State {
                        name: "pressed"
                        when: upRegion.pressed
                        PropertyChanges { target: upButton; color: palette.highlight }
                    }
                ]
            }

            Text {
                anchors.left: upButton.right; anchors.right: parent.right; height: parent.height
                anchors.leftMargin: 10; anchors.rightMargin: 4;
                text: root.folders.folder
                color: "black"
                elide: Text.ElideLeft; horizontalAlignment: Text.AlignLeft; verticalAlignment: Text.AlignVCenter
                font.pixelSize: fileBrowser.fontSize
            }

            // 分隔线
            Rectangle {
                color: "#353535"
                width: parent.width
                height: 1
                anchors.top: titleBar.bottom
                anchors.topMargin: 10
            }
        }
    }

    footer: RowLayout {
        // 空白填充
        Rectangle{
            Layout.fillWidth: true
        }
        // 选择按钮
        GameButton {
            Layout.preferredHeight: fileBrowser.itemHeight
            Layout.preferredWidth: fileBrowser.itemWidth
            Layout.alignment: Qt.AlignRight
            Layout.margins: 15
            text: qsTr("选择")
            onPressed: {
                wrapper.launch()

            }
        }
        // 取消按钮
        GameButton {
            Layout.preferredHeight: fileBrowser.itemHeight
            Layout.preferredWidth: fileBrowser.itemWidth
            Layout.alignment: Qt.AlignRight
            Layout.margins: 15
            color: "#00918D"
            text: qsTr("取消")
            onPressed: fileBrowser.close()
        }
    }

    function down(path) {
        if (root.folders == folders1) {
            root.view = view2
            root.folders = folders2;
            view1.state = "exitLeft";
        } else {
            root.view = view1
            root.folders = folders1;
            view2.state = "exitLeft";
        }
        root.view.x = root.width;
        root.view.state = "current";
        root.view.focus = true;
        root.folders.folder = path;
    }

    function up() {
        var path = root.folders.parentFolder;
        if (path.toString().length === 0 || path.toString() === 'file:')
            return;
        if (root.folders == folders1) {
            root.view = view2
            root.folders = folders2;
            view1.state = "exitRight";
        } else {
            root.view = view1
            root.folders = folders1;
            view2.state = "exitRight";
        }
        root.view.x = -root.width;
        root.view.state = "current";
        root.view.focus = true;
        root.folders.folder = path;
    }

    function keyPressed(key) {
        switch (key) {
            case Qt.Key_Up:
            case Qt.Key_Down:
            case Qt.Key_Left:
            case Qt.Key_Right:
                root.showFocusHighlight = true;
            break;
            default:
                // do nothing
            break;
        }
    }
}
