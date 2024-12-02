import 'package:dio_clean_architecture/components/common_button.dart';
import 'package:dio_clean_architecture/helpers/colors_helper.dart';
import 'package:dio_clean_architecture/helpers/dimesns_helper.dart';
import 'package:dio_clean_architecture/helpers/font_helper.dart';
import 'package:dio_clean_architecture/helpers/string_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/login/login_cubit.dart';
import '../../utils/loading_indicator.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsHelper.primaryColor,
        title: const Text(StringHelper.logIn),
      ),


      body: Padding(
        padding: const EdgeInsets.only(top: DimensHelper.dimens_20, left: DimensHelper.dimens_20, right: DimensHelper.dimens_20),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: StringHelper.enterEmail),
            ),

            const SizedBox(height: DimensHelper.dimens_10,),

            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: StringHelper.enterPassword),
            ),

            const SizedBox(height: DimensHelper.dimens_20,),


          BlocProvider(
            create: (BuildContext context) => LoginCubit(),
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return CommonButton(
                    onPress: (){
                      context.read<LoginCubit>().userLogin(emailController.text.toString(), passwordController.text.toString(), context);
                    },
                    child: state is LoginLoading? loadingIndicator(): const Text(StringHelper.logIn, style: TextStyle(color: ColorsHelper.whiteColor, fontSize: FontHelper.dimens_18),));
              }
            ),
          )
          ],
        ),
      ),
    );
  }
}
