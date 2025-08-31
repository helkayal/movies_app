import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/repositories/onboarding/onboarding_repository.dart';
import 'package:movies_app/ui/screens/on_boarding/cubit/onboarding_states.dart';
import 'package:movies_app/ui/screens/on_boarding/model/onboarding_dm.dart';
import 'package:movies_app/ui/utils/app_assets.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepository repository;

  final List<OnboardingDataModel> _pages = [
    OnboardingDataModel(
      image: AppAssets.onBoarding1,
      title: "Discover Movies",
      desc:
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
    ),
    OnboardingDataModel(
      image: AppAssets.onBoarding2,
      title: "Explore All Genres",
      desc:
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
    ),
    OnboardingDataModel(
      image: AppAssets.onBoarding3,
      title: "Create Watchlists",
      desc:
          "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
    ),
    OnboardingDataModel(
      image: AppAssets.onBoarding4,
      title: "Rate, Review, and Learn",
      desc:
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    ),
    OnboardingDataModel(
      image: AppAssets.onBoarding5,
      title: "Start Watching Now",
      desc: "",
    ),
  ];

  int _currentPage = 0;

  List<OnboardingDataModel> get pages => _pages;
  int get currentPage => _currentPage;

  OnboardingCubit(this.repository)
    : super(OnboardingInitial(currentPage: 0, pages: [])) {
    emit(OnboardingInitial(currentPage: _currentPage, pages: _pages));
  }

  void setPage(int index) {
    _currentPage = index;
    emit(OnboardingInitial(currentPage: _currentPage, pages: _pages));
  }

  void nextPage() {
    if (_currentPage < _pages.length - 1) {
      _currentPage++;
      emit(OnboardingNextPage(_currentPage));
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      emit(OnboardingPreviousPage(_currentPage));
    }
  }

  Future<void> finishOnboarding() async {
    await repository.setOnboardingCompleted();
    emit(OnboardingFinished());
  }
}
