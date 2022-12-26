import 'package:flutter/material.dart';

Widget rowButton(String title, Function onPressed, IconData icon, Color iconColor, Color color){
  return GestureDetector(
    onTap: () => onPressed(),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor,),
              const SizedBox(width: 30,),
              Text(title),
            ],
          ),
          const Icon(Icons.arrow_right, color: Colors.black,),
        ],
      ),
    ),
  );
}