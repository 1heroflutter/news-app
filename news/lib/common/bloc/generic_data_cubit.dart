import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/bloc/generic_data_state.dart';
import 'package:news/core/usecase/usecase.dart';

class GenericDataCubit extends Cubit<GenericDataState> {
  GenericDataCubit() : super(DataLoading());

  void getData<T>(UseCase useCase, {dynamic params}) async {
    var returnedData = await useCase.call(params: params);
    returnedData.fold(
      (error) {
        emit(FailureLoadData(errorMessage: error));
      },
      (data) {
        emit(DataLoaded(data: data));
      },
    );
  }
}
