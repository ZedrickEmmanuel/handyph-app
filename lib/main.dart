import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';

void main() {
  runApp(const HandyPhApp());
}

class HandyPhApp extends StatelessWidget {
  const HandyPhApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Phase 3 — MultiProvider will wrap this when providers are created:
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => AuthProvider()),
    //     ChangeNotifierProvider(create: (_) => UserProvider()),
    //     ChangeNotifierProvider(create: (_) => BookingProvider()),
    //     ChangeNotifierProvider(create: (_) => ChatProvider()),
    //     ChangeNotifierProvider(create: (_) => JobProvider()),
    //   ],
    //   child: materialApp,
    // );

    return MaterialApp.router(
      title: 'HandyPH',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
