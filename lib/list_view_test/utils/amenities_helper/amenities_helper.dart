import 'package:flutter/material.dart';

class AmenitiesHelper {
  static IconData getIconIfPresent(String iconName, bool facilityAvailable) {
    switch (iconName) {
      case "ac":
        return Icons.ac_unit;
      case "wifi":
        return Icons.wifi;
      case "kitchen":
        return Icons.kitchen;
      case "restaurant":
        return Icons.restaurant;
      case "reception":
        return Icons.table_chart;
      case "careTaker":
        return Icons.person;
      case "security":
        return Icons.security;
      case "shuttleService":
        return Icons.airport_shuttle;
      case "luggageAssistance":
        return Icons.luggage;
      case "taxi":
        return Icons.local_taxi;
      case "dailyHousekeeping":
        return Icons.person;
      case "fireExtinguisher":
        return Icons.fire_extinguisher;
      case "firstAidKit":
        return Icons.medical_services_rounded;
      case "cot":
        return Icons.bed_sharp;
      case "kingSizedBed":
        return Icons.king_bed;
      case "queenSizedBed":
        return Icons.king_bed_outlined;
      case "singleBed":
        return Icons.single_bed;
      case "tv":
        return Icons.tv;
      case "ott":
        return Icons.settings_input_antenna;
      case "geyser":
        return Icons.water;
      case "extraMattress":
        return Icons.hotel;
      case "smokeDetector":
        return Icons.smoking_rooms;
      case "interCom":
        return Icons.phone;
      case "books":
        return Icons.book;
      case "seatingArea":
        return Icons.event_seat;

      default:
        if (facilityAvailable) {
          return Icons.check;
        } else {
          return Icons.circle_outlined;
        }
    }
  }

  static String amenitiesNameConverter(String amenityName) {
    String result = amenityName.replaceAllMapped(
      RegExp(r'(^[a-z])|[A-Z][a-z]*'),
      (Match m) => m[0]![0].toUpperCase() + m[0]!.substring(1).toLowerCase(),
    );

    // Insert space between words
    result = result.replaceAllMapped(
      RegExp(r'[A-Z][a-z]*'),
      (Match m) => ' ${m[0]!}',
    );

    return result;
  }
}
