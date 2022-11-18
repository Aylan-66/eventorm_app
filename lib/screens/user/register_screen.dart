import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eventorm_app/common_widgets/app_text.dart';
import 'package:eventorm_app/helpers/column_with_seprator.dart';
import 'package:eventorm_app/styles/colors.dart';

class registerScreen extends StatefulWidget {

  const registerScreen({Key? key}) : super(key: key);

  @override
  registerScreenState createState() => registerScreenState();

}

class registerScreenState extends State<registerScreen> {

  var formkey;
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //fetch data from API
    postUser();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  postUser() async{
    print(myController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter name',
              labelText: "sah",
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter name',
              labelText: "sah",
            ),
          ),
          TextFormField(
            controller: myController,
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter name',
              labelText: "sah",
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter name',
              labelText: "sah",
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 150, top: 40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                postUser();
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            "oe"
                        )
                    ),
                  );
                }
              },
              child: Text('ElevatedButton with custom foreground/background'),
            )

          )
        ],
      ),
    );
  }
}