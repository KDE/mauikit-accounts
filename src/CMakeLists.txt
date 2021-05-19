# SPDX-FileCopyrightText: 2020 Carl Schwan <carl@carlschwan.eu>
#
# SPDX-License-Identifier: BSD-2-Clause

ecm_create_qm_loader(mauikitaccounts_QM_LOADER libmauikitaccountsplugin_qt)

set(
    sources
    code/mauikitaccounts_plugin.cpp   
    code/mauiaccounts.cpp
    code/accountsdb.cpp
    code/accounts.qrc
    resources.qrc
    ${mauikitaccounts_QM_LOADER}
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

ecm_generate_qmltypes(org.mauikit.accounts ${PROJECT_VERSION}
                      DESTINATION ${KDE_INSTALL_QMLDIR}/org/mauikit/accounts)

add_library(
    MauiKitAccounts
    SHARED
    ${sources} ${pluginData}
)

add_library(MauiKit::Accounts ALIAS MauiKitAccounts)

generate_export_header(MauiKitAccounts BASE_NAME MauiKitAccounts)
set_target_properties(MauiKitAccounts PROPERTIES
    VERSION ${MauiKitAccounts_VERSION_STRING}
    SOVERSION ${MauiKitAccounts_SOVERSION}
    EXPORT_NAME MauiKitAccounts
)
    
target_include_directories(MauiKitAccounts
    INTERFACE "$<INSTALL_INTERFACE:${KDE_INSTALL_INCLUDEDIR}/MauiKit/Accounts>")
    
target_include_directories(MauiKitAccounts PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR};${CMAKE_CURRENT_BINARY_DIR};>")

if(ANDROID)
    target_link_libraries(MauiKitAccounts PRIVATE Qt5::AndroidExtras )

elseif(UNIX)
    target_link_libraries(
        MauiKitAccounts

        PRIVATE
        KF5::ConfigCore
        KF5::KIOCore
        KF5::KIOFileWidgets
        )
endif()

target_link_libraries(
    MauiKitAccounts
       
    PRIVATE
        Qt5::Core
        Qt5::Quick
        Qt5::Qml
        Qt5::Sql
        Qt5::Concurrent
        Qt5::Network
        KF5::I18n
        MauiKit
)

install(TARGETS MauiKitAccounts EXPORT MauiKitAccountsTargets ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})

install(FILES
    ${headers} 
    ${CMAKE_CURRENT_BINARY_DIR}/mauikitaccounts_export.h
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
