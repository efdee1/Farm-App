import 'package:body1/pages/home_page.dart';
import 'package:body1/pages/login_signUp_page.dart';
import 'file:///C:/Users/owner/AndroidStudioProjects/Mercy.Records/lib/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null){
      return LoginSignUpPage();
    }else{
      return HomePage();
    }
  }
}
