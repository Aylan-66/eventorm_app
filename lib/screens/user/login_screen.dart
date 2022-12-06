import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eventorm_app/models/user.dart';
import 'package:eventorm_app/services/user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eventorm_app/common_widgets/app_text.dart';
import 'package:eventorm_app/helpers/column_with_seprator.dart';
import 'package:eventorm_app/styles/colors.dart';

class loginScreen extends StatefulWidget {

  const loginScreen({Key? key}) : super(key: key);

  @override
  loginScreenState createState() => loginScreenState();

}

class loginScreenState extends State<loginScreen> {

  var formkey;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  User? user;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    //fetch data from API
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  postUserEn() async{

    await RemoteServiceU().loginUser(userToJson( User(
        email: emailController.text,
        password: passwordController.text
    )));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text("login",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)
        ),
        bottom: PreferredSize(
            child: Container(
              color: Colors.grey,
              height: 1,
            ),
            preferredSize: Size.fromHeight(7.0)),
      ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        focusColor: AppColors.primaryColor,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey, width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey, width: 1.5),
                                        ),
                                        border: OutlineInputBorder(),
                                        icon: Icon(
                                            Icons.mail,
                                            color: AppColors.primaryColor,
                                        ),
                                        hintText: 'Enter email',
                                        labelText: "Email",
                                        floatingLabelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 20,

                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal
                                        ),

                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                        obscureText: !_passwordVisible,
                                      decoration: InputDecoration(
                                          focusColor: AppColors.primaryColor,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey, width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey, width: 1.5),
                                          ),
                                          border: OutlineInputBorder(),
                                          icon: Icon(
                                            Icons.password,
                                            color: AppColors.primaryColor,
                                          ),
                                        hintText: 'Enter password',
                                        labelText: "Password",
                                        floatingLabelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20,

                                        ),
                                        labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            // Based on passwordVisible state choose the icon
                                            _passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            // Update the state i.e. toogle the state of passwordVisible variable
                                            setState(() {
                                              _passwordVisible = !_passwordVisible;
                                            });
                                          },
                                        ),

                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 240, top: 40),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.primaryColor
                                            ),
                                            onPressed: () {

                                              if (_formKey.currentState!.validate()) {
                                                postUserEn();
                                                // If the form is valid, display a snackbar. In the real world,
                                                // you'd often call a server or save the information in a database.
                                                ScaffoldMessenger.of(context).showSnackBar(

                                                  const SnackBar(
                                                      content: Text(
                                                          "Precessing data"
                                                      )
                                                  ),
                                                );
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: SvgPicture.asset(
                                                    "assets/icons/account_icons/logout_icon.svg",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "   Submit",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                Container()
                                              ],
                                            )

                                        ))
                                  ],
                                ),
                              ),
                            ]
                        ),
                      ),

                    ]
                )
            )
        )
    );

  }
}