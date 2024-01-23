import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_ninja/src/data/repositories/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository = SettingsRepository();
  SettingsBloc() : super(SettingsInitial()) {
    on<Logout>((event, emit) async {
      emit(LogoutInProgress());
      try {
        await settingsRepository.logout();
        emit(LogoutSuccess());
      } catch (e) {
        emit(LogoutFailure());
      }
    });
  }
}
