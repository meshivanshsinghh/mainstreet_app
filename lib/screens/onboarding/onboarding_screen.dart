import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mainstreet/common/common_colors.dart';
import 'package:mainstreet/common/common_style.dart';
import 'package:mainstreet/helpers/app_preferences.dart';
import 'package:mainstreet/screens/auth/sign_in_selection_screen.dart';
import 'package:mainstreet/screens/onboarding/slides_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late int _currentPage;
  List<SlidesModel> _slides = [];
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    _currentPage = 0;
    _slides = [
      SlidesModel(
        description:
            "Explore your neighborhood's best eats, shops, and hidden gems. Discover what's trending on your MainStreet!",
        image: 'assets/onboarding/onboarding_second_screen.png',
        title: 'Discover',
      ),
      SlidesModel(
        description:
            'Meet like-minded neighbors, share recommendations, and join in on local events and experiences.',
        image: 'assets/onboarding/onboarding_first_screen.png',
        title: 'Connect',
      ),
      SlidesModel(
        description:
            'Never miss a beat! Get exclusive deals, snag tickets to the hottest events, and make the most of your city.',
        image: 'assets/onboarding/onboarding_third_screen.png',
        title: 'Experience',
      ),
    ];
    _pageController = PageController(
      initialPage: _currentPage,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handlingPageChanged(int page) {
    if (mounted) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  Widget _buildPageIndicator() {
    final row = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ..._slides.asMap().keys.map((e) => _buildPageIndicatorItem(e))
      ],
    );
    return row;
  }

  Widget _buildPageIndicatorItem(int index) {
    return Container(
      width: index == _currentPage ? 10 : 10,
      height: index == _currentPage ? 10 : 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == _currentPage
            ? CommonColors.primaryColor
            : CommonColors.onboardingUnselectedDotsColor,
      ),
      margin: const EdgeInsets.only(right: 8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.whiteColor,
      body: SafeArea(
        bottom: true,
        top: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: _slides.length,
                controller: _pageController,
                onPageChanged: _handlingPageChanged,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  SlidesModel slidesModel = _slides[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top,
                          ),
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(slidesModel.image),
                        ),
                        const SizedBox(height: 50),
                        Text(
                          slidesModel.title,
                          style: CommonStyle.getInterFont(
                            fontWeight: FontWeight.w600,
                            fontSize: 35,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          slidesModel.description,
                          style: CommonStyle.getInterFont(
                            fontWeight: FontWeight.w400,
                            color: CommonColors.onboardingDescriptionColor,
                            fontSize: 14,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage == 0 || _currentPage == 1
                      ? TextButton(
                          onPressed: () {
                            setOnBoardingDone();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SignInSelectionScren(),
                              ),
                            );
                          },
                          child: Text(
                            'Skip',
                            style: CommonStyle.getInterFont(
                              fontWeight: FontWeight.w600,
                              color: CommonColors.onboardingDescriptionColor,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            setOnBoardingDone();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SignInSelectionScren(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CommonColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Get started',
                                style: CommonStyle.getInterFont(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                FontAwesomeIcons.arrowRight,
                                color: Colors.white,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                  _buildPageIndicator(),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
          ],
        ),
      ),
    );
  }

  void setOnBoardingDone() async {
    final appPreferences = AppPreferences();
    await appPreferences.setOnboarding();
  }
}
