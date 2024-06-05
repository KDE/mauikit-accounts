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
import QtQuick 

import QtQuick.Controls 
import QtQuick.Layouts 

import org.mauikit.controls as Maui
import org.mauikit.accounts as MA

/**
 * @inherit QtQuick.Controls.MenuItem
 * @brief A MenuItem entry to list the available accounts and for launching the accounts dialog.
 * 
 * @image html accountsmenuitem.png "Accounts menu entry"
 * 
 * @code
 * Maui.Page
 * {
 *    anchors.fill: parent
 * 
 *    Maui.Controls.showCSD: true
 * 
 *    headBar.leftContent: Maui.ToolButtonMenu
 *    {
 *        icon.name: "application-menu"
 *        MA.AccountsMenuItem {}
 * 
 *        MenuSeparator {}
 * 
 *        MenuItem
 *        {
 *            text: "About"
 *            onTriggered: root.about()
 *        }
 *    }
 * }
 * @endcode
 */
MenuItem
{
    MA.AccountsDialog
    {
        id: _accountsDialog
    }
    
    contentItem: ColumnLayout
    {
        id: _accountLayout
        
        spacing: Maui.Style.defaultSpacing
        
        Repeater
        {
            id: _accountsListing
            
            model: Maui.BaseModel
            {
                list: MA.Accounts
            }
            
            delegate: MenuItem
            {
                Layout.fillWidth: true
                
                checked: MA.Accounts.currentAccountIndex === index
                icon.name: "amarok_artist"
                text: model.user
                
                onClicked: MA.Accounts.currentAccountIndex = index
            }
            
            Component.onCompleted:
            {
                if(_accountsListing.count > 0)
                    MA.Accounts.currentAccountIndex = 0
            }
        }
        
        Button
        {
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            text: i18nd("mauikitaccounts","Accounts")
            icon.name: "list-add-user"
            onClicked:
            {
                _accountsDialog.open()
            }
        }
    }
}


