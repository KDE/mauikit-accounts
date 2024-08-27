# SPDX-FileCopyrightText: 2020 Camilo Higuita <milo.h@aol.com>
#
# SPDX-License-Identifier: BSD-2-Clause

remove_definitions(-DQT_NO_CAST_FROM_ASCII -DQT_STRICT_ITERATORS -DQT_NO_CAST_FROM_BYTEARRAY)

add_library(MauiKitAccounts${MAUI_MAJOR_VERSION} SHARED)

ecm_add_qml_module(MauiKitAccounts${MAUI_MAJOR_VERSION}
    URI "org.mauikit.accounts"
    CLASS_NAME AccountsPlugin
    NO_PLUGIN_OPTIONAL
    NO_GENERATE_PLUGIN_SOURCE
    DEPENDENCIES
    "org.mauikit.controls")

set(plugin_SRCS
    code/accounts_plugin.cpp
    code/accounts.qrc)

set(lib_SRCS
    code/mauiaccounts.cpp
    code/accountsdb.cpp
    code/moduleinfo.cpp)

set(lib_HDRS
    code/mauiaccounts.h
    code/moduleinfo.h)

ecm_target_qml_sources(MauiKitAccounts${MAUI_MAJOR_VERSION} SOURCES
    controls.${QT_MAJOR_VERSION}/AccountsDialog.qml
    controls.${QT_MAJOR_VERSION}/AccountsMenuItem.qml
    controls.${QT_MAJOR_VERSION}/CredentialsDialog.qml)

target_sources(MauiKitAccounts${MAUI_MAJOR_VERSION}plugin
    PRIVATE
    ${plugin_SRCS})

target_sources(MauiKitAccounts${MAUI_MAJOR_VERSION}
    PRIVATE
    ${lib_SRCS})

add_library(MauiKit${MAUI_MAJOR_VERSION}::Accounts ALIAS MauiKitAccounts${MAUI_MAJOR_VERSION})

generate_export_header(MauiKitAccounts${MAUI_MAJOR_VERSION} BASE_NAME Accounts)
set_target_properties(MauiKitAccounts${MAUI_MAJOR_VERSION} PROPERTIES
    VERSION ${PROJECT_VERSION}
    SOVERSION ${PROJECT_VERSION_MAJOR}
    EXPORT_NAME "Accounts")

target_include_directories(MauiKitAccounts${MAUI_MAJOR_VERSION}
    INTERFACE "$<INSTALL_INTERFACE:${KDE_INSTALL_INCLUDEDIR}/MauiKit${MAUI_MAJOR_VERSION}/Accounts>")

target_include_directories(MauiKitAccounts${MAUI_MAJOR_VERSION} PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR};${CMAKE_CURRENT_BINARY_DIR};>")

target_link_libraries(MauiKitAccounts${MAUI_MAJOR_VERSION}plugin
    PRIVATE
    Qt${QT_MAJOR_VERSION}::Core
    Qt${QT_MAJOR_VERSION}::Quick
    Qt${QT_MAJOR_VERSION}::Qml
    Qt${QT_MAJOR_VERSION}::Sql
    Qt${QT_MAJOR_VERSION}::Network
    KF${KF_MAJOR_VERSION}::I18n
    MauiKit${MAUI_MAJOR_VERSION}
    MauiKit${MAUI_MAJOR_VERSION}::Accounts)

target_link_libraries(MauiKitAccounts${MAUI_MAJOR_VERSION}
    PRIVATE
    MauiKit${MAUI_MAJOR_VERSION}
    Qt${QT_MAJOR_VERSION}::Sql
    Qt${QT_MAJOR_VERSION}::Core
    KF${KF_MAJOR_VERSION}::CoreAddons)

ecm_finalize_qml_module(MauiKitAccounts${MAUI_MAJOR_VERSION} DESTINATION ${KDE_INSTALL_QMLDIR})

install(TARGETS MauiKitAccounts${MAUI_MAJOR_VERSION} EXPORT MauiKitAccounts${MAUI_MAJOR_VERSION}Targets ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})

install(FILES
    ${lib_HDRS}
    ${CMAKE_CURRENT_BINARY_DIR}/accounts_export.h
    DESTINATION ${KDE_INSTALL_INCLUDEDIR}/MauiKit${MAUI_MAJOR_VERSION}/Accounts
    COMPONENT Devel)
