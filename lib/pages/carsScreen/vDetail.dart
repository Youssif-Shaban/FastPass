import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

import '../../Layout/layoutCubit.dart';
import '../../models/allCarsmodel.dart';
import '../../shared/Components/components.dart';
import '../../shared/constants/constants.dart';

class VDetail extends StatelessWidget {
  late Vehicles vv;

  VDetail({
    Key? key,
    required this.vv,
  }) : super(key: key);

  Future<void> markstolenCar() async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'PATCH',
        Uri.parse(
            'http://192.168.234.142:4242/vehicles/$ssn/${vv.vehicleId}/stolen'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> marksaveCar() async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'PATCH',
        Uri.parse(
            'http://192.168.234.142:4242/vehicles/$ssn/${vv.vehicleId}/safe'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        foregroundColor: Color.fromARGB(255, 7, 7, 7),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
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
              itemProfile('Car License Plate Numbers', vv.vehicleId,
                  CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              itemProfile('License', vv.license, CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              itemProfile('Creation Date', vv.licenseCreateDate,
                  CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              itemProfile('Expire Date', vv.licenseExpiredDate,
                  CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              itemProfile(
                  'Manufacturer', vv.manufacturer, CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              itemProfile('Model', vv.model, CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              itemProfile('Color', vv.color, CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              itemProfile(
                  'is stolen', vv.isStolen, CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 30,
              ),
              if (vv.isStolen == "safe")
                Container(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      onPressed: () {
                        markstolenCar();
                      },
                      child: Text(
                        "Stolen",
                      )),
                ),
              if (vv.isStolen == "stolen")
                Container(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      onPressed: () {
                        marksaveCar();
                      },
                      child: Text(
                        "Safe",
                      )),
                ),
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
