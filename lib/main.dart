import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:know_weather/blox_and_cubit/climate_cubit/climate_cubit.dart';
import 'package:know_weather/routes/app_routes.dart';
import 'package:know_weather/services/local_storage_service.dart';
import 'package:know_weather/theme/colors.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await LocalStorageService.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClimateCubit>(
      create: (context) => ClimateCubit(),
      child: GetMaterialApp(
        title: 'Know Weather',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),

        ),
        getPages: AppRoutes.appRoutes(),
      ),
    );
  }
}
