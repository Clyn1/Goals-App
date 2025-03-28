import 'package:flutter/material.dart';
import 'pet_data.dart';

class PetBenefit {
  final String title;
  final String description;
  final IconData icon;
  
  const PetBenefit({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class PetStatsData {
  final List<String> availablePersonalityTraits;
  final Map<String, List<String>> defaultTraitsByPet;
  final Map<String, List<PetBenefit>> benefitsByPet;
  
  const PetStatsData({
    required this.availablePersonalityTraits,
    required this.defaultTraitsByPet,
    required this.benefitsByPet,
  });
  
  List<String> getDefaultTraitsForPet(String petName) {
    return defaultTraitsByPet[petName] ?? [];
  }
  
  List<PetBenefit> getBenefitsForPet(String petName) {
    return benefitsByPet[petName] ?? [];
  }
}

// Create a singleton instance that can be used throughout the app
final petStatsData = PetStatsData(
  availablePersonalityTraits: [
    'Adventurous', 'Playful', 'Curious', 'Friendly', 'Loyal',
    'Cautious', 'Independent', 'Clever', 'Energetic', 'Calm'
  ],
  
  defaultTraitsByPet: {
    'Puppy': ['Playful', 'Loyal', 'Energetic'],
    'Kitten': ['Independent', 'Curious', 'Clever'],
    'Fox Kit': ['Adventurous', 'Clever', 'Cautious'],
  },
  
  benefitsByPet: {
    'Puppy': [
      PetBenefit(
        title: 'Daily Streak Booster',
        description: 'Motivates you to maintain daily goal streaks with extra rewards for consistency.',
        icon: Icons.trending_up_rounded,
      ),
      PetBenefit(
        title: 'Exercise Motivation',
        description: 'Particularly effective at encouraging physical activity and exercise-related goals.',
        icon: Icons.fitness_center,
      ),
      PetBenefit(
        title: 'Mood Tracking',
        description: 'Helps track your mood patterns in relation to goal completion and activity levels.',
        icon: Icons.mood,
      ),
    ],
    
    'Kitten': [
      PetBenefit(
        title: 'Focus Timer Helper',
        description: 'Enhances focus sessions with productivity timers and distraction prevention.',
        icon: Icons.timer,
      ),
      PetBenefit(
        title: 'Learning Achievements',
        description: 'Celebrates learning milestones and educational accomplishments.',
        icon: Icons.school,
      ),
      PetBenefit(
        title: 'Sleep Quality Tracking',
        description: 'Monitors and suggests improvements for sleep habits and routines.',
        icon: Icons.nightlight_round,
      ),
    ],
    
    'Fox Kit': [
      PetBenefit(
        title: 'Creative Inspiration',
        description: 'Provides creative prompts and inspiration when you need to think outside the box.',
        icon: Icons.lightbulb,
      ),
      PetBenefit(
        title: 'Adaptability Coach',
        description: 'Helps you adjust to changing circumstances with flexible goal modifications.',
        icon: Icons.change_circle,
      ),
      PetBenefit(
        title: 'Problem-Solving Helper',
        description: 'Offers strategic assistance for breaking down complex goals into manageable steps.',
        icon: Icons.extension,
      ),
    ],
  },
); 