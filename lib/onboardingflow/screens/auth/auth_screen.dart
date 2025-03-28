import 'package:flutter/material.dart';
import '../../components/bounce_button.dart';
import '../../models/onboarding_data.dart';
import '../pet_selection/pet_selection_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoggingIn = true; // Toggle between login and signup
  
  // Using the same colors as in onboarding
  final Color backgroundColor = sunsetOrange; // From onboarding_data.dart
  
  // Counter for taps on logo
  int _logoTapCount = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleAuthMode() {
    setState(() {
      _isLoggingIn = !_isLoggingIn;
    });
  }

  void _submitForm() {
    // This is just a placeholder - no actual authentication happens
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('This is a placeholder. ${_isLoggingIn ? "Login" : "Signup"} functionality will be implemented later.'),
        duration: const Duration(seconds: 3),
      ),
    );
  }
  
  void _handleLogoTap() {
    setState(() {
      _logoTapCount++;
      
      // Show tap count in a small snackbar
      if (_logoTapCount < 10) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Dev mode: ${10 - _logoTapCount} more taps to access pet selection'),
              duration: const Duration(milliseconds: 500),
              behavior: SnackBarBehavior.floating,
            ),
          );
      } else {
        // Navigate to pet selection screen after 10 taps
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PetSelectionScreen(),
          ),
        );
        
        // Reset tap count
        _logoTapCount = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              backgroundColor,
              backgroundColor.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
                      BounceButton(
                        onPressed: () => Navigator.of(context).pop(),
                        backgroundColor: Colors.white.withOpacity(0.2),
                        buttonColor: Colors.white.withOpacity(0.1),
                        foregroundColor: Colors.white,
                        height: 40,
                        width: 40,
                        child: const Icon(Icons.arrow_back),
                      ),
                      
                      // App logo as text
                      const Text(
                        'GoalsApp',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 1.5,
                        ),
                      ),
                      
                      // Empty space for alignment
                      const SizedBox(width: 40),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // App logo or icon placeholder - tappable
                  GestureDetector(
                    onTap: _handleLogoTap,
                    child: Center(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.pets,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Title
                  Text(
                    _isLoggingIn ? 'Welcome Back!' : 'Create Account',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Subtitle
                  Text(
                    _isLoggingIn 
                        ? 'Sign in to continue your journey with your pet'
                        : 'Sign up to start your adventure with a new pet companion',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Social login buttons at the top
                  Row(
                    children: [
                      // Google
                      _socialLoginButton(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Google sign-in will be implemented later'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: Icons.g_mobiledata,
                        label: 'Google',
                        color: Colors.white,
                      ),
                      const SizedBox(width: 16),
                      // Apple
                      _socialLoginButton(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Apple sign-in will be implemented later'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: Icons.apple,
                        label: 'Apple',
                        color: Colors.white,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Or divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.white.withOpacity(0.5), thickness: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: TextStyle(color: Colors.white.withOpacity(0.9)),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Colors.white.withOpacity(0.5), thickness: 1),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Card with form fields
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          // Email field
                          TextField(
                            controller: _emailController,
                            style: const TextStyle(color: Color(0xFF2D3142)),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: backgroundColor.withOpacity(0.7)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: backgroundColor.withOpacity(0.3)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: backgroundColor),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: backgroundColor.withOpacity(0.7),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Password field
                          TextField(
                            controller: _passwordController,
                            style: const TextStyle(color: Color(0xFF2D3142)),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: backgroundColor.withOpacity(0.7)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: backgroundColor.withOpacity(0.3)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: backgroundColor),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: backgroundColor.withOpacity(0.7),
                              ),
                            ),
                            obscureText: true,
                          ),
                          
                          const SizedBox(height: 8),
                          
                          // Forgot password (only for login)
                          if (_isLoggingIn)
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Placeholder for password reset
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Password reset will be implemented later'),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: backgroundColor),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Submit button
                  BounceButton(
                    onPressed: _submitForm,
                    backgroundColor: Colors.white,
                    buttonColor: Colors.grey.shade300,
                    foregroundColor: backgroundColor,
                    height: 56,
                    width: double.infinity,
                    child: Text(
                      _isLoggingIn ? 'Sign In' : 'Sign Up',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Toggle between login and signup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLoggingIn ? 'Don\'t have an account?' : 'Already have an account?',
                        style: TextStyle(color: Colors.white.withOpacity(0.9)),
                      ),
                      TextButton(
                        onPressed: _toggleAuthMode,
                        child: Text(
                          _isLoggingIn ? 'Sign Up' : 'Sign In',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Skip authentication
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Continuing without account will be implemented later'),
                        ),
                      );
                    },
                    child: Text(
                      'Continue without account',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
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
  
  Widget _socialLoginButton({
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 