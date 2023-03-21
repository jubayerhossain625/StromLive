import 'dart:math';
import 'package:flutter/material.dart';

double degToRed(num deg) => deg *(pi/180.0);

double normalize(value,min,max) => ((value - min)/(max - min));

const Color kScaffoldBackgroundColor = Color(0xFFF3FBFA);
const double kDiameter = 300;
const double kMinDegree = 16;
const double kMaxDegree = 28;

const String sunAbout='A sun tracker is a device that tracks the movement of the sun across the sky and can be used for a variety of purposes, including for solar panels and solar water heaters. The device typically uses sensors and motors to adjust the position of the solar panel or reflector to optimize its alignment with the sun.';
const String weatherAbout = 'Sunrise and sunset times are determined by the position of the sun in relation to the observers location on Earth. A weather report shows current and future weather conditions for a specific location, including temperature, precipitation, wind speed and direction, and other weather-related information';
const String overall = 'There are various tools and resources available to access live sunrise and sunset times and weather reports, including online weather apps and websites, local news channels, and specialized weather forecasting services.';