/*
 *   Copyright 2018 Camilo Higuita <milo.h@aol.com>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
import org.mauikit.controls 1.2 as Maui

/**
 * SyncDialog
 * A global sidebar for the application window that can be collapsed.
 *
 *
 *
 *
 *
 *
 */
Maui.Dialog
{
    id: control

    acceptButton.text: i18n("Sign in")
    rejectButton.text: i18n("Cancel")
    rejectButton.visible: false
    page.margins: Maui.Style.space.medium
    page.title: i18n("New Account")
    page.showTitle: false
    spacing: Maui.Style.space.medium

    /**
      * customServer : bool
      */
    property bool customServer: false

    /**
      * serverField : TextField
      */
    property alias serverField: serverField

    /**
      * userField : TextField
      */
    property alias userField: userField

    /**
      * passwordField : TextField
      */
    property alias passwordField: passwordField

    footBar.visible: false
//     maxHeight: 350
    maxWidth: 350

    actions: Action
    {
        text: i18n("Sign up")
        enabled: !customServer
        onTriggered: Qt.openUrlExternally("https://www.opendesktop.org/register")
    }

    onRejected:	close()

    Image
    {
        visible: !customServer
        Layout.alignment: Qt.AlignCenter
        Layout.preferredWidth:  Maui.Style.iconSizes.huge
        Layout.preferredHeight: Maui.Style.iconSizes.huge
        Layout.margins: Maui.Style.space.medium

        sourceSize.width: width
        sourceSize.height: height

        source: "qrc:/assets/opendesktop.png"
    }

    Label
    {
        visible: !customServer
        Layout.fillWidth: true
        horizontalAlignment: Qt.AlignHCenter
        Layout.preferredHeight: Maui.Style.rowHeight
        text: "opendesktop.org"
        elide: Text.ElideNone
        wrapMode: Text.NoWrap
        font.weight: Font.Bold
        font.bold: true
        font.pointSize: Maui.Style.fontSizes.big
    }

    Maui.TextField
    {
        id: userField
        Layout.fillWidth: true
        placeholderText: i18n("Username")
        icon.source: "im-user"
        inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhSensitiveData
    }

    Maui.PasswordField
    {
        id: passwordField
        Layout.fillWidth: true
        placeholderText: i18n("Password")       
        inputMethodHints: Qt.ImhNoAutoUppercase
    }

    Maui.TextField
    {
        id: serverField
        visible: customServer
        icon.source: "link"
        Layout.fillWidth: true
        placeholderText: i18n("Server address")
        inputMethodHints: Qt.ImhUrlCharactersOnly | Qt.ImhNoAutoUppercase
        text: customServer ? "" : "https://cloud.opendesktop.cc/cloud/remote.php/webdav/"
    }

    Button
    {
        Layout.fillWidth: true
        icon.name: "filename-space-amarok"
        text: customServer ? i18n("opendesktop") : i18n("Custom server")
        onClicked: customServer = !customServer
    }
}
