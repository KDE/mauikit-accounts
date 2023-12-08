# SPDX-FileCopyrightText: 2020 Camilo Higuita <milo.h@aol.com>
#
# SPDX-License-Identifier: BSD-2-Clause

remove_definitions(-DQT_NO_CAST_FROM_ASCII -DQT_STRICT_ITERATORS -DQT_NO_CAST_FROM_BYTEARRAY)

ecm_add_qml_module(MauiKitAccounts${MAUI_MAJOR_VERSION} URI "org.mauikit.accounts" CLASSNAME AccountsPlugin)

set(sources
    code/accounts_plugin.cpp
    code/mauiaccounts.cpp
    code/accountsdb.cpp
    code/moduleinfo.cpp
    code/accounts.qrc)

set(headers
    code/mauiaccounts.h
    code/moduleinfo.h
    code/accountsdb.h)

if(QT_MAJOR_VERSION STREQUAL "5")
    if(QUICK_COMPILER)
        qtquick_compiler_add_resources(accounts_QML_QRC resources.qrc)
    else()
        qt5_add_resources(accounts_QML_QRC resources.qrc)
    endif()
endif()

ecm_target_qml_sources(MauiKitAccounts${MAUI_MAJOR_VERSION} SOURCES
    controls.${QT_MAJOR_VERSION}/AccountsDialog.qml
    controls.${QT_MAJOR_VERSION}/AccountsMenuItem.qml
    controls.${QT_MAJOR_VERSION}/CredentialsDialog.qml)

target_sources(MauiKitAccounts${MAUI_MAJOR_VERSION}
    PRIVATE
    ${sources})

add_library(MauiKit${MAUI_MAJOR_VERSION}::Accounts ALIAS MauiKitAccounts${MAUI_MAJOR_VERSION})

if (QT_MAJOR_VERSION STREQUAL "5")
    if(QUICK_COMPILER)
        target_sources(MauiKitAccounts${MAUI_MAJOR_VERSION} PRIVATE ${accounts_QML_QRC})

        add_definitions(-DQUICK_COMPILER)
        target_compile_definitions(MauiKitAccounts${MAUI_MAJOR_VERSION} PUBLIC QUICK_COMPILER)
    endif()
endif()

generate_export_header(MauiKitAccounts${MAUI_MAJOR_VERSION} BASE_NAME Accounts)
set_target_properties(MauiKitAccounts${MAUI_MAJOR_VERSION} PROPERTIES
    VERSION ${PROJECT_VERSION}
    SOVERSION ${PROJECT_VERSION_MAJOR}
    EXPORT_NAME "Accounts")

target_include_directories(MauiKitAccounts${MAUI_MAJOR_VERSION}
    INTERFACE "$<INSTALL_INTERFACE:${KDE_INSTALL_INCLUDEDIR}/MauiKit${MAUI_MAJOR_VERSION}/Accounts>")

target_include_directories(MauiKitAccounts${MAUI_MAJOR_VERSION} PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR};${CMAKE_CURRENT_BINARY_DIR};>")

if(ANDROID)
    target_link_libraries(MauiKitAccounts${MAUI_MAJOR_VERSION} PRIVATE Qt${QT_MAJOR_VERSION}::AndroidExtras)
endif()

target_link_libraries(MauiKitAccounts${MAUI_MAJOR_VERSION}
    PRIVATE
    Qt${QT_MAJOR_VERSION}::Core
    Qt${QT_MAJOR_VERSION}::Quick
    Qt${QT_MAJOR_VERSION}::Qml
    Qt${QT_MAJOR_VERSION}::Sql
    Qt${QT_MAJOR_VERSION}::Network
    KF${KF_MAJOR_VERSION}::I18n
    MauiKit${MAUI_MAJOR_VERSION})

ecm_finalize_qml_module(MauiKitAccounts${MAUI_MAJOR_VERSION} DESTINATION ${KDE_INSTALL_QMLDIR})
ecm_generate_qmltypes(org.mauikit.accounts 3.0 DESTINATION ${KDE_INSTALL_QMLDIR}/org/mauikit/accounts)

install(TARGETS MauiKitAccounts${MAUI_MAJOR_VERSION} EXPORT MauiKitAccounts${MAUI_MAJOR_VERSION}Targets ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})

install(FILES
    ${headers}
    ${CMAKE_CURRENT_BINARY_DIR}/accounts_export.h
    DESTINATION ${KDE_INSTALL_INCLUDEDIR}/MauiKit${MAUI_MAJOR_VERSION}/Accounts
    COMPONENT Devel)
