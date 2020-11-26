import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rappelle_moi/palette.dart';
import 'package:rappelle_moi/screens/home-page.dart';
import 'package:rappelle_moi/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      child: Center(
                        child: Text(
                          'Sante+',
                          style: kHeading,
                        ),
                      ),
                    ),
                    SizedBox(height: 100,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          TextInput(
                            icon: Icons.vpn_key,//FontAwesomeIcons.key,
                            hint: 'Code',
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.done,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child:  RoundedButton(
                        buttonText: 'Login',
                        onPressed:()=> Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage())),
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            )
        )
      ],
    );
  }
}