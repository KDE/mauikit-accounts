import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.mauikit.controls as Maui
import org.mauikit.accounts as MA

Maui.ApplicationWindow
{
    id: root

    Maui.Page
    {
        anchors.fill: parent

        Maui.Controls.showCSD: true

        headBar.leftContent: Maui.ToolButtonMenu
        {
            icon.name: "application-menu"
            MA.AccountsMenuItem {}

            MenuSeparator {}

            MenuItem
            {
                text: "About"
                onTriggered: root.about()
            }
        }
    }
}

