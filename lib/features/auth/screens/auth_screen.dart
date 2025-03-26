import 'package:flutter/material.dart';
import 'package:goalsapp/features/onboarding/widgets/theme/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignIn = true; // Toggle between sign in and register

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryColor,
              Color(0xFFFF9776),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Logo/Title
                  const Center(
                    child: Text(
                      'GOALIFY',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: size.height * 0.05),
                  
                  // Main Card
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Title
                          Text(
                            _isSignIn ? 'Welcome Back!' : 'Join Goalify',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          
                          const SizedBox(height: 8),
                          
                          // Subtitle
                          Text(
                            _isSignIn 
                                ? 'Sign in to continue your journey with your pet companion!'
                                : 'Create an account to start achieving goals with your pet companion!',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.textLight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          
                          const SizedBox(height: 32),
                          
                          // Email Field
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Password Field
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: const Icon(Icons.visibility_off_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            obscureText: true,
                          ),
                          
                          if (!_isSignIn) ...[
                            const SizedBox(height: 16),
                            
                            // Confirm Password (only for register)
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: const Icon(Icons.visibility_off_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                              obscureText: true,
                            ),
                          ],
                          
                          const SizedBox(height: 24),
                          
                          // Sign In/Register Button
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Implement Firebase Auth
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              _isSignIn ? 'Sign In' : 'Create Account',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Option to switch between Sign In/Register
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _isSignIn ? 'Don\'t have an account? ' : 'Already have an account? ',
                                style: const TextStyle(color: AppTheme.textLight),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSignIn = !_isSignIn;
                                  });
                                },
                                child: Text(
                                  _isSignIn ? 'Register' : 'Sign In',
                                  style: const TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Divider
                          Row(
                            children: [
                              Expanded(child: Divider(color: Colors.grey.shade300)),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'OR',
                                  style: TextStyle(color: AppTheme.textLight),
                                ),
                              ),
                              Expanded(child: Divider(color: Colors.grey.shade300)),
                            ],
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Social Sign In Options
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Google
                              _socialSignInButton(
                                icon: FontAwesomeIcons.google,
                                color: Colors.red,
                                onPressed: () {
                                  // TODO: Implement Google Sign In
                                },
                              ),
                              
                              // Apple (if on iOS)
                              _socialSignInButton(
                                icon: FontAwesomeIcons.apple,
                                color: Colors.black,
                                onPressed: () {
                                  // TODO: Implement Apple Sign In
                                },
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Skip for now option
                          Center(
                            child: TextButton(
                              onPressed: () {
                                // TODO: Navigate to home screen
                              },
                              child: const Text(
                                'Skip for now',
                                style: TextStyle(
                                  color: AppTheme.textLight,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _socialSignInButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: FaIcon(
            icon,
            color: color,
            size: 24,
          ),
        ),
      ),
    );
  }
} 