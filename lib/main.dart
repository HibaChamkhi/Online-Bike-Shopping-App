import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/presentation/auth/widgets/discover_widget.dart';
import 'package:online_bike_shopping_appuntitled/presentation/products/pages/home_page.dart';
import 'package:online_bike_shopping_appuntitled/presentation/products/widgets/home_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'injection.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Supabase.initialize(
      url: "https://zxpobryrmbyvwahngxko.supabase.co",
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp4cG9icnlybWJ5dndhaG5neGtvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM1Mzc5MzgsImV4cCI6MjAzOTExMzkzOH0.hi29zbYjGq03sqR0fQKPY2OipRH4c77Iw0kJ4PEMX94");
  runApp(ScreenUtilInit(
    designSize: const Size(428, 810),
    builder: (BuildContext context, Widget? child) {
      return const MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

