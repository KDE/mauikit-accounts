# SPDX-FileCopyrightText: 2020 Carl Schwan <carl@carlschwan.eu>
#
# SPDX-License-Identifier: BSD-2-Clause

set(
    sources
    code/accounts_plugin.cpp
    code/mauiaccounts.cpp
    code/accountsdb.cpp
    code/accounts.qrc
)

set(
    headers
    code/mauiaccounts.h
    code/accountsdb.h
)

set(
    pluginData
    controls/qmldir
)

if(QUICK_COMPILER)
    qtquick_compiler_add_resources(accounts_QML_QRC resources.qrc)
else()
    qt5_add_resources(accounts_QML_QRC resources.qrc)
endif()

ecm_generate_qmltypes(org.mauikit.accounts ${PROJECT_VERSION} DESTINATION ${KDE_INSTALL_QMLDIR}/org/mauikit/accounts)

add_library(
    MauiKitAccounts
    SHARED
    ${sources}
    ${accounts_QML_QRC}
)

add_library(MauiKit::Accounts ALIAS MauiKitAccounts)

generate_export_header(MauiKitAccounts BASE_NAME Accounts)
set_target_properties(MauiKitAccounts PROPERTIES
    VERSION ${Accounts_VERSION_STRING}
    SOVERSION ${Accounts_SOVERSION}
    EXPORT_NAME Accounts
    )

target_include_directories(MauiKitAccounts
    INTERFACE "$<INSTALL_INTERFACE:${KDE_INSTALL_INCLUDEDIR}/MauiKit/Accounts>")

target_include_directories(MauiKitAccounts PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR};${CMAKE_CURRENT_BINARY_DIR};>")

if(ANDROID)
    target_link_libraries(MauiKitAccounts PRIVATE Qt5::AndroidExtras )
endif()

target_link_libraries(
    MauiKitAccounts

    PRIVATE
        Qt5::Core
        Qt5::Quick
        Qt5::Qml
        Qt5::Sql
        Qt5::Network
        KF5::I18n
        MauiKit
)

install(TARGETS MauiKitAccounts EXPORT MauiKitAccountsTargets ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})

install(FILES
    ${headers}
    ${CMAKE_CURRENT_BINARY_DIR}/accounts_export.h
    DESTINATION ${KDE_INSTALL_INCLUDEDIR}/MauiKit/Accounts
    COMPONENT Devel)

if (BUILD_SHARED_LIBS)
    add_custom_target(copy_to_bin ALL
        COMMAND ${CMAKE_COMMAND} -E
                make_directory ${CMAKE_BINARY_DIR}/bin/org/mauikit/accounts/
        COMMAND ${CMAKE_COMMAND} -E
                copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/controls ${CMAKE_BINARY_DIR}/bin/org/mauikit/accounts/
        COMMAND ${CMAKE_COMMAND} -E
                copy $<TARGET_FILE:MauiKitAccounts> ${CMAKE_BINARY_DIR}/bin/org/mauikit/accounts/
    )

    install(DIRECTORY controls/ DESTINATION ${KDE_INSTALL_QMLDIR}/org/mauikit/accounts)

    #include(ECMGeneratePriFile)
    #ecm_generate_pri_file(BASE_NAME KQuickImageEditor LIB_NAME KQuickImageEditor DEPS "core qml quick svg" FILENAME_VAR PRI_FILENAME )
    #install(FILES ${PRI_FILENAME}
            #DESTINATION ${ECM_MKSPECS_INSTALL_DIR})

endif()

install(TARGETS MauiKitAccounts DESTINATION ${KDE_INSTALL_QMLDIR}/org/mauikit/accounts )
