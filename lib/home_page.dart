import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherforecast/forecast.dart';
import 'package:weatherforecast/http_call.dart';
import 'package:weatherforecast/weather_parameter.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({super.key});

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  late Future<Map<String, dynamic>> weather;
  
  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Weather Forecast",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.cloud_done_outlined,
                color: Colors.black,
                size: 35,
              ),
            )
          ],
        ),
      ),
      body: FutureBuilder(
          future: weather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            final data = snapshot.data!;
            final currentWeatherData = data['list'][0];
            final currentTemp = currentWeatherData['main']['temp'];
            final currentsky = currentWeatherData['weather'][0]['main'];
            final currentWindspeed = currentWeatherData['wind']['speed'];
            final currentHumidity = currentWeatherData['main']['humidity'];
            final currentPressure = currentWeatherData['main']['pressure'];
            final temp = (currentTemp - 273.15).toStringAsFixed(2);

            return Column(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.57,
                    decoration: const BoxDecoration(
                      color: Colors.amberAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amberAccent,
                          offset: Offset(
                            3.0,
                            3.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 5.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(4.0, 2.0),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35)),
                    ),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Icon(
                                currentsky == 'Clouds' ? Icons.cloud: currentsky == 'Rain' ? Icons.thunderstorm: Icons.sunny ,
                                size: 120,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 40, 0, 0),
                              child: Text(
                                '$temp°',
                                style: const TextStyle(
                                    fontSize: 45,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                         Padding(
                          padding:const EdgeInsetsDirectional.only(bottom: 10),
                          child: Text(
                            "$currentsky",
                            style: const TextStyle(
                                fontSize: 35,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            WeatherParameters(
                              icon: Icons.air,
                              value: '$currentWindspeed',
                              lable: 'Wind',
                            ),
                             WeatherParameters(
                              icon: Icons.snowing,
                              value: '$currentHumidity',
                              lable: 'Humidity',
                            ),
                             WeatherParameters(
                              icon: Icons.water_drop,
                              value: '$currentPressure',
                              lable: 'Pressure',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hourly Forecast",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Today",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index){
                      final hourlyForecast = data['list'][index + 1];
                      final hourlySky = data['list'][index + 1]['weather'][0]['main'];
                      final hourlyTemp = hourlyForecast['main']['temp']; 
                      final time = DateTime.parse(hourlyForecast['dt_txt'].toString());
                      String tempC = (hourlyTemp - 273.15).toStringAsFixed(2);

                      return Forecast(
                        icon: hourlySky == 'Clouds' ? Icons.cloud: hourlySky == 'Rain' ? Icons.thunderstorm: Icons.sunny, 
                        time: DateFormat.j().format(time) , 
                        temperature: tempC,
                        );
                    }
                  ),
                ),
                // const SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       Forecast(
                //         temperature: '30°',
                //         icon: Icons.cloud,
                //         time: '10:00',
                //       ),
                //       Forecast(
                //         temperature: '22°',
                //         icon: Icons.thunderstorm,
                //         time: '12:30',
                //       ),
                //       Forecast(
                //         temperature: '19°',
                //         icon: Icons.snowing,
                //         time: '1:40',
                //       ),
                //       Forecast(
                //         temperature: '30°',
                //         icon: Icons.cloud,
                //         time: '10:00',
                //       ),
                //       Forecast(
                //         temperature: '30°',
                //         icon: Icons.cloud,
                //         time: '10:00',
                //       ),
                //       Forecast(
                //         temperature: '30°',
                //         icon: Icons.cloud,
                //         time: '10:00',
                //       ),
                //       Forecast(
                //         temperature: '30°',
                //         icon: Icons.cloud,
                //         time: '10:00',
                //       ),
                //     ],
                //   ),
                // ),
              ],
            );
          }),
    );
  }
}
