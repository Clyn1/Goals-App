import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences.dart';
import 'features/auth/providers/auth_state_provider.dart';
import 'features/auth/services/local_storage_service.dart';
import 'features/auth/screens/login_screen.dart';
import 'onboardingflow/screens/welcome/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final hasCompletedOnboarding = prefs.getBool('hasCompletedOnboarding') ?? false;
  
  runApp(MyApp(
    hasCompletedOnboarding: hasCompletedOnboarding,
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final bool hasCompletedOnboarding;
  final SharedPreferences prefs;

  const MyApp({
    super.key,
    required this.hasCompletedOnboarding,
    required this.prefs,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => LocalStorageService(prefs),
        ),
        ChangeNotifierProxyProvider<LocalStorageService, AuthStateProvider>(
          create: (context) => AuthStateProvider(
            Provider.of<LocalStorageService>(context, listen: false),
          ),
          update: (context, localStorage, previous) =>
              previous ?? AuthStateProvider(localStorage),
        ),
      ],
      child: MaterialApp(
        title: 'GoalsApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: hasCompletedOnboarding
            ? const LoginScreen()
            : const OnboardingScreen(),
      ),
    );
  }
}
