#pragma once

#include <QString>
#include <KAboutData>
#include "accounts_export.h"

/**
 * @brief MauiKit Accounts module information.
 */
namespace MauiKitAccounts
{
   ACCOUNTS_EXPORT QString versionString();
   ACCOUNTS_EXPORT QString buildVersion();
   ACCOUNTS_EXPORT KAboutComponent aboutData();
};
