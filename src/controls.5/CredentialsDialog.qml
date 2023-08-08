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
import org.mauikit.controls 1.3 as Maui

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
Maui.PopupPage
{
    id: control

    maxWidth: 350

    title: i18nd("mauikitaccounts","New Account")
    //    page.showTitle: false
    
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


    actions: [
        Action
        {
            text: i18nd("mauikitaccounts","Sign up")
            enabled: !customServer
            onTriggered: Qt.openUrlExternally("https://www.opendesktop.org/register")
        },

        Action
        {
            text: i18nd("mauikitaccounts","Sign in")
        }
    ]


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

    TextField
    {
        id: userField
        Layout.fillWidth: true
        placeholderText: i18nd("mauikitaccounts","Username")
        icon.source: "im-user"
        inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhSensitiveData
    }

    Maui.PasswordField
    {
        id: passwordField
        Layout.fillWidth: true
        placeholderText: i18nd("mauikitaccounts","Password")
        inputMethodHints: Qt.ImhNoAutoUppercase
    }

    TextField
    {
        id: serverField
        visible: customServer
        icon.source: "link"
        Layout.fillWidth: true
        placeholderText: i18nd("mauikitaccounts","Server address")
        inputMethodHints: Qt.ImhUrlCharactersOnly | Qt.ImhNoAutoUppercase
        text: customServer ? "" : "https://cloud.opendesktop.cc/cloud/remote.php/webdav/"
    }

    Button
    {
        Layout.fillWidth: true
        icon.name: "filename-space-amarok"
        text: customServer ? i18nd("mauikitaccounts","opendesktop") : i18nd("mauikitaccounts","Custom server")
        onClicked: customServer = !customServer
    }

}
