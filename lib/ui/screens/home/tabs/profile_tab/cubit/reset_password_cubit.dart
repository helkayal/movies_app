import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/secure_storage_utils.dart';
import 'package:movies_app/data/datasources/Api/profile_api_service.dart';
import 'package:movies_app/data/datasources/profile/profile_data_source_impl.dart';
import 'package:movies_app/data/repositories/profile_repository/profile_repository_impl.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/reset_password_states.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordStates> {
  ResetPasswordCubit() : super(ResetPasswordIntial());

  Future<ProfileRepositoryImpl> _initRepository() async {
    String? token = await SecureStorageUtils().getToken();

    if (token == null) {
      throw Exception("No token found, please login again");
    }
    final apiService = ProfileApiService(token: token);
    final dataSource = ProfileDataSourceImpl(apiService);
    return ProfileRepositoryImpl(dataSource);
  }

  Future<void> resetPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(PasswordResetLoading());
    try {
      final repository = await _initRepository();
      await repository.resetPassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      emit(PasswordResetSuccess());
    } catch (e) {
      final errorMessage = e.toString().replaceFirst("Exception: ", "");
      emit(PasswordResetError(errorMessage));
    }
  }
}
