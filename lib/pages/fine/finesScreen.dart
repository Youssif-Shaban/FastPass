import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/allTransactions.dart';
import '../../network/remote/dio_Helper.dart';
import '../../shared/Components/components.dart';
import 'fineDetails.dart';
import 'finesCubit/fineCubit.dart';
import 'finesCubit/fineStates.dart';

class FineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FineCubit.get(context).getTransactions();

    TransactionsModel fmodel;
    //FineCubit.get(context).getTransactions();
    return BlocConsumer<FineCubit, FinesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Transactions"),
            elevation: 0,
            leading: Container(
              child: Text(""),
            ),
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
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  if (state is FinesLoadingState) LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is FinesSucccessState)
                    Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => tDetail(
                                                  tt: FineCubit.get(context)
                                                      .finemodel
                                                      .transactions[index],
                                                )));
                                  },
                                  child: buildTrasactionsItem(
                                      FineCubit.get(context)
                                          .finemodel
                                          .transactions[index],
                                      context),
                                ),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: FineCubit.get(context)
                                .finemodel
                                .transactions
                                .length)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildfine(Transactions model, context) => Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        height: 18,
        child: Text(model.vehicle),
      ),
    );

Widget buildTrasactionsItem(Transactions ttmodel, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.only(right: 10),
        height: 180,
        width: 320,
        decoration: BoxDecoration(
          color: Color(0xffF5D7DB),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 20, bottom: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Location: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        ttmodel.place,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Date: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        ttmodel.adjustmentDate,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Time: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        ttmodel.adjustmentTime,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "License: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        ttmodel.vehicle,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Reported Status: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        ttmodel.isReported,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    ttmodel.fine.toString(),
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$",
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
