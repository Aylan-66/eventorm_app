import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eventorm_app/common_widgets/app_text.dart';
import 'package:eventorm_app/helpers/column_with_seprator.dart';
import 'package:eventorm_app/styles/colors.dart';
import 'package:eventorm_app/services/user.dart';
import 'package:eventorm_app/models/user_response.dart';
import 'package:eventorm_app/screens/user/login_screen.dart';

import '../user/register_screen.dart';
import 'account_item.dart';

class AccountScreen extends StatefulWidget  {

  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Users? users;
  Status? status;
  final storage = new FlutterSecureStorage();
  String? jwt;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    setAccount();
  }

  setAccount() async{
    print("object");
    jwt = await storage.read(key: "jwt");

    var result = await RemoteServiceU().isLogged();

    if(result[1] == 200) {
      users = result[0];
    } else {
      status = result[0];
    }

    if (users != null) {
      print(users);
      setState(() {
        isLoaded = true;
      });
    }
  }

  logOut() async{
    await RemoteServiceU().logOut();
    setState(() {
      isLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child : Visibility(
            visible: isLoaded,
            replacement: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text("Account", style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: getChildrenWithSeperator(
                    widgets: accountItemsLogout.map((e) {
                      return getAccountItemLogoutWidget(e);
                    }).toList(),
                    seperator: Divider(
                      thickness: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                loginButton(context)
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading:
                  SizedBox(width: 65, height: 65, child: getImageHeader()),
                  title: Text(
                    users?.data?.data?.user?.firstname ?? "Not logged in",
                    style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Laissez la musique vous guider",
                    style: TextStyle(color: Color(0xff7C7C7C),
                      fontWeight: FontWeight.normal,
                      fontSize: 16,),
                  ),
                ),
                Column(
                  children: getChildrenWithSeperator(
                    widgets: accountItems.map((e) {
                      return getAccountItemWidget(e);
                    }).toList(),
                    seperator: Divider(
                      thickness: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                logoutButton(),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              elevation: 0.0,
              // padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  "   Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Container()
              ],
            ),
            onPressed: () {
              onLoginClicked(context);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              elevation: 0.0,
             // padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  "   Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Container()
              ],
            ),
            onPressed: () {
              onRegisterClicked(context);
            },
          ),
        ],
      ),
    );
  }

  Widget logoutButton() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          elevation: 0.0,
          // padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              "Log Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            Container()
          ],
        ),
        onPressed: () {
          logOut();
        },
      ),
    );
  }

  Widget getImageHeader() {
    String imagePath = "assets/images/yopar.png";
    return CircleAvatar(
      radius: 5.0,
      backgroundImage: AssetImage(imagePath),
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
    );
  }

  Widget getAccountItemWidget(AccountItem accountItem) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              accountItem.iconPath,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            accountItem.label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }

  Widget getAccountItemLogoutWidget(AccountItemLogout accountItem) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              accountItem.iconPath,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            accountItem.label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }

  void onLoginClicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => loginScreen()),
    );
  }

  void onRegisterClicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => registerScreen()),
    );
  }
}
