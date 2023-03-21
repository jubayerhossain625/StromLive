

import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:stromlive/feature/domain/model/weathermodel.dart';
import 'package:stromlive/feature/presentation/pages/about.dart';

import '../widgets/slider_widget.dart';


class BodyHome extends StatefulWidget {
  const BodyHome({Key? key, required this.weatherModel}) : super(key: key);
  final WeatherModel weatherModel;

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  var adds;
  Future<void> getAddress() async {
    final coordinates = Coordinates(widget.weatherModel.coord.lat, widget.weatherModel.coord.lon);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  setState(() {
    adds = addresses.first.addressLine.toString();
  });

  }
  @override
  void initState() {
    // TODO: implement initState
    getAddress();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 35),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.cyanAccent.withOpacity(0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
               Positioned(
                top: 20,right: 5,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutUs()));
                      });
                    },
                      child: const Icon(
                        Icons.info_outline_rounded,
                        size: 38,color: Colors.brown,
                      ))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const SizedBox(height: 35.0,),
                  const Text(
                    'Sun Tracking',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: Text(
                      '${adds}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
            Expanded(
            child: SliderWidget(weatherModel: widget.weatherModel,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:   [
                  const Text(
                    'Humidity',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.weatherModel!.main!.humidity}%',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  const Text(
                    'Wind Speed',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.weatherModel!.wind!.speed} m/s',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const Text(
                    'Pressure',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.weatherModel!.main!.pressure} Pa',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  const Text(
                    'Weather',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.weatherModel.weather.first.description.toString().toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40.0,),
        ],
      ),
    );
  }
}
