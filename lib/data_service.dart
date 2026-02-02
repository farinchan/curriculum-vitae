import 'dart:convert';
import 'package:flutter/services.dart';
import 'cv_model.dart';

class DataService {
  Future<CVSpec> loadData() async {
    try {
      final String response = await rootBundle.loadString('assets/data.json');
      final data = await json.decode(response);
      return CVSpec.fromJson(data);
    } catch (e) {
      throw Exception('Failed to load CV data: $e');
    }
  }
}
