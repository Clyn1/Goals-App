import 'package:flutter/material.dart';
import 'package:goalsapp/features/onboarding/controllers/onboarding_controller.dart';
import 'package:goalsapp/features/onboarding/models/onboarding_data.dart';
import 'package:goalsapp/common/widgets/onboarding_page.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:goalsapp/features/onboarding/widgets/theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  final OnboardingController _controller = OnboardingController();
  int _currentPage = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    // Slight delay to improve visual experience
    Future.delayed(const Duration(milliseconds: 200), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _completeOnboarding() {
    // Save onboarding completion status
    _controller.setOnboardingComplete();
    
    // Animate out before navigating away
    _animationController.reverse().then((_) {
      // Navigate to home screen - Replace with your home screen navigation
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const PlaceholderHomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Following best practice: immersive experience with animations
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Scaffold(
          body: Opacity(
            opacity: _animationController.value,
            child: PageView.builder(
              controller: _controller.pageController,
              itemCount: onboardingScreens.length,
              onPageChanged: _onPageChanged,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final screen = onboardingScreens[index];
                final isLastPage = index == onboardingScreens.length - 1;
                
                return OnboardingPage(
                  title: screen.title,
                  description: screen.description,
                  icon: screen.icon,
                  backgroundColor: screen.backgroundColor,
                  buttonText: screen.buttonText,
                  currentIndex: _currentPage,
                  totalPages: onboardingScreens.length,
                  showSkipButton: !isLastPage,
                  onSkip: () => _controller.skipToEnd(onboardingScreens.length - 1),
                  onButtonPressed: isLastPage 
                    ? _completeOnboarding 
                    : _controller.nextPage,
                );
              },
            ).animate().fadeIn(duration: 300.ms),
          ),
        );
      },
    );
  }
}

// Enhanced placeholder home screen with cards and consistent styling
class PlaceholderHomeScreen extends StatelessWidget {
  const PlaceholderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goalify'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              AppTheme.lightGray,
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Welcome section
              const Text(
                'Hello, Goal Setter!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Ready to make progress on your goals today?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 30),
              
              // Stats Card
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Progress Dashboard',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem(
                            context, 
                            '4', 
                            'Active Goals',
                            Icons.flag,
                            AppTheme.primaryColor,
                          ),
                          _buildStatItem(
                            context, 
                            '78%', 
                            'Weekly Progress',
                            Icons.trending_up,
                            AppTheme.secondaryColor,
                          ),
                          _buildStatItem(
                            context, 
                            '15', 
                            'Day Streak',
                            Icons.local_fire_department,
                            AppTheme.accentColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
              
              const SizedBox(height: 24),
              
              // Recent Goals
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Current Goals',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Goal Cards
              _buildGoalCard(
                context,
                'Complete Fitness Challenge',
                '30 minutes of exercise daily',
                Icons.fitness_center,
                0.65,
                AppTheme.primaryColor,
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 16),
              
              _buildGoalCard(
                context,
                'Learn Spanish',
                'Practice for 20 minutes every day',
                Icons.language,
                0.45,
                AppTheme.secondaryColor,
              ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 16),
              
              _buildGoalCard(
                context,
                'Read 12 Books This Year',
                'Currently on book 5: "Atomic Habits"',
                Icons.book,
                0.38,
                AppTheme.accentColor,
              ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatItem(BuildContext context, String value, String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
  
  Widget _buildGoalCard(BuildContext context, String title, String subtitle, IconData icon, double progress, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.shade200,
                      color: color,
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 