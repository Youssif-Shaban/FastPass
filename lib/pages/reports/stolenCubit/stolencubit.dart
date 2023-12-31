import 'package:fastpass/pages/reports/stolenCubit/stolenStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/stolenCars.dart';
import '../../../network/remote/dio_Helper.dart';
import '../../../shared/Components/components.dart';
import '../../../shared/constants/constants.dart';

class StolenCubit extends Cubit<StolenStates> {
  StolenCubit() : super(StolenInitialState());

  static StolenCubit get(context) => BlocProvider.of(context);

  late StolenVehiclesModel stolenmodel;

  void getStolenCars() {
    DioHelper.getData(
      url:
          'http://192.168.234.142:4242/vehicles/$ssn/userstolencars', //localhost:4242/vehicles/30012012300977/userstolencars
      // query: {'is_stolen': 'stolen'},
      token: token,
    ).then((value) {
      stolenmodel = StolenVehiclesModel.fromJson(value.data);
      emit(StolenSucccessState());
    }).catchError((error) {
      print(error.toString());
      emit(StolenErrorState(error));
    });
  }
}
