// SPDX-FileCopyrightText: 2020 Carl Schwan <carl@carlschwan.eu>
//
// SPDX-License-Identifier: LGPL-2.1-or-later

#include <QQmlEngine>
#include <QResource>

#include "mauikitaccounts_plugin.h"

#include "mauiaccounts.h"

void MauiKitAccountsPlugin::registerTypes(const char *uri)
{
#if defined(Q_OS_ANDROID)
    QResource::registerResource(QStringLiteral("assets:/android_rcc_bundle.rcc"));
    #endif
    
    //File Browsing components
    qmlRegisterAnonymousType<MauiAccounts>(uri, 1);
    
    qmlRegisterType(resolveFileUrl(QStringLiteral("AccountsDialog.qml")), uri, 1, 0, "AccountsDialog"); 
    qmlRegisterType(resolveFileUrl(QStringLiteral("CredentialDialog.qml")), uri, 1, 0, "CredentialDialog"); 
}

void MauiKitAccountsPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_UNUSED(engine);
    Q_UNUSED(uri);
    
    /** IMAGE PROVIDERS **/
//     engine->addImageProvider("thumbnailer", new Thumbnailer());
}
