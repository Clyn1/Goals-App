import 'package:flutter/material.dart';
import 'package:goalsapp/features/onboarding/widgets/theme/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignIn = true; // Toggle between sign in and register
  final AuthService _authService = AuthService();
  
  // Form controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  // Loading and error states
  bool _isLoading = false;
  String? _errorMessage;
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  // Email/password authentication
  Future<void> _authenticateWithEmailAndPassword() async {
    // Validate inputs first
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      AuthResult result;
      
      if (_isSignIn) {
        // Sign in with existing account
        result = await _authService.signInWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text
        );
      } else {
        // Register new account
        result = await _authService.registerWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text
        );
      }
      
      if (result.isError) {
        setState(() {
          _errorMessage = result.errorMessage;
          _isLoading = false;
        });
        return;
      }
      
      // Success - navigate to next screen or show success message
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showSuccessAndNavigate();
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred';
        _isLoading = false;
      });
    }
  }
  
  // Google sign in
  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      final result = await _authService.signInWithGoogle();
      
      if (result.isError) {
        if (result.errorMessage != 'Sign in cancelled') {
          setState(() {
            _errorMessage = result.errorMessage;
          });
        }
        setState(() {
          _isLoading = false;
        });
        return;
      }
      
      // Success - navigate to next screen
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showSuccessAndNavigate();
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to sign in with Google';
        _isLoading = false;
      });
    }
  }
  
  // Apple sign in
  Future<void> _signInWithApple() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      final result = await _authService.signInWithApple();
      
      if (result.isError) {
        setState(() {
          _errorMessage = result.errorMessage;
          _isLoading = false;
        });
        return;
      }
      
      // Success - navigate to next screen
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showSuccessAndNavigate();
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to sign in with Apple';
        _isLoading = false;
      });
    }
  }
  
  // Navigate to next screen after successful auth
  void _showSuccessAndNavigate() {
    // Here you'd navigate to your pet selection or home screen
    // For now we'll just show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Authentication successful! 🎉'),
        backgroundColor: Colors.green,
      ),
    );
    
    // TODO: Replace with actual navigation to next screen
    Future.delayed(const Duration(seconds: 1), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      // Set resizeToAvoidBottomInset to false to prevent keyboard from pushing content up
      resizeToAvoidBottomInset: false,
      // Remove any system navigation color to ensure full screen use
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        // Make container fill entire screen height
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // Use BoxDecoration for the gradient that covers the full screen
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
        // Use SafeArea to respect system UI but custom bottom padding
        child: SafeArea(
          // Set bottom to false to extend content to the bottom edge
          bottom: false,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
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
                  
                  SizedBox(height: size.height * 0.03),
                  
                  // Main Card
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
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
                            
                            // Error message if present
                            if (_errorMessage != null) ...[
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.red.shade200),
                                ),
                                child: Text(
                                  _errorMessage!,
                                  style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                            
                            const SizedBox(height: 24),
                            
                            // Email Field
                            TextFormField(
                              controller: _emailController,
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                // Basic email validation
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Password Field
                            TextFormField(
                              controller: _passwordController,
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (!_isSignIn && value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            
                            if (!_isSignIn) ...[
                              const SizedBox(height: 16),
                              
                              // Confirm Password (only for register)
                              TextFormField(
                                controller: _confirmPasswordController,
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                            ],
                            
                            const SizedBox(height: 24),
                            
                            // Sign In/Register Button
                            ElevatedButton(
                              onPressed: _isLoading ? null : _authenticateWithEmailAndPassword,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                disabledBackgroundColor: AppTheme.primaryColor.withOpacity(0.5),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
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
                                    if (_isLoading) return;
                                    setState(() {
                                      _isSignIn = !_isSignIn;
                                      _errorMessage = null;
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
                                  onPressed: _isLoading ? null : _signInWithGoogle,
                                ),
                                
                                // Apple (if on iOS)
                                _socialSignInButton(
                                  icon: FontAwesomeIcons.apple,
                                  color: Colors.black,
                                  onPressed: _isLoading ? null : _signInWithApple,
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Skip for now option
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: TextButton(
                                  onPressed: _isLoading ? null : () {
                                    // Navigate to home (or pet selection) screen
                                    // For now, just pop back to previous screen or close if no previous
                                    if (Navigator.canPop(context)) {
                                      Navigator.pop(context);
                                    } else {
                                      // TODO: Navigate to home/pet selection when implemented
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Skipped authentication for now!'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
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
                            ),
                          ],
                        ),
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
    required VoidCallback? onPressed,
  }) {
    final isDisabled = onPressed == null;
    
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
          child: isDisabled
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: color,
                    strokeWidth: 2,
                  ),
                )
              : FaIcon(
                  icon,
                  color: color,
                  size: 24,
                ),
        ),
      ),
    );
  }
} 