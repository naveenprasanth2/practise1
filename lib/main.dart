import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/providers/auth_provider.dart';
import 'package:practise1/hotel_booking/providers/booking_data_provider.dart';
import 'package:practise1/hotel_booking/providers/calculation_provider.dart';
import 'package:practise1/hotel_booking/providers/count_provider.dart';
import 'package:practise1/hotel_booking/providers/date_provider.dart';
import 'package:practise1/hotel_booking/providers/language_provider.dart';
import 'package:practise1/hotel_booking/providers/maps_provider.dart';
import 'package:practise1/hotel_booking/providers/profile_provider.dart';
import 'package:practise1/hotel_booking/providers/upcoming_provider.dart';
import 'package:provider/provider.dart';

import 'hotel_booking/providers/coupon_state_provider.dart';
import 'hotel_booking/screens/flash_screen/flash_screen.dart';

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
        ChangeNotifierProvider(create: (create) => AuthProvider()),
        // ChangeNotifierProvider(create: (create) => ProfileProvider()),
        ChangeNotifierProvider(create: (create) => UpcomingProvider()),
        ChangeNotifierProvider(create: (create) => DateProvider()),
        ChangeNotifierProvider(create: (create) => CountProvider()),
        ChangeNotifierProvider(create: (create) => CalculationProvider()),
        ChangeNotifierProvider(create: (create) => MapProvider()),
        ChangeNotifierProvider(create: (create) => CouponStateProvider()),
        ChangeNotifierProvider(create: (create) => BookingDataProvider()),
        ChangeNotifierProvider(create: (create) => LanguageProvider()),
        ChangeNotifierProxyProvider2<DateProvider, CountProvider,
            CalculationProvider>(
          create: (context) => CalculationProvider(),
          update: (context, dateProvider, countProvider, calculationProvider) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (calculationProvider != null) {
                calculationProvider.setDateProviderData(dateProvider.noOfDays);
                countProvider.setMaximumAdultCount(
                    calculationProvider.roomSelection.maxPeopleAllowed);
                countProvider
                    .setAdultAndChildCount(calculationProvider.roomsInfo);
              }
            });
            return calculationProvider ??
                CalculationProvider(); // Return a default value if calculationProvider is null
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProfileProvider>(
            create: (context) => ProfileProvider(),
            update: (context, authProvider, profileProvider) {
              if (authProvider.userProfileModel != null) {
                profileProvider!
                    .setProfileDataFromModel(authProvider.userProfileModel!);
              }
              return profileProvider!;
            }),
      ],
      child: MaterialApp(
        title: 'BookAny',
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
