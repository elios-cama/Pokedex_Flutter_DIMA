import 'package:flutter/material.dart';
import 'package:pokedex/domain/type.dart';

Widget typeBoxes(List<Type> types) {
  return types.length == 1
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            typeBox(types[0]),
          ],
        )
      : Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            typeBox(types[0]),
            const SizedBox(width: 10.0),
            typeBox(types[1]),
          ],
        );
}

Container typeBox(Type type) {
  return Container(
    width: 60, // Adjust width as needed
    height: 25, // Adjust height as needed
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), color: type.color),
    child: Center(
      child: Text(
        type.name,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}