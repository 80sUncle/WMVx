vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ladislav-zezula/CascLib
    REF 5dafc4c5a53faecfe269e525d37cf977cfa818b1
    SHA512 9a60b7ef82e8b8a6ddfcb7d635bc9a51ec2cc57e87ae488b8d94da6fce0b11213bf67d9bb9a34922b0300d33103d5658696e8ebe96bf1275d47d68d250b8c249
    HEAD_REF master
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" CASC_BUILD_SHARED_LIB)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" CASC_BUILD_STATIC_LIB)

set(CASC_UNICODE ON)

# if(VCPKG_TARGET_IS_WINDOWS)
#     message(STATUS "This version of CascLib is built in ASCII mode. To switch to UNICODE version, create an overlay port of this with CASC_UNICODE set to ON.")
#     message(STATUS "This recipe is at ${CMAKE_CURRENT_LIST_DIR}")
#     message(STATUS "See the overlay ports documentation at https://github.com/microsoft/vcpkg/blob/master/docs/specifications/ports-overlay.md")
# endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DCMAKE_REQUIRE_FIND_PACKAGE_ZLIB=ON
        -DCASC_BUILD_SHARED_LIB=${CASC_BUILD_SHARED_LIB}
        -DCASC_BUILD_STATIC_LIB=${CASC_BUILD_STATIC_LIB}
        -DCASC_UNICODE=${CASC_UNICODE}
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/CascLib)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)