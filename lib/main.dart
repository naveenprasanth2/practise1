import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/flash_screen/flash_screen.dart';
import 'package:practise1/list_view_test/providers/count_providers.dart';
import 'package:practise1/list_view_test/providers/date_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => DateProvider()),
        ChangeNotifierProvider(create: (create) => CountProviders()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MySplashScreen(),
      ),
    );
  }
}
