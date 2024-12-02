import 'package:dio_clean_architecture/helpers/storage_helper.dart';
import 'package:dio_clean_architecture/models/auto_complete_places.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auto_complete_places/auto_complete_places_cubit.dart';
import '../../helpers/colors_helper.dart';
import '../../helpers/dimesns_helper.dart';
import '../../helpers/string_helper.dart';
import '../home_screen/home_screen.dart';
import 'current_location_button.dart';

class LocationScreen extends StatefulWidget {
  final bool isPreviousScreenHome;
  const LocationScreen({super.key, required this.isPreviousScreenHome});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  AutoCompletePlace autoCompletePlace = AutoCompletePlace();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsHelper.primaryColor,
        title: const Text(StringHelper.location),
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: DimensHelper.dimens_20, left: DimensHelper.dimens_20, right: DimensHelper.dimens_20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: StringHelper.enterPlace),
                    onChanged: (String value){
                      context.read<AutoCompletePlacesCubit>().autoCompletePlaces(value);
                    },
                  ),
                ),
                 CurrentLocationButton(isPreviousScreenHome: widget.isPreviousScreenHome,),
              ],
            ),


            BlocConsumer<AutoCompletePlacesCubit, AutoCompletePlacesState>(
              listener: (context, state){
                if(state is AutoCompletePlacesLoaded){
                  autoCompletePlace = state.autoCompletePlace;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: autoCompletePlace.results?.length??0,
                    itemBuilder: (context, index){
                      return ListTile(
                        onTap: (){
                          if(widget.isPreviousScreenHome){
                            Map params = {
                              'lat': autoCompletePlace.results?[index].latitude??0.0,
                              'lng': autoCompletePlace.results?[index].longitude??0.0};

                            Navigator.pop(context, params);

                          }else{
                            StorageHelper().setUserLat(autoCompletePlace.results?[index].latitude??0.0);
                            StorageHelper().setUserLng(autoCompletePlace.results?[index].longitude??0.0);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
                          }

                        },
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.location_on),
                        title: Text(autoCompletePlace.results?[index].name??""),
                        subtitle: Text(autoCompletePlace.results?[index].country??""),
                      );
                    });

              }
            )
          ],
        ),
      ),
    );
  }
}
