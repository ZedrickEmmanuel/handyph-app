import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';
import 'providers/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize auth provider before app starts
  final authProvider = AuthProvider();
  await authProvider.initialize();

  runApp(HandyPhApp(authProvider: authProvider));
}

class HandyPhApp extends StatelessWidget {
  final AuthProvider authProvider;

  const HandyPhApp({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'HandyPH',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            routerConfig: AppRouter.router(context.read<AuthProvider>()),
          );
        },
      ),
    );
  }
}
