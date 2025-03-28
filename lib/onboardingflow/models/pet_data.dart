import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PetData {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final String temperament;
  final List<String> traits;

  PetData({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.temperament,
    required this.traits,
  });
}

// List of available starter pets
final List<PetData> starterPets = [
  PetData(
    name: 'Puppy',
    description: 'Loyal and energetic companion that helps you build consistent habits. Great for physical goals and daily routines.',
    icon: Symbols.pets_rounded,
    color: const Color(0xFF5B9BD5), // Blue
    temperament: 'Energetic & Loyal',
    traits: ['Friendly', 'Active', 'Enthusiastic'],
  ),
  PetData(
    name: 'Kitten',
    description: 'Curious and independent companion that rewards quality over quantity. Perfect for focus-based goals and learning.',
    icon: FontAwesomeIcons.cat,
    color: const Color(0xFFED7D31), // Orange
    temperament: 'Curious & Independent',
    traits: ['Intelligent', 'Observant', 'Graceful'],
  ),
  PetData(
    name: 'Fox Kit',
    description: 'Clever and adaptable companion for creative goals. Helps you think outside the box and find unique solutions.',
    icon: FontAwesomeIcons.firefox,
    color: const Color(0xFFA5A5A5), // Silver/Gray
    temperament: 'Clever & Adaptable',
    traits: ['Creative', 'Resourceful', 'Persistent'],
  ),
]; 