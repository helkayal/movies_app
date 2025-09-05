import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_bg_image_event.dart';
part 'change_bg_image_state.dart';

class ChangeBgImageBloc extends Bloc<ChangeBgImageEvent, ChangeBgImageState> {
  ChangeBgImageBloc() : super(ChangeBgImageInitial()) {
    on<ChangeBgImage>((event, emit) {
      emit(ChangeBgImageSuccess(event.imagePath));
    });
  }
}
