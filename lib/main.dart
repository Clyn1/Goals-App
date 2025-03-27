import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:goalsapp/features/onboarding/widgets/theme/app_theme.dart';
import 'package:goalsapp/features/onboarding/screens/onboarding_screen.dart';
import 'package:goalsapp/config/supabase_config.dart';

Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
    debug: true, // Set to false in production
  );
  
  runApp(const GoalsApp());
}

class GoalsApp extends StatelessWidget {
  const GoalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goalify',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(context),
      home: const OnboardingScreen(),
    );
  }
}

