import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:know_weather/blox_and_cubit/climate_cubit/climate_cubit.dart';
import 'package:know_weather/services/location_service.dart';
import 'package:know_weather/theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool emptyCity = false;
  TextEditingController cityController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.only(
            top: topPadding == 0 ? 20 : topPadding + 10,
            left: 16,
            right: 16,
          ),
          child: BlocBuilder<ClimateCubit, ClimateState>(
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    height: 45,
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 14, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.backgroundColor,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: cityController,
                            cursorColor: AppColors.primaryColor2,
                            onSubmitted: (_){
                              if (cityController.text.isEmpty) {
                                setState(() {
                                  emptyCity = true;
                                });
                                return;
                              } else {
                                if (emptyCity) {
                                  setState(() {
                                    emptyCity = false;
                                  });
                                }
                                context
                                    .read<ClimateCubit>()
                                    .getWeather(cityName: cityController.text);
                              }
                            },
                            style: const TextStyle(
                              color: AppColors.primaryColor2,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              hintText: 'City Name',
                              hintStyle: TextStyle(
                                color: AppColors.primaryColor2.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (cityController.text.isEmpty) {
                              setState(() {
                                emptyCity = true;
                              });
                              return;
                            } else {
                              if (emptyCity) {
                                setState(() {
                                  emptyCity = false;
                                });
                              }
                              context
                                  .read<ClimateCubit>()
                                  .getWeather(cityName: cityController.text);
                            }
                          },
                          child: const Icon(
                            Icons.search,
                            color: AppColors.primaryColor2,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: emptyCity,
                    replacement: const SizedBox(),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Please Enter City Name',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  state.weatherStatus == WeatherStatus.error?
                      Text(state.errorMessage):
                  state.weatherStatus == WeatherStatus.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor2,
                          ),
                        )
                      : Column(
                          children: [
                            Text(
                              state.climate.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                color: AppColors.mainColor,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              state.climate.weather[0].description.capitalizeFirst!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.mainColor,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Image.asset(
                              'assets/icons/${state.weatherType.name}.png',
                              height: 150,
                              width: 150,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              '${state.climate.main.temp}˚',
                              style: const TextStyle(
                                fontSize: 30,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                  Spacer(
                    flex: state.weatherStatus == WeatherStatus.loading ? 1 : 2,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
