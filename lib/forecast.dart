import 'package:flutter/material.dart';
class Forecast extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  const Forecast({
    super.key,
    required this.icon,
    required this.time,
    required this.temperature
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       
          const SizedBox(height: 10,),
        SingleChildScrollView(
         scrollDirection: Axis.horizontal,
          child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                 width: 80,
                 height: 120,
                 decoration: BoxDecoration(
                   border: Border.all(
                     width: 1.0,
                     color: Colors.white70
                   ),
                   borderRadius: BorderRadius.circular(50)
                 ),
                 child:  Column(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     Text(time,maxLines: 1,overflow: TextOverflow.ellipsis,),
                     Icon(icon),
                     Text('$temperature°'),
                   
                  
                 ],),
               ),
             ),
             ],
                    ),
        ),
      ],
    );
  }
}
