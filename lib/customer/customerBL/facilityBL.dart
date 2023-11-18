import 'package:flutter/material.dart';

class Facility {
  String name;
  IconData icon; // which I will define for every possible facility by myself and store it somewhere
  Facility({required this.name, required this.icon});
}
List<Facility> faclitiesList = [
  Facility(name: "Wifi", icon: Icons.wifi),
  Facility(name: "Pool", icon: Icons.pool),
  Facility(name: "Cleaning", icon: Icons.cleaning_services),
  Facility(name: "Entertainment", icon: Icons.tv),
  Facility(name: "Workspace", icon: Icons.chair_outlined),
  Facility(name: "Clothing Care", icon: Icons.iron),
];