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
  
  import org.kde.kirigami 2.8 as Kirigami 
  import org.mauikit.controls 1.3 as Maui 
  import org.mauikit.accounts 1.0 as MA
  
  Item
  {
      implicitHeight: _accountLayout.implicitHeight + Maui.Style.space.medium
      
      MA.AccountsDialog
      {
          id: _accountsDialog
      }
      
      ColumnLayout
      {
          id: _accountLayout
          width: parent.width * 0.9
          anchors.centerIn: parent
          spacing: Maui.Style.space.medium
          
          Repeater
          {
              id: _accountsListing
              
              model: Maui.BaseModel
              {
                  list: MA.Accounts
              }
              
              delegate: Maui.ListBrowserDelegate
              {
                  Layout.fillWidth: true
                  height: Maui.Style.rowHeight * 1.2
                  
                  Kirigami.Theme.backgroundColor: "transparent"
                  
                  isCurrentItem: MA.Accounts.currentAccountIndex === index
                  iconSource: "amarok_artist"
                  iconSizeHint: Maui.Style.iconSizes.medium
                  
                  label1.text: model.user
                  label2.text: model.server
                  
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
              Layout.preferredHeight: implicitHeight
              Layout.alignment: Qt.AlignCenter
              Layout.fillWidth: true
              text: i18n("Accounts")
              icon.name: "list-add-user"
              onClicked:
              {
                 _accountsDialog.open()                      
              }
          }
      }
  }
  
  
