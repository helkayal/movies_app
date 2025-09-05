
import 'package:movies_app/core/utils/constants/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onScreenTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(FetchMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.yellow),
            );
          } else if (state is MovieSuccess) {
            final movieList = state.movies.data?.movies;
            final List<Widget> screens = [
              HomeTab(movie: movieList!),
              SearchTab(movie: movieList),
              CategoryTab(movie: movieList),
              BlocProvider(
                create: (_) => FavouriteCubit(),
                child: ProfileTab(movie: movieList),
              ),
            ];
            return _buildHomeBody(screens);
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.props.toString(),style: AppTextStyles.whiteRegular16,),
                IconButton(
                  onPressed: () {
                    setState(() {
                      ApiService.getMovies();
                    });
                  },
                  icon: Icon(Icons.refresh_rounded, color: AppColors.lightGrey),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Scaffold _buildHomeBody(List<Widget> screens) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: screens[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(horizontal: 34, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.darkGrey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                _onScreenTab(0);
              },
              child: Image.asset(
                AppAssets.homeIcon,
                color: _selectedIndex == 0 ? AppColors.yellow : AppColors.white,
              ),
            ),
            InkWell(
              onTap: () {
                _onScreenTab(1);
              },
              child: Image.asset(
                AppAssets.searchIcon,
                color: _selectedIndex == 1 ? AppColors.yellow : AppColors.white,
              ),
            ),
            InkWell(
              onTap: () {
                _onScreenTab(2);
              },
              child: Image.asset(
                AppAssets.categoryIcon,
                color: _selectedIndex == 2 ? AppColors.yellow : AppColors.white,
              ),
            ),
            InkWell(
              onTap: () {
                _onScreenTab(3);
              },
              child: Image.asset(
                AppAssets.profile,
                color: _selectedIndex == 3 ? AppColors.yellow : AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
