import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/google_map/controllers/google_map_controller.dart';
import 'package:krzv2/models/map_prediction_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class LocationSearchDialogView extends GetView {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return SizedBox(
      height: 40,
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: _controller,
          textInputAction: TextInputAction.search,
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                AppSvgAssets.searchIcon,
              ),
            ),
            hintText: "ابحث أو حرك الخريطة",
            border: outlineBorder(),
            focusedBorder: outlineBorder(),
            enabledBorder: outlineBorder(),
            hintStyle: TextStyle(
              fontSize: 16.0,
              color: AppColors.greyColor,
              height: .8,
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
          ),
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 20,
              ),
        ),
        suggestionsCallback: (pattern) async {
          return await Get.find<GoogleMapViewController>()
              .searchLocation(searchQuery: pattern);
        },
        itemBuilder: (context, Prediction suggestion) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Row(children: [
              Icon(Icons.location_on),
              Expanded(
                child: Text(
                  suggestion.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 20,
                      ),
                ),
              ),
            ]),
          );
        },
        onSuggestionSelected: (Prediction suggestion) {
          Get.find<GoogleMapViewController>().displayPrediction(suggestion);
        },
      ),
    );
  }

  OutlineInputBorder outlineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: AppColors.borderColor2,
      ),
    );
  }
}
