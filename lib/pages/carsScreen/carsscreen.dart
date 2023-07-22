import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fastpass/pages/carsScreen/vDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/allCarsmodel.dart';
import '../../network/remote/dio_Helper.dart';
import '../../shared/Components/components.dart';
import '../../shared/constants/constants.dart';
import '../fine/finesCubit/fineStates.dart';
import 'carCubit/carStates.dart';
import 'carCubit/carcubit.dart';

class CarsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CarCubit.get(context).getCars();

    VehiclesModel vmodel;
    //FineCubit.get(context).getTransactions();
    return BlocConsumer<CarCubit, CarStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Cars"),
            elevation: 0,
            leading: Container(
              width: 10,
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
                  // SizedBox(
                  //   height: 30,
                  // ),
                  // Container(
                  //   color: Colors.teal,
                  //   child: ElevatedButton(
                  //       onPressed: () {
                  //         CarCubit.get(context).getCars();
                  //       },
                  //       child: Text(
                  //         "Reload",
                  //       )),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  if (state is CarLoadingState) LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is CarSucccessState)
                    Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VDetail(
                                                  vv: CarCubit.get(context)
                                                      .vehiclemodel
                                                      .vehicles[index],
                                                )));
                                  },
                                  child: buildVehicleItem(
                                      CarCubit.get(context)
                                          .vehiclemodel
                                          .vehicles[index],
                                      context),
                                ),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: CarCubit.get(context)
                                .vehiclemodel
                                .vehicles
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

Widget buildVehicleItem(Vehicles vmodel, context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.all(20),
            height: 210,
            width: 380,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CAR OWNER ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                        Text(
                          '$user_name',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          vmodel.vehicleId,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Expire Data",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              vmodel.licenseExpiredDate,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Model",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              vmodel.manufacturer,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
