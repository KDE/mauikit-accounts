
import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3

import org.mauikit.controls 1.3 as Maui
import org.mauikit.accounts 1.0 as MA

Maui.Dialog
{
    id: control

    maxHeight: 350
    maxWidth: maxHeight
    footBar.visible: false
    page.title: i18n("Accounts")
    page.showTitle: false

    /**
      *
      */
    property alias model : _syncingModel

    /**
      *
      */
    property alias list : _syncingModel.list

    MA.CredentialsDialog
    {
        id: _syncDialog
        onAccepted:
        {
            control.addAccount(serverField.text, userField.text, passwordField.text);
            close();
        }
    }

    rejectButton.visible: false
    acceptButton.text: i18n("Add")
    onAccepted: _syncDialog.open()

    headBar.rightContent: ToolButton
    {
        icon.name: "documentinfo"
        onClicked: Qt.openUrlExternally("https://mauikit.org/cloud")
    }

    Maui.Dialog
    {
        id: _removeDialog

        maxWidth: 400
        title: i18n("Remove Account")
        message: i18n("Are you sure you want to remove this account?")
        page.margins: control.page.margins

        rejectButton.text: i18n("Delete Account")
        // 			rejectButton.visible: false

        onRejected:
        {
            var account = MA.Accounts.get(_listView.currentIndex)
            console.log(account.label)
            control.removeAccount(account.server, account.user)
            close()
        }


        footBar.rightContent: Button
        {
            text: i18n("Delete Account and Files")
            onClicked:
            {
                var account = MA.Accounts.get(_listView.currentIndex)
                control.removeAccountAndFiles(account.server, account.user)
                close()
            }
        }
    }

    Menu
    {
        id: _menu

        MenuItem
        {
            text: i18n("Remove...")
            Maui.Theme.textColor: Maui.Theme.negativeTextColor

            onTriggered: _removeDialog.open()
        }
    }

    stack: Maui.ListBrowser
    {
        id: _listView
        Layout.fillHeight: true
        Layout.fillWidth: true
        model: Maui.BaseModel
        {
            id: _syncingModel
            list: MA.Accounts
        }

        delegate: Maui.ListDelegate
        {
            id: delegate
            width: ListView.view.width
            label: model.label
            label2: model.server

            radius: Maui.Style.radiusV

            onClicked:
            {
                _listView.currentIndex = index
            }

            onPressAndHold:
            {
                _listView.currentIndex = index
                _menu.popup()
            }

            onRightClicked:
            {
                _listView.currentIndex = index                
                _menu.popup()
            }
        }

        Maui.Holder
        {
            visible: _listView.count == 0
            anchors.fill: parent
            isMask: true
            emoji: "qrc:/assets/dialog-information.svg"
            title: i18n("No accounts yet!")
            body: i18n("Start adding new accounts to sync your files, music, contacts, images, notes, etc...")
        }
    }

    function addAccount(server, user, password)
    {
        if(user.length)
            MA.Accounts.registerAccount({server: server, user: user, password: password})
    }

    function removeAccount(server, user)
    {
        if(server.length && user.length)
              MA.Accounts.removeAccount(server, user)
    }

    function removeAccountAndFiles(server, user)
    {
        if(server.length && user.length)
             MA.Accounts.removeAccountAndFiles(server, user)
    }
}
