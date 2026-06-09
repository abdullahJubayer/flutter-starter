#!/bin/bash

# Exit immediately if any command fails
set -e

# Base directories
WORKSPACE_DIR="$(pwd)"
SRC_FILE="$WORKSPACE_DIR/src/native_bridge.cpp"
BUILD_DIR="$WORKSPACE_DIR/build/ios_native"
OUTPUT_XCFRAMEWORK="$WORKSPACE_DIR/ios/Runner/native_bridge.xcframework"

echo "=== Starting Native C++ Build for iOS ==="

# 1. Setup build directory
echo "Cleaning up old build files..."
rm -rf "$BUILD_DIR"
rm -rf "$OUTPUT_XCFRAMEWORK"
mkdir -p "$BUILD_DIR"

# 2. Get SDK paths
echo "Fetching iOS SDK paths..."
IPHONEOS_SDK_PATH=$(xcrun --sdk iphoneos --show-sdk-path)
IPHONESIMULATOR_SDK_PATH=$(xcrun --sdk iphonesimulator --show-sdk-path)

echo "iPhoneOS SDK: $IPHONEOS_SDK_PATH"
echo "iPhoneSimulator SDK: $IPHONESIMULATOR_SDK_PATH"

# Minimum deployment target
MIN_IOS_VERSION="12.0"

# 3. Compile source code to object files for different architectures with explicit targets
echo "Compiling for iOS Device (arm64)..."
xcrun -sdk iphoneos clang++ \
  -target arm64-apple-ios$MIN_IOS_VERSION \
  -isysroot "$IPHONEOS_SDK_PATH" \
  -O3 -c "$SRC_FILE" \
  -o "$BUILD_DIR/native_bridge_device.o"

echo "Compiling for iOS Simulator (arm64)..."
xcrun -sdk iphonesimulator clang++ \
  -target arm64-apple-ios$MIN_IOS_VERSION-simulator \
  -isysroot "$IPHONESIMULATOR_SDK_PATH" \
  -O3 -c "$SRC_FILE" \
  -o "$BUILD_DIR/native_bridge_sim_arm64.o"

echo "Compiling for iOS Simulator (x86_64)..."
xcrun -sdk iphonesimulator clang++ \
  -target x86_64-apple-ios$MIN_IOS_VERSION-simulator \
  -isysroot "$IPHONESIMULATOR_SDK_PATH" \
  -O3 -c "$SRC_FILE" \
  -o "$BUILD_DIR/native_bridge_sim_x86_64.o"

# 4. Create static libraries (.a) in separate subfolders using the same filename
mkdir -p "$BUILD_DIR/device"
mkdir -p "$BUILD_DIR/simulator"

echo "Creating static library for iOS Device..."
libtool -static -o "$BUILD_DIR/device/libnative_bridge.a" "$BUILD_DIR/native_bridge_device.o"

echo "Creating static library for iOS Simulator (Universal arm64/x86_64)..."
libtool -static -o "$BUILD_DIR/simulator/libnative_bridge.a" "$BUILD_DIR/native_bridge_sim_arm64.o" "$BUILD_DIR/native_bridge_sim_x86_64.o"

# 5. Create XCFramework
echo "Creating XCFramework..."
xcodebuild -create-xcframework \
  -library "$BUILD_DIR/device/libnative_bridge.a" \
  -library "$BUILD_DIR/simulator/libnative_bridge.a" \
  -output "$OUTPUT_XCFRAMEWORK"

echo "=== Build Complete! ==="
echo "XCFramework created at: $OUTPUT_XCFRAMEWORK"
