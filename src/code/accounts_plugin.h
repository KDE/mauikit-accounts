// SPDX-FileCopyrightText: 2020 Carl Schwan <carl@carlschwan.eu>
//
// SPDX-License-Identifier: LGPL-2.1-or-later

#pragma once

#include <QDir>
#include <QQmlExtensionPlugin>

class AccountsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)
public:
    void registerTypes(const char *uri) override;
    
private:
    void initializeEngine(QQmlEngine *engine, const char *uri) override;
    
    QString resolveFileUrl(const QString &filePath) const
    {
        #if defined(Q_OS_ANDROID)
        return QStringLiteral("qrc:/android_rcc_bundle/qml/org/mauikit/accounts/") + filePath;
        #else
        #ifdef QUICK_COMPILER
        return QStringLiteral("qrc:/mauikit/accounts/") + filePath;
        #else
        return baseUrl().toString() + QLatin1Char('/') + filePath;
        #endif
        #endif
    }
};
