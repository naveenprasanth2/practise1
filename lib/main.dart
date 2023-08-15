import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/flash_screen/flash_screen.dart';
import 'package:practise1/list_view_test/providers/booking_data_provider.dart';
import 'package:practise1/list_view_test/providers/calculation_provider.dart';
import 'package:practise1/list_view_test/providers/count_provider.dart';
import 'package:practise1/list_view_test/providers/date_provider.dart';
import 'package:practise1/list_view_test/providers/maps_provider.dart';
import 'package:provider/provider.dart';

import 'list_view_test/providers/coupon_state_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ChangeNotifierProvider(create: (create) => CountProvider()),
        ChangeNotifierProvider(create: (create) => CalculationProvider()),
        ChangeNotifierProvider(create: (create) => MapProvider()),
        ChangeNotifierProvider(create: (create) => CouponStateProvider()),
        ChangeNotifierProvider(create: (create) => BookingDataProvider()),
        ChangeNotifierProxyProvider2<DateProvider, CountProvider,
            CalculationProvider>(
          create: (context) => CalculationProvider(),
          update: (context, dateProvider, countProvider, calculationProvider) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (calculationProvider != null) {
                calculationProvider.setDateProviderData(dateProvider.noOfDays);
                countProvider.setMaximumAdultCount(calculationProvider.roomSelection.maxPeopleAllowed);
                countProvider.setAdultAndChildCount(calculationProvider.roomsInfo);
              }
            });
            return calculationProvider ?? CalculationProvider(); // Return a default value if calculationProvider is null
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
