import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/widgets/white.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            Text(
        
        'Settings',
        style: TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal),
            

      ),
      SizedBox(height: 50,),
            ListTile(
              leading: Icon(
                Icons.privacy_tip_sharp,
                color: Colors.white,
              ),
              title: Text(
                'Privacy Policy',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_right, color: Colors.white),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => WhiteScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_support, color: Colors.white),
              title: Text(
                'About our App',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_right, color: Colors.white),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => WhiteScreen()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.contact_mail_sharp,
                color: Colors.white,
              ),
              title: Text(
                'About Us',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_right, color: Colors.white),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => WhiteScreen()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.help_outline_outlined,
                color: Colors.white,
              ),
              title: Text(
                'Help',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_right, color: Colors.white),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => WhiteScreen()));
              },
            ),
          ]),
        ),
      ),
    );
  }
}
