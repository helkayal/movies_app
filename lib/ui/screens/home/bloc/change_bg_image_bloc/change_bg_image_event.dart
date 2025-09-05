part of 'change_bg_image_bloc.dart';

sealed class ChangeBgImageEvent extends Equatable {
  const ChangeBgImageEvent();

  @override
  List<Object> get props => [];
}

class ChangeBgImage extends ChangeBgImageEvent{
  final String imagePath;
  const ChangeBgImage(this.imagePath);
  @override
  // TODO: implement props
  List<Object> get props => [imagePath];
}
