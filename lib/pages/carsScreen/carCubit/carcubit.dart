import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/allCarsmodel.dart';
import '../../../network/remote/dio_Helper.dart';
import '../../../shared/Components/components.dart';
import '../../../shared/constants/constants.dart';
import 'carStates.dart';

class CarCubit extends Cubit<CarStates> {
  CarCubit() : super(CarInitialState());
  static CarCubit get(context) => BlocProvider.of(context);
  late VehiclesModel vehiclemodel;
  void getCars() {
    DioHelper.getData(
      url: 'http://192.168.234.142:4242/vehicles/$ssn',
      token: token,
    ).then((value) {
      vehiclemodel = VehiclesModel.fromJson(value.data);
      emit(CarSucccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CarErrorState(error));
    });
  }
}
