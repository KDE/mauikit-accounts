# SPDX-FileCopyrightText: 2020 Carl Schwan <carl@carlschwan.eu>
#
# SPDX-License-Identifier: BSD-2-Clause

cmake_minimum_required(VERSION 3.5)

set(KF5_VERSION "5.70.0")
set(REQUIRED_QT_VERSION 5.15.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror")

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(AUTOMOC_MOC_OPTIONS -Muri=org.mauikit.accounts)

project(Accounts LANGUAGES CXX VERSION 2.1.0)

find_package(ECM ${KF5_VERSION} NO_MODULE)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH})

include(GenerateExportHeader)
include(GNUInstallDirs)
include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings)
include(FeatureSummary)
include(ECMPoQmTools)
include(ECMSetupVersion)
include(ECMGenerateQmlTypes)
include(CMakePackageConfigHelpers)
#include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
include(KDEPackageAppTemplates)

set(CMAKECONFIG_INSTALL_DIR "${KDE_INSTALL_CMAKEPACKAGEDIR}/MauiKitAccounts")

configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/MauiKitAccountsConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/MauiKitAccountsConfig.cmake"
    INSTALL_DESTINATION ${CMAKECONFIG_INSTALL_DIR}
    PATH_VARS KF5_INCLUDE_INSTALL_DIR CMAKE_INSTALL_PREFIX
)

install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/MauiKitAccountsConfigVersion.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/MauiKitAccountsConfig.cmake"
    DESTINATION "${CMAKECONFIG_INSTALL_DIR}"
    COMPONENT Devel
)

    install(EXPORT MauiKitAccountsTargets
        DESTINATION "${CMAKECONFIG_INSTALL_DIR}"
        FILE MauiKitAccountsTargets.cmake
        NAMESPACE MauiKit::)
        
ecm_setup_version(${PROJECT_VERSION}
    VARIABLE_PREFIX Accounts
    VERSION_HEADER "${CMAKE_CURRENT_BINARY_DIR}/accounts_version.h"
    PACKAGE_VERSION_FILE "${CMAKE_CURRENT_BINARY_DIR}/MauiKitAccountsConfigVersion.cmake"
    SOVERSION 1
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/accounts_version.h"
    DESTINATION ${KDE_INSTALL_INCLUDEDIR}/MauiKit/Accounts
    COMPONENT Devel)

if(ANDROID)
    find_package(Qt5 REQUIRED COMPONENTS AndroidExtras)
    find_package(Gradle REQUIRED)
elseif(UNIX)
    find_package(KF5 ${REQUIRED_KF5_VERSION} REQUIRED COMPONENTS Config)
endif()

find_package(Qt5 ${REQUIRED_QT_VERSION} COMPONENTS Core Quick Sql Network REQUIRED)
find_package(KF5 ${REQUIRED_KF5_VERSION} REQUIRED COMPONENTS I18n CoreAddons)
find_package(MauiKit)
    
add_subdirectory(src)

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
