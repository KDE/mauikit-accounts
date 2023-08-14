// SPDX-FileCopyrightText: 2020 Carl Schwan <carl@carlschwan.eu>
//
// SPDX-License-Identifier: LGPL-2.1-or-later

#include <QQmlEngine>
#include <QResource>
#include <QQmlContext>

#include "accounts_plugin.h"

#include "mauiaccounts.h"

void AccountsPlugin::registerTypes(const char *uri)
{
    #if defined(Q_OS_ANDROID)
    QResource::registerResource(QStringLiteral("assets:/android_rcc_bundle.rcc"));
    #endif
    
    Q_ASSERT(QLatin1String(uri) == QLatin1String("org.mauikit.accounts"));

    qmlRegisterSingletonType<MauiAccounts>(uri, 1, 0, "Accounts", [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(scriptEngine)
        auto accounts = MauiAccounts::instance();
        engine->setObjectOwnership(accounts, QQmlEngine::CppOwnership);
        return accounts;
    });
    
    qmlRegisterType(componentUrl(QStringLiteral("AccountsMenuItem.qml")), uri, 1, 0, "AccountsMenuItem");
    qmlRegisterType(componentUrl(QStringLiteral("AccountsDialog.qml")), uri, 1, 0, "AccountsDialog");
    qmlRegisterType(componentUrl(QStringLiteral("CredentialsDialog.qml")), uri, 1, 0, "CredentialsDialog");
}

void AccountsPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_UNUSED(uri);
    Q_UNUSED(engine);
    
}

QUrl AccountsPlugin::componentUrl(const QString &fileName) const
{
    return QUrl(resolveFileUrl(fileName));
}
