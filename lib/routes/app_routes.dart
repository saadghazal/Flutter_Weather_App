import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:know_weather/screens/home_screen.dart';
import 'package:know_weather/screens/splash_screen.dart';

class AppRoutes {
  static List<GetPage> appRoutes() {
    return [
      GetPage(
        name: SplashScreen.routeName,
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: HomeScreen.routeName,
        page: () => const HomeScreen(),
      ),
    ];
  }
}
