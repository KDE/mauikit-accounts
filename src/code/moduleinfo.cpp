#include "moduleinfo.h"
#include "../accounts_version.h"

QString MauiKitAccounts::versionString()
{
    return QStringLiteral(Accounts_VERSION_STRING);
}

QString MauiKitAccounts::buildVersion()
{
    return QStringLiteral(GIT_BRANCH)+QStringLiteral("/")+QStringLiteral(GIT_COMMIT_HASH);
}

KAboutComponent MauiKitAccounts::aboutData()
{
    return KAboutComponent(QStringLiteral("MauiKit Accounts"),
                         QStringLiteral("Accounts management controls."),
                         QStringLiteral(Accounts_VERSION_STRING),
                         QStringLiteral("http://mauikit.org"),
                         KAboutLicense::LicenseKey::LGPL_V3);
}
