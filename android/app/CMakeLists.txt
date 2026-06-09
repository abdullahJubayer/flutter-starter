cmake_minimum_required(VERSION 3.10.2)

project(native_bridge)

# Add the C++ source file as a shared library
add_library(native_bridge SHARED
    ../../src/native_bridge.cpp
)

# Specify target link libraries (standard Android logging library)
target_link_libraries(native_bridge
    android
    log
)
