import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../../Layout/layoutScreen.dart';
import '../../Login/login.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/Components/components.dart';
import '../../shared/constants/constants.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ssn = CacheHelper.getData(key: 'ssn');
    user_name = CacheHelper.getData(key: 'user_name');
    user_mail = CacheHelper.getData(key: 'user_mail');
    user_phone = CacheHelper.getData(key: 'user_phone');
    user_address = CacheHelper.getData(key: 'user_address');
    user_job = CacheHelper.getData(key: 'user_job');
    user_nationality = CacheHelper.getData(key: 'user_nationality');
    print(ssn);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.teal,
                Color.fromARGB(255, 6, 127, 174),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/logo.png'),
              ),
              SizedBox(
                height: 30,
              ),
              itemProfile('Name', '$user_name', CupertinoIcons.person),
              SizedBox(
                height: 30,
              ),
              itemProfile(
                  'Email Address', '$user_mail', CupertinoIcons.mail_solid),
              SizedBox(
                height: 30,
              ),
              itemProfile('National Number', '$ssn', CupertinoIcons.person),
              SizedBox(
                height: 30,
              ),
              itemProfile('Nationality', '$user_nationality',
                  CupertinoIcons.placemark_fill),
              SizedBox(
                height: 30,
              ),
              itemProfile(
                  'Address', '$user_address', CupertinoIcons.placemark_fill),
              SizedBox(
                height: 30,
              ),
              itemProfile(
                  'Job', '$user_job', CupertinoIcons.person_alt_circle_fill),
              SizedBox(
                height: 30,
              ),
              itemProfile('Mobile Phone', '$user_phone',
                  CupertinoIcons.phone_circle_fill),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    CacheHelper.deleteItem(key: "user_mail");
                    CacheHelper.deleteItem(key: 'user_nationality');
                    CacheHelper.deleteItem(key: 'user_phone');
                    CacheHelper.deleteItem(key: 'user_address');
                    CacheHelper.deleteItem(key: 'user_job');
                    CacheHelper.deleteItem(key: 'user_name');
                    CacheHelper.deleteItem(key: 'token').then((value) {
                      if (value) {
                        navigateTo(context, LoginScreen());
                      }
                    });
                  },
                  child: Text(
                    "Sign Out",
                  )),
            ],
          ),
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Colors.blue.withOpacity(.2),
              spreadRadius: 3,
              blurRadius: 10,
            ),
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: Colors.white,
      ),
    );
  }
}
