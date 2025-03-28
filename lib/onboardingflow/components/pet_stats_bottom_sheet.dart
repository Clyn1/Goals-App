import 'package:flutter/material.dart';
import '../models/pet_data.dart';
import '../models/pet_stats_data.dart';
import 'bounce_button.dart';

class PetStatsBottomSheet extends StatefulWidget {
  final PetData pet;
  
  const PetStatsBottomSheet({
    super.key,
    required this.pet,
  });

  // Helper method to show the bottom sheet
  static Future<void> show(BuildContext context, PetData pet) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      routeSettings: const RouteSettings(name: "pet_stats_sheet"),
      builder: (context) => PetStatsBottomSheet(pet: pet),
    );
  }

  @override
  State<PetStatsBottomSheet> createState() => _PetStatsBottomSheetState();
}

class _PetStatsBottomSheetState extends State<PetStatsBottomSheet> {
  final List<String> _selectedTraits = [];
  
  @override
  void initState() {
    super.initState();
    
    // Pre-select default traits for this pet
    _selectedTraits.addAll(
      petStatsData.getDefaultTraitsForPet(widget.pet.name)
    );
  }
  
  void _toggleTrait(String trait) {
    setState(() {
      if (_selectedTraits.contains(trait)) {
        _selectedTraits.remove(trait);
      } else {
        // Allow a maximum of 4 selected traits
        if (_selectedTraits.length < 4) {
          _selectedTraits.add(trait);
        } else {
          // Show message about trait limit
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You can select up to 4 personality traits'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the list of benefits for this pet
    final petBenefits = petStatsData.getBenefitsForPet(widget.pet.name);
    
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: FractionallySizedBox(
        heightFactor: 0.85,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Handle bar and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey.shade600,
                          size: 24,
                        ),
                        tooltip: 'Close',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              // Make everything below the handle scrollable
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Row(
                        children: [
                          // Pet icon
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: widget.pet.color.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              widget.pet.icon,
                              size: 40,
                              color: widget.pet.color,
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                          
                          // Pet name and type
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.pet.name,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: widget.pet.color,
                                  ),
                                ),
                                Text(
                                  widget.pet.temperament,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Edit name button
                          IconButton(
                            onPressed: () {
                              // Show a dialog for pet name editing (placeholder)
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Pet name editing will be implemented in the next screen'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: widget.pet.color,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // About section
                      const Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'About This Buddy',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Pet description card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: widget.pet.color.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: widget.pet.color.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          widget.pet.description,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Personality traits section
                      Row(
                        children: [
                          Icon(
                            Icons.psychology,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Personality Traits',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${_selectedTraits.length}/4',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: widget.pet.color,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Personality traits description
                      Text(
                        'Select up to 4 personality traits for your pet companion:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Personality traits chip selection
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: petStatsData.availablePersonalityTraits.map((trait) {
                          final isSelected = _selectedTraits.contains(trait);
                          return FilterChip(
                            selected: isSelected,
                            label: Text(trait),
                            onSelected: (_) => _toggleTrait(trait),
                            selectedColor: widget.pet.color.withOpacity(0.2),
                            checkmarkColor: widget.pet.color,
                            labelStyle: TextStyle(
                              color: isSelected ? widget.pet.color : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          );
                        }).toList(),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Benefits section
                      const Row(
                        children: [
                          Icon(
                            Icons.stars,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Buddy Benefits',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Benefits list
                      ...petBenefits.map((benefit) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildBenefitCard(
                            title: benefit.title,
                            description: benefit.description,
                            icon: benefit.icon,
                            color: widget.pet.color,
                          ),
                        );
                      }).toList(),
                      
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Save and Continue button
              BounceButton(
                onPressed: () {
                  // Save personality and continue (placeholder)
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Personality traits saved: ${_selectedTraits.join(", ")}',
                      ),
                      duration: const Duration(seconds: 2),
                      backgroundColor: widget.pet.color,
                    ),
                  );
                },
                backgroundColor: widget.pet.color,
                buttonColor: widget.pet.color.withOpacity(0.8),
                foregroundColor: Colors.white,
                height: 56,
                width: double.infinity,
                child: const Text(
                  'Confirm Buddy',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildBenefitCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
} 