# Install script for directory: /home/greek_fire/.git/content/products/rhel9

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
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

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/xml/scap/ssg/content" TYPE FILE FILES "/home/greek_fire/.git/content/build/ssg-rhel9-xccdf.xml")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/xml/scap/ssg/content" TYPE FILE FILES "/home/greek_fire/.git/content/build/ssg-rhel9-oval.xml")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/xml/scap/ssg/content" TYPE FILE FILES "/home/greek_fire/.git/content/build/ssg-rhel9-ocil.xml")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/xml/scap/ssg/content" TYPE FILE FILES "/home/greek_fire/.git/content/build/ssg-rhel9-cpe-dictionary.xml")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/xml/scap/ssg/content" TYPE FILE FILES "/home/greek_fire/.git/content/build/ssg-rhel9-cpe-oval.xml")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/xml/scap/ssg/content" TYPE FILE FILES "/home/greek_fire/.git/content/build/ssg-rhel9-ds.xml")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  
        file(GLOB GUIDE_FILES "/home/greek_fire/.git/content/build/guides/ssg-rhel9-*.html") 

        if(NOT IS_ABSOLUTE share/doc/scap-security-guide/guides)
            file(INSTALL DESTINATION "/usr/local/share/doc/scap-security-guide/guides"
                TYPE FILE FILES ${GUIDE_FILES})
        else()
            file(INSTALL DESTINATION "share/doc/scap-security-guide/guides"
                TYPE FILE FILES ${GUIDE_FILES})
        endif()
        
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  
            file(GLOB ROLE_FILES "/home/greek_fire/.git/content/build/ansible/rhel9-playbook-*.yml") 

            if(NOT IS_ABSOLUTE share/scap-security-guide/ansible)
                file(INSTALL DESTINATION "/usr/local/share/scap-security-guide/ansible"
                    TYPE FILE FILES ${ROLE_FILES})
            else()
                file(INSTALL DESTINATION "share/scap-security-guide/ansible"
                    TYPE FILE FILES ${ROLE_FILES})
            endif()
            
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  
            file(GLOB ROLE_FILES "/home/greek_fire/.git/content/build/bash/rhel9-script-*.sh") 

            if(NOT IS_ABSOLUTE share/scap-security-guide/bash)
                file(INSTALL DESTINATION "/usr/local/share/scap-security-guide/bash"
                    TYPE FILE FILES ${ROLE_FILES})
            else()
                file(INSTALL DESTINATION "share/scap-security-guide/bash"
                    TYPE FILE FILES ${ROLE_FILES})
            endif()
            
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/scap-security-guide/kickstart" TYPE FILE FILES
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-anssi_bp28_enhanced-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-anssi_bp28_high-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-anssi_bp28_intermediary-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-anssi_bp28_minimal-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-bsi-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-ccn_advanced-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-ccn_basic-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-ccn_intermediate-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-cis-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-cis_server_l1-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-cis_workstation_l1-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-cis_workstation_l2-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-cui-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-e8-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-hipaa-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-ism_o-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-ospp-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-pci-dss-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-stig-ks.cfg"
    "/home/greek_fire/.git/content/products/rhel9/kickstart/ssg-rhel9-stig_gui-ks.cfg"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/doc/scap-security-guide/tables" TYPE FILE FILES "/home/greek_fire/.git/content/build/tables/table-rhel9-cces.html")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/doc/scap-security-guide/tables" TYPE FILE FILES "/home/greek_fire/.git/content/build/tables/table-rhel9-srgmap.html")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/doc/scap-security-guide/tables" TYPE FILE FILES "/home/greek_fire/.git/content/build/tables/table-rhel9-srgmap-flat.html")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/doc/scap-security-guide/tables" TYPE FILE FILES "/home/greek_fire/.git/content/build/tables/table-rhel9-stig.html")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/doc/scap-security-guide/tables" TYPE FILE FILES "/home/greek_fire/.git/content/build/tables/table-rhel9-stig-testinfo.html")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/doc/scap-security-guide/tables" TYPE FILE FILES "/home/greek_fire/.git/content/build/tables/table-rhel9-stig_gui-testinfo.html")
endif()

