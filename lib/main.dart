import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/flash_screen/flash_screen.dart';
import 'package:practise1/list_view_test/providers/calculation_provider.dart';
import 'package:practise1/list_view_test/providers/count_provider.dart';
import 'package:practise1/list_view_test/providers/date_provider.dart';
import 'package:practise1/list_view_test/providers/maps_provider.dart';
import 'package:provider/provider.dart';

import 'list_view_test/providers/coupon_state_provider.dart';

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
        ChangeNotifierProvider(create: (create) => CalculationProvider()),
        ChangeNotifierProvider(create: (create) => MapProvider()),
        ChangeNotifierProvider(create: (create) => CouponStateProvider()),
        ChangeNotifierProxyProvider<DateProvider, CalculationProvider>(
          create: (context) => CalculationProvider(),
          update: (context, dateProvider, calculationProvider) {
            calculationProvider!.setDateProviderData(
              dateProvider.noOfDays,
            );
            return calculationProvider;
          },
        ),
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
