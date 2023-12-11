flutter clean
flutter pub get
flutter build apk --release
cd ..
cd "$(pwd)/build/app/outputs/flutter-apk"
mv app-release.apk Krz2.apk
open .