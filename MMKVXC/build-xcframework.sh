set -euo pipefail
PROJ="Pods/Pods.xcodeproj"
SCHEME="MMKV"
VERSION="1.3.14"

rm -rf MMKVXC.xcworkspace
rm -rf Pods/
rm -rf MMKV.xcframework
rm -rf MMKVCore.xcframework
rm -rf build/

pod install --repo-update

# iOS devices
xcodebuild archive \
  -project "$PROJ" \
  -scheme "$SCHEME" \
  -configuration Release \
  -destination 'generic/platform=iOS' \
  -archivePath build/MMKV-iOS.xcarchive \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SKIP_INSTALL=NO \
  ENABLE_BITCODE=NO

# iOS simulators
xcodebuild archive \
  -project "$PROJ" \
  -scheme "$SCHEME" \
  -configuration Release \
  -destination 'generic/platform=iOS Simulator' \
  -archivePath build/MMKV-Sim.xcarchive \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SKIP_INSTALL=NO \
  ENABLE_BITCODE=NO

xcodebuild -create-xcframework \
  -archive build/MMKV-iOS.xcarchive -framework MMKV.framework \
  -archive build/MMKV-Sim.xcarchive -framework MMKV.framework \
  -output build/MMKV.xcframework

xcodebuild -create-xcframework \
  -archive build/MMKV-iOS.xcarchive -framework MMKVCore.framework \
  -archive build/MMKV-Sim.xcarchive -framework MMKVCore.framework \
  -output build/MMKVCore.xcframework

ditto -c -k --sequesterRsrc --keepParent \
    build/MMKV.xcframework \
    build/MMKV-$VERSION.xcframework.zip

ditto -c -k --sequesterRsrc --keepParent \
    build/MMKVCore.xcframework \
    build/MMKVCore-$VERSION.xcframework.zip

echo "MMKV-$VERSION.xcframework.zip checksum:"
swift package compute-checksum build/MMKV-$VERSION.xcframework.zip
echo "MMKVCore-$VERSION.xcframework.zip checksum:"
swift package compute-checksum build/MMKVCore-$VERSION.xcframework.zip