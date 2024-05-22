import 'package:flutter/material.dart';
class WeatherParameters extends StatelessWidget {
    final IconData icon;
    final String value;
    final String lable;

  const WeatherParameters({
    required this.icon,
    required this.lable,
    required this.value,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
         Container(
          width: 90,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              width: 2.0,
              strokeAlign: BorderSide.strokeAlignInside
            ),
            borderRadius: BorderRadius.circular(20)
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(icon, color: Colors.orangeAccent, size: 35,),
              Text(value, style: const TextStyle(color: Colors.white),),
              Text(lable, style: const TextStyle(color: Colors.white),)
            ],
          ),
        ),
         ],
    );
  }
}