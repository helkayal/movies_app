import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/datasources/onbording/onborading_ds_impl.dart';
import 'package:movies_app/data/repositories/onboarding/onboarding_repository_impl.dart';
import 'package:movies_app/ui/screens/on_boarding/cubit/onboarding_cubit.dart';
import 'package:movies_app/ui/screens/on_boarding/cubit/onboarding_states.dart';
import 'package:movies_app/ui/utils/app_colors.dart';
import 'package:movies_app/ui/utils/app_routes.dart';
import 'package:movies_app/ui/utils/app_text_styles.dart';
import 'package:movies_app/ui/widgets/custom_button.dart';

class Onboarding extends StatelessWidget {
  Onboarding({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OnboardingCubit(OnboardingRepositoryImpl(OnboardingDataSourceImpl())),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingNextPage ||
              state is OnboardingPreviousPage ||
              state is OnboardingInitial) {
            _pageController.jumpToPage(
              context.read<OnboardingCubit>().currentPage,
            );
          } else if (state is OnboardingFinished) {
            Navigator.pushReplacement(context, AppRoutes.login);
          }
        },
        builder: (context, state) {
          final cubit = context.read<OnboardingCubit>();
          final pages = cubit.pages;
          final currentPage = cubit.currentPage;

          return SafeArea(
            child: Scaffold(
              body: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: cubit.setPage,
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(page.image),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Spacer(),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                Text(
                                  page.title,
                                  style: AppTextStyles.whiteBold24,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  page.desc,
                                  style: AppTextStyles.whiteRegular20,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                CustomButton(
                                  text: currentPage == pages.length - 1
                                      ? "Finish"
                                      : "Next",
                                  textStyle: AppTextStyles.blackSemiBold20,
                                  onClick: () {
                                    if (currentPage == pages.length - 1) {
                                      context
                                          .read<OnboardingCubit>()
                                          .finishOnboarding();
                                    } else {
                                      cubit.nextPage();
                                    }
                                  },
                                ),
                                if (currentPage > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: CustomButton(
                                      text: "Back",
                                      textStyle: AppTextStyles.blackSemiBold20,
                                      backgroundColor: AppColors.black,
                                      textColor: AppColors.yellow,
                                      onClick: cubit.previousPage,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
