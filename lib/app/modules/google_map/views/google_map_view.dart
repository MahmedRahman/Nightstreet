import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/google_map_search_bar_view.dart';
import 'package:krzv2/utils/app_colors.dart';

import '../controllers/google_map_controller.dart';

class GoogleMapView extends GetView<GoogleMapViewController> {
  GoogleMapView({Key? key}) {
    controller.enableLocationService();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      30.102727490953757,
      31.326486542329327,
    ),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: GoogleMapSearchBarView(
        textEditingController: TextEditingController(),
        onSearchIconTapped: () {},
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          controller.obx((_) {
            return GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              markers: Set.from(controller.markers.value!),
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController mapController) {
                controller.mapController.complete(mapController);
              },
              onTap: (LatLng tappedLocation) {
                controller.onMapTap(tappedLocation);
                controller.update();
              },
            );
          }),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 40,
              right: 20,
              left: 20,
            ),
            child: CustomBtnCompenent.main(
              text: "بحث",
              onTap: () async {
                print('con => ${controller.currentLocation.value}');
                Get.back(result: controller.currentLocation.value);
              },
            ),
          ),
          GetBuilder<GoogleMapViewController>(
            builder: (controller) {
              if (controller.address.value.isEmpty) return SizedBox();
              return Positioned(
                top: kToolbarHeight * 1.8,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white.withOpacity(0.8),
                  ),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    child: Text(
                      '${controller.address.value}',
                      key: Key(
                        '${controller.address.value}',
                      ),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.blackColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          onPressed: () {
            controller.enableLocationService();
          },
          child: Icon(Icons.my_location),
          backgroundColor: AppColors.mainColor,
        ),
      ),
    );
  }
}
