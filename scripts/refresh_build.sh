cd ..
cd ios
rm -rf Pods
rm Podfile.lock
cd ..
flutter clean
flutter pub get
cd ios
pod install
