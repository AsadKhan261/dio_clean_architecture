import 'dart:io';
import 'package:dio_clean_architecture/components/common_button.dart';
import 'package:dio_clean_architecture/helpers/dimesns_helper.dart';
import 'package:dio_clean_architecture/helpers/font_helper.dart';
import 'package:dio_clean_architecture/models/user_profile.dart';
import 'package:dio_clean_architecture/utils/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../cubit/change_profile/change_profile_cubit.dart';
import '../../cubit/user_profile/user_profile_cubit.dart';
import '../../helpers/colors_helper.dart';
import '../../helpers/storage_helper.dart';
import '../../helpers/string_helper.dart';
import '../auth_screens/login_screens.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  File? file;
  @override
  void initState() {
   context.read<UserProfileCubit>().userProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsHelper.primaryColor,
        title: const Text(StringHelper.changeProfile),

        actions: [
          IconButton(onPressed: (){
            StorageHelper().clear();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LogInScreen()));
          }, icon: const Icon(Icons.logout))
        ],
      ),


      body: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if(state is UserProfileLoading){
            return Center(child: loadingIndicator(color: ColorsHelper.secondaryColor),);
          }else if (state is UserProfileError){
            return const Center(child: Text(StringHelper.somethingWentWrong),);
          }else if (state is UserProfileLoaded){
            return contentWidget(state.userProfileModel);
          }
          return const SizedBox();
        }
      ),
    );
  }

  Widget contentWidget (UserProfileModel userProfileModel){
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20),
        child: Column(
          children: [
            GestureDetector(
              onTap: ()async{
                ImagePicker imagePicker = ImagePicker();

                XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

                if(image != null){
                  setState(() {
                    file = File(image.path);
                  });
                }
              },
              child: file == null?
              Container(
                margin: const EdgeInsets.symmetric(vertical: DimensHelper.dimens_20),
                height: DimensHelper.dimens_150,
                width: DimensHelper.dimens_150,
                alignment: Alignment.bottomRight,
                decoration:  BoxDecoration(
                    color: ColorsHelper.primaryColor,
                    shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(StorageHelper().getProfileImage()))
                ),
                child: const CircleAvatar(
                  backgroundColor: ColorsHelper.primaryColor,
                  child: Icon(Icons.image),
                ),
              ):
              Container(
                margin: const EdgeInsets.symmetric(vertical: DimensHelper.dimens_20),
                height: DimensHelper.dimens_150,
                width: DimensHelper.dimens_150,
                decoration:  BoxDecoration(
                    color: ColorsHelper.primaryColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(file!))
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("${StringHelper.name}: ",
                  style: TextStyle(color: ColorsHelper.blackColor, fontSize: FontHelper.dimens_20, fontWeight: FontHelper.medium),),

                Text(userProfileModel.name??"",
                  style: const TextStyle(color: ColorsHelper.blackColor, fontSize: FontHelper.dimens_20, fontWeight: FontHelper.regular),),
              ],
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("${StringHelper.email}: ",
                  style: TextStyle(color: ColorsHelper.blackColor, fontSize: FontHelper.dimens_20, fontWeight: FontHelper.medium),),

                Text(userProfileModel.email??"",
                  style: const TextStyle(color: ColorsHelper.blackColor, fontSize: FontHelper.dimens_20, fontWeight: FontHelper.regular),),
              ],
            ),


            const SizedBox(height: DimensHelper.dimens_20,),

            Visibility(
              visible: file == null? false:true,
              child: BlocProvider(
                create: (BuildContext context) => ChangeProfileCubit(),
                child: BlocConsumer<ChangeProfileCubit, ChangeProfileState>(
                  listener: (context, state){
                    if(state is ChangeProfileLoaded){
                      StorageHelper().setProfileImage(state.changeProfileModel.location??"");
                      file = null;
                      setState(() {});
                    }
                  },
                  builder: (context, state) {
                    return CommonButton(
                        onPress: (){
                          if(state is ChangeProfileLoading){

                          }else{
                            context.read<ChangeProfileCubit>().changeProfile(file!);
                          }
                        },
                        child: state is ChangeProfileLoading? loadingIndicator(): const Text(StringHelper.save, style: TextStyle(color: ColorsHelper.whiteColor, fontSize: FontHelper.dimens_18),));
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
