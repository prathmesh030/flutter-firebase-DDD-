import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/injection.dart';
import './presentation/core/app.dart';

void main() async {
  await configureInjection(Environment.prod);
  // runApp(const MyApp());
  runApp(AppWidget());
}
