# Install script for directory: /mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/linux

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/llvm-objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  
  file(REMOVE_RECURSE "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/")
  
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/real8_wallet" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/real8_wallet")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/real8_wallet"
         RPATH "$ORIGIN/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/real8_wallet")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle" TYPE EXECUTABLE FILES "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/intermediates_do_not_run/real8_wallet")
  if(EXISTS "$ENV{DESTDIR}/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/real8_wallet" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/real8_wallet")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/real8_wallet"
         OLD_RPATH "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/plugins/flutter_secure_storage_linux:/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/linux/flutter/ephemeral:"
         NEW_RPATH "$ORIGIN/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/llvm-strip" "$ENV{DESTDIR}/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/real8_wallet")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/data/icudtl.dat")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/data" TYPE FILE FILES "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/linux/flutter/ephemeral/icudtl.dat")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/lib/libflutter_linux_gtk.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/lib" TYPE FILE FILES "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/linux/flutter/ephemeral/libflutter_linux_gtk.so")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/lib/libflutter_secure_storage_linux_plugin.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/lib" TYPE FILE FILES "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/plugins/flutter_secure_storage_linux/libflutter_secure_storage_linux_plugin.so")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/lib/")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/lib" TYPE DIRECTORY FILES "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/native_assets/linux/")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  
  file(REMOVE_RECURSE "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/data/flutter_assets")
  
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/data/flutter_assets")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/bundle/data" TYPE DIRECTORY FILES "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build//flutter_assets")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/flutter/cmake_install.cmake")
  include("/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/runner/cmake_install.cmake")
  include("/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/plugins/flutter_secure_storage_linux/cmake_install.cmake")

endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
if(CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_COMPONENT MATCHES "^[a-zA-Z0-9_.+-]+$")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
  else()
    string(MD5 CMAKE_INST_COMP_HASH "${CMAKE_INSTALL_COMPONENT}")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INST_COMP_HASH}.txt")
    unset(CMAKE_INST_COMP_HASH)
  endif()
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/mnt/data/WebDes/REAL8/000/Wallets/Grok/real8-stellar-wallet/build/linux/x64/debug/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
