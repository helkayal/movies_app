part of 'change_bg_image_bloc.dart';

sealed class ChangeBgImageState extends Equatable {
  const ChangeBgImageState();

  @override
  List<Object> get props => [];
}

final class ChangeBgImageInitial extends ChangeBgImageState {}

final class ChangeBgImageSuccess extends ChangeBgImageState {
  final String imagePath;
  const ChangeBgImageSuccess(this.imagePath);
  @override
  List<Object> get props => [imagePath];
}
