import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:action_slider/action_slider.dart';
import 'package:workspace/core/utils/app_colors.dart';
import 'package:workspace/core/utils/app_images.dart';
import 'package:workspace/core/components/app_text.dart';
import 'package:workspace/core/components/app_snack_bar.dart';
import 'package:workspace/core/service/location_service.dart';
import 'package:workspace/features/home/cubit/home_cubit.dart';
import 'package:workspace/features/home/service/home_service.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ActionSlider.standard(
              width: MediaQuery.of(context).size.width,
              sliderBehavior: SliderBehavior.move,
              backgroundColor: AppColors.primary,
              toggleColor: Colors.white,
              boxShadow: const [],
              icon: SvgPicture.asset(AppImages.arrow),
              action: (controller) {
                _punch(state: state, context: context, controller: controller);
              },
              child: Center(
                child: CommonText(
                  state.punchedIn == true
                      ? '   Swipe Left to Punch Out'
                      : '   Swipe Right to Punch In',
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _punch({
    required HomeState state,
    required BuildContext context,
    required ActionSliderController controller,
  }) async {
    controller.loading();
    final isPunchIn = state.punchedIn ?? false;
    final location = await LocationService().getMyLocation();
    final result = await HomeService().punchIn(
      isPunchIn: isPunchIn,
      address: location?.fullAddress,
      latitude: location?.latitude?.toString(),
      longitude: location?.longitude?.toString(),
    );
    result.fold(
      (l) {
        controller.failure();
        controller.reset();
        Navigator.pop(context);
        AppSnackBar.show(context, l);
      },
      (r) {
        controller.success();
        controller.reset();
        context.read<HomeCubit>().punch(!isPunchIn);
        Navigator.pop(context);
        AppSnackBar.show(context, r);
      },
    );
  }
}
