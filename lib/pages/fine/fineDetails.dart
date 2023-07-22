import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fastpass/pages/fine/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Layout/layoutCubit.dart';
import '../../models/allTransactions.dart';
import '../../network/remote/dio_Helper.dart';
import '../../shared/Components/components.dart';
import '../../shared/constants/constants.dart';

import 'package:http/http.dart' as http;

import 'finesCubit/fineCubit.dart';

class tDetail extends StatelessWidget {
  late Transactions tt;

  tDetail({
    Key? key,
    required this.tt,
  }) : super(key: key);

  Future<void> transactionreport() async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'PATCH',
        Uri.parse(
            'http://192.168.234.142:4242/transactions/$ssn/report/${tt.transactionId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> LaunchURL(String url) async {
    final Uri uri = Uri(host: url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw " can not launch url";
    }
  }

  @override
  Widget build(BuildContext context) {
    var cc = FineCubit.get(context).finemodel.transactions;

    String session_url;

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
              itemProfile('Car License Plate Numbers',
                  tt.transactionId.toString(), CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              itemProfile('License', tt.vehicle, CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              itemProfile('Creation Date', tt.fine.toString(),
                  CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              itemProfile(
                  'Expire Date', tt.paymentStatus, CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              itemProfile(
                  'Manufacturer', tt.place, CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              itemProfile(
                  'Model', tt.adjustmentDate, CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              itemProfile(
                  'Color', tt.adjustmentTime, CupertinoIcons.car_detailed),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  onPressed: () {
                    transactionreport();
                  },
                  child: Text(
                    "Report",
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  onPressed: () {
                    // print(${widget.tt.transactionId});
                    DioHelper.getData(
                      url:
                          'http://192.168.234.142:4242/transactions/$ssn/checkout-session/${tt.transactionId}',
                      //      localhost:4242/transactions/30012012300977/checkout-session/102
                    ).then((value) {
                      session_url = value.data['url'];
                      navigateTo(context, PaymentWebWiew(session_url));
                      print('your seeion url $session_url');
                    }).catchError((error) {
                      print(error.toString());
                    });
                  },
                  child: Text(
                    "Pay",
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
