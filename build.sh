rm -rf build
rm -rf derived_data

mkdir build

# Собираем архив для архитектуры iphone

xcodebuild archive \
  -project CardsScanner.xcodeproj \
  -scheme CardsScanner \
  -archivePath build/iphoneos/CardsScanner-iphoneos.xcarchive \
  -sdk iphoneos \
  -derivedDataPath derived_data \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SKIP_INSTALL=NO

# Собираем архив для архитектуры симулятора

 xcodebuild archive \
   -project CardsScanner.xcodeproj \
   -arch x86_64 \
   -scheme CardsScanner \
   -sdk iphonesimulator \
   -archivePath build/simulator/CardsScanner-iphonesimulator.xcarchive \
   -derivedDataPath derived_data \
   BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
   SKIP_INSTALL=NO

# Собираем конечный xcframework со всеми собранными архитектурами

xcodebuild -create-xcframework \
-framework build/simulator/CardsScanner-iphonesimulator.xcarchive/Products/Library/Frameworks/CardsScanner.framework \
 -framework build/iphoneos/CardsScanner-iphoneos.xcarchive/Products/Library/Frameworks/CardsScanner.framework \
 -output build/universal/CardsScanner.xcframework
