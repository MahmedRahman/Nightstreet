import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as place;
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/models/map_prediction_model.dart';
import 'package:krzv2/services/permissions_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapViewController extends GetxController with StateMixin {
  Rx<LatLng> currentLocation = LatLng(0, 0).obs;
  var hasPermission = false.obs;

  // GoogleMapController? mapController;
  loc.Location location = loc.Location();

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  final markers = Rx<List<Marker>?>([]);

  List<Prediction> _predictionList = [];
  RxString address = ''.obs;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());

    // enableLocationService();
  }

  Future<void> enableLocationService() async {
    try {
      final serviceEnabled = await _checkAndEnableLocationService();

      if (serviceEnabled) {
        final loc.LocationData? locationData = await getCurrentLocation();

        currentLocation.value = LatLng(
          locationData!.latitude!,
          locationData.longitude!,
        );

        addMarker(currentLocation.value);

        getAddressFromLatLng(currentLocation.value);
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        showEnableLocationServiceDialog();
      } else {
        // Handle other exceptions if needed.
      }
    }
  }

  Future<bool> _checkAndEnableLocationService() async {
    final serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      return await location.requestService();
    }
    return true;
  }

  Future<loc.LocationData?> getCurrentLocation() async {
    loc.LocationData? locationData;
    try {
      locationData = await location.getLocation();
    } catch (e) {
      if (e.toString().contains('PERMISSION_DENIED') == true) {
        openAppSettings();
      }
    }
    return locationData;
  }

  Future getAddressFromLatLng(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    address.value = '${placemarks.first.name} - ${placemarks.first.country}';

    update();
  }

  Future<void> showEnableLocationServiceDialog() async {
    final confirmed = await Get.defaultDialog(
      title: 'Location Service Required',
      middleText:
          'To use this feature, you need to enable location services in your device settings.',
      textConfirm: 'Open Settings',
      textCancel: 'Cancel',
      barrierDismissible: false,
      onCancel: () => Get.back(),
      onConfirm: () => openLocationServiceSettings,
      buttonColor: AppColors.mainColor,
      confirmTextColor: Colors.white,
    );

    if (confirmed) {}
  }

  Future<void> openLocationServiceSettings() async {
    if (await canLaunchUrl(Uri.parse('app-settings:'))) {
      await launchUrl(Uri.parse('app-settings:'));
    } else {
      // If the above method doesn't work, you can try a direct URL for iOS settings.
      await launchUrl(Uri.parse('app-settings:location'));
    }
  }

  Future<BitmapDescriptor> getCustomMarkerIcon(
      String iconPath, double size) async {
    final ByteData data = await rootBundle.load(iconPath);
    final List<int> iconBytes = data.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(Uint8List.fromList(iconBytes),
        size: Size(size, size));
  }

  addMarker(LatLng location) async {
    markers.value!.clear();

    // Create a custom marker icon with the specified size
    BitmapDescriptor customIcon = await getCustomMarkerIcon(
      'assets/image/marker.png',
      10,
    );

    CameraPosition cPosition = CameraPosition(
      zoom: 15,
      bearing: 5,
      target: LatLng(
        double.parse(location.latitude.toString()),
        double.parse(location.longitude.toString()),
      ),
    );
    final GoogleMapController? controller = await mapController.future;
    controller!.animateCamera(CameraUpdate.newCameraPosition(cPosition));

    markers.value!.add(
      Marker(
        markerId: MarkerId(DateTime.now().toString()), // Unique marker ID
        position: location,
        icon: customIcon,
      ),
    );
    update();
  }

  void onMapTap(LatLng tappedLocation) {
    currentLocation.value = tappedLocation;

    addMarker(currentLocation.value);
    getAddressFromLatLng(currentLocation.value);
  }

  Future<List<Prediction>> searchLocation({
    required String searchQuery,
  }) async {
    if (searchQuery.isEmpty) return [];
    ResponseModel responseModel =
        await WebServices().googleMapPlace(searchQuery: searchQuery);

    if (responseModel.data["status"] == 'OK') {
      _predictionList = [];
      final List<Prediction> fetchedList = List<Prediction>.from(
        responseModel.data['predictions']
            .map((category) => Prediction.fromJson(category)),
      );
      _predictionList.addAll(fetchedList);
    } else {
      AppDialogs.errorDialog(msg: 'حدث خطأ حاول مرة أخرى');
    }

    return _predictionList;
  }

  Future<void> displayPrediction(Prediction? prediction) async {
    if (prediction != null) {
      place.GoogleMapsPlaces _places = place.GoogleMapsPlaces(
        apiKey: 'AIzaSyBiCU45NaS8NgadKJcIfFLY_CUu_IF2E9Y',
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      place.PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(prediction.placeId);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      address.value = prediction.description;

      currentLocation.value = LatLng(lat, lng);

      addMarker(currentLocation.value);
    }
  }

  bool shouldWatchFocus = false;
  askPermissionAndGetCurrentLocation({
    bool? forceNavigateToSettingIfDenied = false,
  }) async {
    final locationStatus = await PermissionsHelper.requestLocationPermission();

    shouldWatchFocus = false;
    print('locationStatus $locationStatus');

    if (locationStatus == PermissionStatus.granted) {
      final loc.LocationData? locationData = await location.getLocation();

      currentLocation.value = LatLng(
        locationData!.latitude!,
        locationData.longitude!,
      );

      update();
      return;
    }

    print('forceNavigateToSettingIfDenied $forceNavigateToSettingIfDenied');
    print('locationStatus $locationStatus');

    if (locationStatus == PermissionStatus.permanentlyDenied &&
        forceNavigateToSettingIfDenied == true) {
      print('start get location');
      try {
        AppDialogs.locationPermissionDialog(
          onTap: () async {
            shouldWatchFocus = true;
            await Geolocator.openLocationSettings();
            Get.back();
          },
        );
      } catch (e, st) {
        print('eee $e');
        print('stac $st');
      }
    }
  }
}
