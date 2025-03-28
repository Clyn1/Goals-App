import 'package:flutter/material.dart';
import '../../models/pet_data.dart';
import '../../models/onboarding_data.dart';
import '../../components/bounce_button.dart';
import '../../components/pet_stats_bottom_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PetSelectionScreen extends StatefulWidget {
  const PetSelectionScreen({Key? key}) : super(key: key);

  @override
  State<PetSelectionScreen> createState() => _PetSelectionScreenState();
}

class _PetSelectionScreenState extends State<PetSelectionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectPet() {
    // Show the pet stats bottom sheet for final confirmation
    PetStatsBottomSheet.show(context, starterPets[_currentPage]);
  }
  
  void _viewStats() {
    // Show the pet stats bottom sheet
    PetStatsBottomSheet.show(context, starterPets[_currentPage]);
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
              Colors.white,
              starterPets[_currentPage].color.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    BounceButton(
                      onPressed: () => Navigator.of(context).pop(),
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      buttonColor: Colors.grey.withOpacity(0.1),
                      foregroundColor: Colors.black87,
                      height: 40,
                      width: 40,
                      child: const Icon(Icons.arrow_back),
                    ),
                    
                    // Page title
                    const Text(
                      'Choose Your Pet',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    // Empty container for alignment
                    const SizedBox(width: 40),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Page title and description
                Text(
                  'Your Companion Awaits',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                Text(
                  'Choose a pet that matches your goal style. Each pet has unique traits and will grow differently based on your goals.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Pet carousel
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: starterPets.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final pet = starterPets[index];
                      return _buildPetCard(pet);
                    },
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Page indicator
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: starterPets.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: starterPets[_currentPage].color,
                      dotColor: Colors.grey.withOpacity(0.3),
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3,
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Action buttons
                Row(
                  children: [
                    // View Stats button
                    Expanded(
                      flex: 1,
                      child: BounceButton(
                        onPressed: _viewStats,
                        backgroundColor: Colors.white,
                        buttonColor: Colors.white.withOpacity(0.8),
                        foregroundColor: starterPets[_currentPage].color,
                        height: 56,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.query_stats,
                              size: 20,
                              color: starterPets[_currentPage].color,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Stats',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 12),
                    
                    // Select button
                    Expanded(
                      flex: 2,
                      child: BounceButton(
                        onPressed: _selectPet,
                        backgroundColor: starterPets[_currentPage].color,
                        buttonColor: starterPets[_currentPage].color.withOpacity(0.8),
                        foregroundColor: Colors.white,
                        height: 56,
                        width: double.infinity,
                        child: const Text(
                          'Select This Pet',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 10),
                
                // Take personality quiz
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      // TODO: Navigate to personality quiz
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Personality quiz will be implemented later'),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.psychology_outlined,
                      color: Colors.grey.shade600,
                      size: 18,
                    ),
                    label: Text(
                      'Not sure? Take a personality quiz',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPetCard(PetData pet) {
    return Card(
      elevation: 6,
      shadowColor: pet.color.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Pet icon with animated container
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                color: pet.color.withOpacity(0.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: pet.color.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                pet.icon,
                size: MediaQuery.of(context).size.width * 0.2,
                color: pet.color,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Pet name
            Text(
              pet.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: pet.color,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Pet temperament
            Text(
              pet.temperament,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Pet traits
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: pet.traits.map((trait) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: pet.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    trait,
                    style: TextStyle(
                      color: pet.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}