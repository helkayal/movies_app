import 'package:movies_app/core/utils/constants/imports.dart';

class TryScreen extends StatefulWidget {
  final int movieId;
  const TryScreen({super.key, required this.movieId});

  @override
  State<TryScreen> createState() => _TryScreenState();
}

class _TryScreenState extends State<TryScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().add(GetMovieDetails(movieId: widget.movieId));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.read<MovieBloc>().add(FetchMoviesEvent());
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
    );
  }
}