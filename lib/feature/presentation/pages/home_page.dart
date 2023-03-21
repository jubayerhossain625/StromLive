
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stromlive/feature/domain/api/weather_service.dart';
import 'package:stromlive/feature/domain/model/weathermodel.dart';
import 'package:stromlive/feature/presentation/pages/_body.dart';
import 'package:stromlive/feature/presentation/widgets/text_widget.dart';
import 'package:stromlive/feature/utlis.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WeatherService s;
  late Future<WeatherModel> _weather;
  late WeatherModel models;
  late double latitude, longitude;
  late bool isLoaded = false;

  void getLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition();
    final weatherModel = await WeatherService()
        .fetchWeather(position.latitude, position.longitude);
    setState(() {
      models = WeatherModel.fromJson(weatherModel);
    });
    const Duration(seconds: 5);
    isLoaded = true;
  }

  // Get the current position

  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: isLoaded == true
          ? BodyHome(weatherModel: models,)
          :  Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.cyanAccent,
              child: Stack(
                children: [
                  Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.orange, size: 100)),
                  const Center(child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: TextWidget(title: "Strom Live",color: Colors.orange,size: 25,),
                  ),),
                ],
              )
            ),
    );
  }
}
