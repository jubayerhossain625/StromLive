

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:solar_calculator/solar_calculator.dart';
import 'package:stromlive/feature/domain/model/weathermodel.dart';
import 'package:stromlive/feature/presentation/widgets/text_widget.dart';
import 'package:stromlive/feature/utlis.dart';


class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key, required this.weatherModel}) : super(key: key);
  final WeatherModel weatherModel;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double progressVal = 0.5;
  bool isHoursOfDarkness =false;
  double valueOfSun=0.0;
  double end =0.0 ;

  String getSunRise(){
    String x='',y='',z='';

    int minute = DateTime.fromMillisecondsSinceEpoch(widget.weatherModel.sys.sunrise * 1000).minute;
    int hur = DateTime.fromMillisecondsSinceEpoch(widget.weatherModel.sys.sunrise * 1000).hour;
    if(hur<10 ){
      x = "0${hur.toString()}";
      if(minute<10){
        y = "0${minute.toString()}";
      }else
        {
          return z = "$x:$minute";
        }
    return  z = "$x:$y";
    }else{
      if(minute<10){
        y = "0${minute.toString()}";
      }else
      {
        return z = "$hur:$minute";
      }
      return  z = "$hur:$y";
    }
  }

  String getSunSet(){
    String x='',y='',z='';

    int minute = DateTime.fromMillisecondsSinceEpoch(widget.weatherModel.sys.sunset * 1000).minute;
    int hur = DateTime.fromMillisecondsSinceEpoch(widget.weatherModel.sys.sunset * 1000).hour;
    if(hur<10 ){
      x = "0${hur.toString()}";
      if(minute<10){
        y = "0${minute.toString()}";
      }else
      {
        return z = "$x:$minute";
      }
      return  z = "$x:$y";
    }else{
      if(minute<10){
        y = "0${minute.toString()}";
      }else
      {
        return z = "$hur:$minute";
      }
      return  z = "$hur:$y";
    }
  }

  getData()  {
    final instant = Instant(
        year: DateTime.now().year,
        month: DateTime.now().month,
        day: DateTime.now().day,
        hour: DateTime.now().hour,
        timeZoneOffset: 6.0
    );

    final calc = SolarCalculator(instant, widget.weatherModel.coord.lat, widget.weatherModel.coord.lon);

         setState(() {
          isHoursOfDarkness = calc.isHoursOfDarkness;
          valueOfSun = calc.sunHorizontalPosition.azimuth -90;
          end  = calc.sunHorizontalPosition.elevation;
         });
      }
  @override
  void initState() {
    // TODO: implement initState

    getData();
    getSunSet();
    getSunRise();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    getData();


    return Stack(
      children: [
        Center(
          child: Container(
            width: kDiameter - 30,
            height: kDiameter - 30,
            decoration: BoxDecoration(
                color: isHoursOfDarkness== false ? Colors.white :Colors.grey,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isHoursOfDarkness== false ? Colors.white :Colors.grey,
                  width: 10,
                  style: BorderStyle.solid,
                ),
                boxShadow: [
                BoxShadow(
                blurRadius: 30,
                spreadRadius: 10,
                color:    isHoursOfDarkness == true ? Colors.black.withAlpha(
                normalize(progressVal * 20000, 100, 255).toInt()) :Colors.yellow.withAlpha(
                    normalize(progressVal * 20000, 100, 255).toInt()),
                offset: const Offset(1, 3))
                ],
            ),
            child:  isHoursOfDarkness == false ? SleekCircularSlider(
              min: 0,
              max: 180,
              initialValue: valueOfSun.abs(),
              appearance: CircularSliderAppearance(
                startAngle: -179,
                angleRange: 180,
                size: kDiameter - 30,
                animationEnabled: true,
                animDurationMultiplier: 1.0,
                customWidths: CustomSliderWidths(
                  trackWidth: 10,
                  shadowWidth: 0,
                  progressBarWidth: 01,
                  handlerSize: 15,
                ),
                customColors: CustomSliderColors(
                  hideShadow: false,
                  progressBarColor: Colors.transparent,
                  trackColor: Colors.transparent,
                  dotColor: Colors.yellow,
                ),
              ),
              onChangeStart: (value){

                  setState(() {
                    progressVal = normalize(value, kMinDegree, kMaxDegree);
                });
              },
              innerWidget: (percentage) {
                return  Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0,),
                        Text(
                        '${widget.weatherModel.main.temp.toInt()}°c',
                        style: const TextStyle(
                          fontSize: 50,
                        ),
                      ),
                       const TextWidget(title: "DAY",size: 25,weight: FontWeight.w600,)
                    ],
                  ),
                );
              },
            ) : Column(
              children:  [
                const SizedBox(height: 20.0,),
                  Text( '${widget.weatherModel.main.temp.toInt()}°c',
                  style: const TextStyle(
                    fontSize: 50,color: Colors.white
                  ),
                ),
                const TextWidget(title:"Night",size: 25,weight: FontWeight.w600,color: Colors.white,),
              ],
            ),
          ),
        ),

        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 60),
            height: kDiameter,
            width: kDiameter -50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    TextWidget(title: "SunRise\n${getSunRise()} am",weight: FontWeight.w600,color: Colors.black,),
                    TextWidget(title: "SunSet\n${getSunSet()} pm",weight: FontWeight.w600,color: Colors.black,)
                  ],
                )
              ],
            ),
          ),
        )


      ],
    );
  }
}

