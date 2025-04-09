import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:podlove_flutter/constants/app_widgets.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/providers/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';
import 'package:podlove_flutter/utils/logger.dart';

class EnterLocation extends ConsumerStatefulWidget {
  const EnterLocation({super.key});

  @override
  ConsumerState<EnterLocation> createState() => _EnterLocationState();
}

class _EnterLocationState extends ConsumerState<EnterLocation> {
  final _locationController = TextEditingController();
  double _latitude = 0.0;
  double _longitude = 0.0;

  @override
  void initState() {
    super.initState();
    _locationController.addListener(_locationControllerListener);
  }

  void _locationControllerListener() {
    // Check if the text length is 0 (cross button pressed)
    if (_locationController.text.isEmpty) {
      setState(() {
        _latitude = 0.0;
        _longitude = 0.0;
      });
    }
  }

  @override
  void dispose() {
    _locationController.removeListener(_locationControllerListener);
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.enterLocationTitle, isLeading: true),
      backgroundColor: AppColors.backgroundAlt,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w)
                .copyWith(top: 20.h, bottom: 44.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Center(
                  child: Column(
                    children: [
                      // Logo
                      AppWidgets.podLoveLogo,
                      SizedBox(height: 25.h),
                      CustomText(
                        text: AppStrings.enterLocationHeader,
                        color: AppColors.primaryText,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
                GooglePlaceAutoCompleteTextField(
                  textEditingController: _locationController,
                  googleAPIKey: "AIzaSyAszXC1be8aJ37eHuNcBm_-O1clWkPUwV4",
                  inputDecoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                  debounceTime: 50,
                  countries: ["us"],
                  isLatLngRequired: true,
                  getPlaceDetailWithLatLng: (Prediction prediction) {
                    _latitude = double.parse(prediction.lat!);
                    _longitude = double.parse(prediction.lng!);
                  },
                  textInputAction: TextInputAction.done,
                  itemClick: (Prediction prediction) {
                    _locationController.text = prediction.description!;
                    _locationController.selection = TextSelection.fromPosition(
                        TextPosition(offset: prediction.description!.length));
                    FocusScope.of(context).unfocus();
                  },
                  itemBuilder: (context, index, Prediction prediction) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 7),
                          Expanded(child: Text(prediction.description ?? ""))
                        ],
                      ),
                    );
                  },
                  seperatedBuilder: Divider(),
                  isCrossBtnShown: true,
                  containerHorizontalPadding: 10,
                  placeType: PlaceType.geocode,
                ),
                SizedBox(height: 30.h),
                CustomRoundButton(
                  text: AppStrings.continueButton,
                  onPressed: () {
                    if (_longitude != 0.0 && _latitude != 0.0) {
                      ref.read(userProvider.notifier).updateLocation(
                          _latitude, _longitude, _locationController.text);
                      GoRouter.of(context)
                          .push(RouterPath.distancePreference);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: "Invalid Address",
                            message: "Your address is incorrect. Please provide real address!",
                            contentType: ContentType.failure,
                          ),
                        ),
                      );
                    }

                    logger.i(ref.watch(userProvider)!.user.location.place);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
