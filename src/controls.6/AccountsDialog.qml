
import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts

import org.mauikit.controls as Maui
import org.mauikit.accounts as MA

/**
 * @inherit org::mauikit::controls::PopupPage
 * @brief A dialog listing all the available online accounts. 
 * 
 * @image html accountsdialog.png "Accounts dialog"
 * 
 * @code
 * 
 * @endcode
 * 
 */
Maui.PopupPage
{
    id: control

    maxHeight: 350
    maxWidth: maxHeight

    // title: i18nd("mauikitaccounts","Accounts")

    /**
      * @brief Alias to the MauiKit BaseModel handling the data
      * @property MauiKit::MauiModel AccountsDialog::model
      */
    readonly property alias model : _syncingModel

    /**
      * @brief Alias to the list containing the data of the accounts.
      * @property Accounts AccountsDialog::list
      */
    readonly property alias list : _syncingModel.list

    MA.CredentialsDialog
    {
        id: _syncDialog
        onAccepted:
        {
            control.addAccount(serverField.text, userField.text, passwordField.text)
            close()
        }
    }

    actions: Action
    {
        text: i18nd("mauikitaccounts","Add")
        onTriggered: _syncDialog.open()
    }

    Maui.InfoDialog
    {
        id: _removeDialog

        title: i18nd("mauikitaccounts","Remove Account")
        message: i18nd("mauikitaccounts","Are you sure you want to remove this account?")

            standardButtons: Dialog.Ok | Dialog.Cancel

        onRejected: close()
        onAccepted:
        {
            var account = MA.Accounts.get(_listView.currentIndex)
            console.log(account.label)
            control.removeAccount(account.server, account.user)
            close()
        }
    }

    Maui.ContextualMenu
    {
        id: _menu

        MenuItem
        {
            text: i18nd("mauikitaccounts","Remove...")
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
                _menu.show()
            }

            onRightClicked:
            {
                _listView.currentIndex = index
                _menu.show()
            }
        }
        
            holder.visible: _listView.count == 0
            anchors.fill: parent
            holder.isMask: true
            holder.emoji: "qrc:/assets/dialog-information.svg"
            holder.title: i18nd("mauikitaccounts","No accounts yet!")
            holder.body: i18nd("mauikitaccounts","Start adding new accounts to sync your files, music, contacts, images, notes, etc...")
        
    }

    /**
     * @brief Add a new account
     * @param server the remote server address 
     * @param user the user name
     * @param password password for the user in the remote server provided 
     */
    function addAccount(server, user, password)
    {
        if(user.length)
            MA.Accounts.registerAccount({server: server, user: user, password: password})
    }

    /**
     * @brief Remove an account for the given user in the given server address
     * @param server the server remote address
     * @param user the user name
     */
    function removeAccount(server, user)
    {
        if(server.length && user.length)
            MA.Accounts.removeAccount(server, user)
    }

   /**
     * @brief Remove an account for the given user in the given server address, and remove all the local cached files
     * @param server the server remote address
     * @param user the user name
     */
    function removeAccountAndFiles(server, user)
    {
        if(server.length && user.length)
            MA.Accounts.removeAccountAndFiles(server, user)
    }
}
