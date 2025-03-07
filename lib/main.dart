import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_v1_tutorial/data/model/weather.dart';
import 'package:flutter_bloc_v1_tutorial/pages/weather_detail_page.dart';
import 'package:sailor/sailor.dart';

import 'bloc/weather_bloc.dart';
import 'data/weather_repository.dart';
import 'pages/weather_search_page.dart';

void main() {
  Routes.createRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: BlocProvider(
        builder: (context) => WeatherBloc(FakeWeatherRepository()),
        child: WeatherSearchPage(),
      ),
      onGenerateRoute: Routes.sailor.generator(),
      navigatorKey: Routes.sailor.navigatorKey,
    );
  }
}

class Routes {
  static final sailor = Sailor();

  static void createRoutes() {
    print('create routes');
    sailor.addRoutes([
      SailorRoute(
        name: '/initial',
        builder: (context, args, params) => BlocProvider(
          builder: (context) => WeatherBloc(FakeWeatherRepository()),
          child: WeatherSearchPage(),
        ),
      ),
      SailorRoute(
        name: '/details',
        builder: (context, args, params) {
          print('context... $context');
          return BlocProvider.value(
            value: BlocProvider.of<WeatherBloc>(context),
            child: WeatherDetailPage(
              masterWeather: params.param('masterWeather'),
            ),
          );
        },
        params: [
          SailorParam<Weather>(
            name: 'masterWeather',
          ),
        ],
      ),
    ]);
  }
}
