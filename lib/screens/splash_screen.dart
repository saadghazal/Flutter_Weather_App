import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:know_weather/blox_and_cubit/climate_cubit/climate_cubit.dart';
import 'package:know_weather/screens/home_screen.dart';
import 'package:know_weather/theme/colors.dart';
import 'package:get/get.dart';

import '../services/local_storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  late final Animation<Offset> _sunAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(1.5, 0),
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticIn,
    ),
  );

  bool isSearch = false;
  bool isGetStarted = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1, milliseconds: 200),
    )..addListener(
        () {
          if (animationController.status == AnimationStatus.completed) {
            setState(
              () {
                isSearch = true;
                animationController.reverse();
              },
            );
          }
        },
      );
    initSplash();
  }

  Future<void> initSplash() async {
    final isGettingStarted = await LocalStorageService.getGettingStarted();
    if (isGettingStarted) {
      await context.read<ClimateCubit>().getUserWeather();
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.offAllNamed(HomeScreen.routeName);
        },
      );
    } else {
      await context.read<ClimateCubit>().getUserWeather();

      Future.delayed(
        const Duration(seconds: 1),
        () {
          setState(
            () {
              isGetStarted = true;
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SlideTransition(
          position: _sunAnimation,
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                isSearch ? 'assets/icons/search.png' : 'assets/icons/sun.png',
                height: 150,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                isSearch ? 'Search Weather' : 'Know Weather',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              isSearch
                  ? const Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Search for the weather when\never you want',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  : const SizedBox(),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  bottom: bottomPadding == 0 ? 20 : bottomPadding + 20,
                ),
                child: AnimatedOpacity(
                  opacity: isGetStarted ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: GestureDetector(
                    onTap: () {
                      if (isSearch) {
                        LocalStorageService.setGettingStarted();
                        Get.offAllNamed(HomeScreen.routeName);
                      } else {
                        setState(() {
                          animationController.forward();
                        });
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.backgroundColor,
                      ),
                      child: Center(
                        child: Text(
                          isSearch ? 'Done' : 'Get Started',
                          style: const TextStyle(
                            color: AppColors.primaryColor1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

