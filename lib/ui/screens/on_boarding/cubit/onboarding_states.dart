import '../model/onboarding_dm.dart';

abstract class OnboardingState {
  const OnboardingState();
}

class OnboardingInitial extends OnboardingState {
  final int currentPage;
  final List<OnboardingDataModel> pages;

  const OnboardingInitial({required this.currentPage, required this.pages});
}

class OnboardingNextPage extends OnboardingState {
  final int currentPage;

  const OnboardingNextPage(this.currentPage);
}

class OnboardingPreviousPage extends OnboardingState {
  final int currentPage;

  const OnboardingPreviousPage(this.currentPage);
}

class OnboardingFinished extends OnboardingState {}
