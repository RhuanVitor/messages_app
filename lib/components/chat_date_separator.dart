import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatDateSeparator extends StatelessWidget{
  DateTime date;

  ChatDateSeparator({required this.date});

  Widget build(BuildContext){
    late String separatorString;
    late var now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    if(date == today){
      separatorString = "hoje";
    } else if(date == today.subtract(Duration(days: 1))) {
      separatorString = "ontem";
    } else{
      separatorString = DateFormat('dd/MM/yyyy').format(date);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: Text(
            separatorString,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 120, 120, 120) 
            ),
          ),
        )
      ],
    );
  }
}