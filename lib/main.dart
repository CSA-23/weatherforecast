import 'package:flutter/material.dart';
import 'package:weatherforecast/home_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        appBarTheme: const AppBarTheme( backgroundColor: Colors.amberAccent,)
      ),
      home:  const WeatherForecast(),
    );
  }
}