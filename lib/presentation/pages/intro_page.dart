import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_work_test_app/core/constants/constants_asset.dart';
import 'package:todo_work_test_app/core/constants/constants_text.dart';
import 'package:todo_work_test_app/core/style/style_color.dart';
import 'package:todo_work_test_app/core/style/style_text.dart';
import 'package:todo_work_test_app/presentation/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  static const introPage = "into_page";
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                ConstantsAsset.imglogoApp,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              const Gap(24),
              Text(
                ConstantText.welcomeTo,
                style: h3Reguler(),
              ),
              Text(
                ConstantText.myTodo,
                style: h3Bold(),
              ),
              const Gap(6),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.15),
                child: Text(
                  ConstantText.discriptionTodo,
                  style: b3Reguler(),
                  textAlign: TextAlign.center,
                ),
              ),
              const Gap(40),
              MaterialButton(
                elevation: 0,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, HomePage.homePage);
                },
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 16),
                color: Colors.blue.shade50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Text(
                  ConstantText.tryDemo,
                  style: b3Medium(colorText: CustomColor.primary800),
                ),
              ),
              const Gap(20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  ConstantText.nothanks,
                  style: b3Medium(colorText: CustomColor.primary800),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
