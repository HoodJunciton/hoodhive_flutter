import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/society_model.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/onboarding/onboarding_progress.dart';

class SocietySelectionScreen extends ConsumerStatefulWidget {
  const SocietySelectionScreen({super.key});

  @override
  ConsumerState<SocietySelectionScreen> createState() => _SocietySelectionScreenState();
}

class _SocietySelectionScreenState extends ConsumerState<SocietySelectionScreen> {
  final _searchController = TextEditingController();
  SocietyModel? _selectedSociety;
  List<SocietyModel> _societies = [];
  List<SocietyModel> _filteredSocieties = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSocieties();
    _searchController.addListener(_filterSocieties);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSocieties() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _societies = [
        SocietyModel(
          id: '1',
          name: 'Green Valley Apartments',
          address: '123 Green Valley Road',
          city: 'Mumbai',
          state: 'Maharashtra',
          pincode: '400001',
          description: 'Premium residential complex with modern amenities',
          imageUrl: 'https://example.com/green-valley.jpg',
          totalUnits: 120,
          occupiedUnits: 95,
          amenities: ['Swimming Pool', 'Gym', 'Garden', 'Security'],
          createdAt: DateTime.now(),
          isActive: true,
        ),
        SocietyModel(
          id: '2',
          name: 'Sunrise Heights',
          address: '456 Sunrise Avenue',
          city: 'Mumbai',
          state: 'Maharashtra',
          pincode: '400002',
          description: 'Modern living with excellent connectivity',
          imageUrl: 'https://example.com/sunrise-heights.jpg',
          totalUnits: 80,
          occupiedUnits: 65,
          amenities: ['Parking', 'Elevator', 'Power Backup'],
          createdAt: DateTime.now(),
          isActive: true,
        ),
        SocietyModel(
          id: '3',
          name: 'Royal Gardens',
          address: '789 Royal Street',
          city: 'Mumbai',
          state: 'Maharashtra',
          pincode: '400003',
          description: 'Luxury apartments with garden views',
          imageUrl: 'https://example.com/royal-gardens.jpg',
          totalUnits: 200,
          occupiedUnits: 180,
          amenities: ['Club House', 'Tennis Court', 'Children Play Area'],
          createdAt: DateTime.now(),
          isActive: true,
        ),
      ];
      _filteredSocieties = _societies;
      _isLoading = false;
    });
  }

  void _filterSocieties() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSocieties = _societies.where((society) {
        return society.name.toLowerCase().contains(query) ||
               society.address.toLowerCase().contains(query) ||
               society.city.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _selectSociety(SocietyModel society) {
    setState(() {
      _selectedSociety = society;
    });
  }

  void _continue() {
    if (_selectedSociety != null) {
      Navigator.pushNamed(
        context,
        '/unit-selection',
        arguments: _selectedSociety,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Society'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress Indicator
          const OnboardingProgress(
            currentStep: 1,
            totalSteps: 4,
            stepLabels: ['Profile', 'Society', 'Unit', 'Request'],
          ),
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find Your Society',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Search and select the society where you live',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Search Field
                CustomTextField(
                  controller: _searchController,
                  label: 'Search societies...',
                  prefixIcon: Icons.search,
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                ),
              ],
            ),
          ),
          
          // Societies List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredSocieties.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: _filteredSocieties.length,
                        itemBuilder: (context, index) {
                          final society = _filteredSocieties[index];
                          return _buildSocietyCard(society);
                        },
                      ),
          ),
          
          // Continue Button
          if (_selectedSociety != null)
            Padding(
              padding: const EdgeInsets.all(24),
              child: CustomButton(
                onPressed: _continue,
                text: 'Continue',
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No societies found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search terms',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocietyCard(SocietyModel society) {
    final isSelected = _selectedSociety?.id == society.id;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: isSelected ? 8 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () => _selectSociety(society),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Society Image
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: Icon(
                      Icons.apartment,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Society Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          society.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${society.address}, ${society.city}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  // Selection Indicator
                  if (isSelected)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Society Stats
              Row(
                children: [
                  _buildStatChip(
                    icon: Icons.home,
                    label: '${society.occupiedUnits}/${society.totalUnits} Units',
                  ),
                  const SizedBox(width: 8),
                  _buildStatChip(
                    icon: Icons.location_pin,
                    label: society.pincode,
                  ),
                ],
              ),
              
              if (society.amenities.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: society.amenities.take(3).map((amenity) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        amenity,
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}