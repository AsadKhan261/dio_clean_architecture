import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/current_location/current_location_cubit.dart';
import '../../helpers/colors_helper.dart';
import '../../helpers/dimesns_helper.dart';
import '../../utils/loading_indicator.dart';


class CurrentLocationButton extends StatelessWidget {
  final bool isPreviousScreenHome;
  const CurrentLocationButton({super.key, required this.isPreviousScreenHome});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CurrentLocationCubit(),
      child: BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: (){
                context.read<CurrentLocationCubit>().getCurrentLocation(context,isPreviousScreenHome );
              },
              child: Container(
                margin: const EdgeInsets.only(left: DimensHelper.dimens_10),
                height: DimensHelper.dimens_50,
                width: DimensHelper.dimens_50,
                decoration: const BoxDecoration(
                    color: ColorsHelper.secondaryColor,
                    shape: BoxShape.circle
                ),
                child: state is CurrentLocationLoading? loadingIndicator(): const Icon(Icons.my_location, color: ColorsHelper.whiteColor,),
              ),
            );
          }
      ),
    );
  }
}
