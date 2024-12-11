import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subul_g1_todo_app/resources/icons.dart';
import 'package:subul_g1_todo_app/resources/text_styles.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            landingBackgroundImage,
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 73,
                ),
                Text(
                  'Do your\n tasks\n quickly\n and easy',
                  style: AppTextStyles.titleLarge,
                ),
                Text(
                  'Your tasks, your rules, our support.',
                  style: AppTextStyles.bodyLarge
                      .copyWith(fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 99,
                ),
                Center(
                    child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Login'),
                )),
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      'Create an account',
                      style: AppTextStyles.bodySmall.copyWith(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(0xff000000).withOpacity(0.2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'OR',
                        style: AppTextStyles.bodyMedium
                            .copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xff000000).withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(faceBookIcon),
                    SizedBox(
                      width: 30,
                    ),
                    SvgPicture.asset(googleIcon),
                    SizedBox(
                      width: 30,
                    ),
                    SvgPicture.asset(appleIcon),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
