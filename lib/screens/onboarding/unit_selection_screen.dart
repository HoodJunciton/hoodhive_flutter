import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/society_model.dart';
import '../../widgets/common/custom_button.dart';

class UnitSelectionScreen extends ConsumerStatefulWidget {
  final SocietyModel society;
  
  const UnitSelectionScreen({
    super.key,
    required this.society,
  });

  @override
  ConsumerState<UnitSelectionScreen> createState() => _UnitSelectionScreenState();
}

class _UnitSelectionScreenState extends ConsumerState<UnitSelectionScreen> {
  UnitModel? _selectedUnit;
  List<UnitModel> _units = [];
  bool _isLoading = true;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadUnits();
  }

  Future<void> _loadUnits() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _units = [
        UnitModel(
          id: '1',
          societyId: widget.society.id,
          unitNumber: '101',
          block: 'A',
          floor: '1',
          type: UnitType.twoBHK,
          area: 1200,
          bedrooms: 2,
          bathrooms: 2,
          isOccupied: false,
          monthlyMaintenance: 3500,
        ),
        UnitModel(
          id: '2',
          societyId: widget.society.id,
          unitNumber: '102',
          block: 'A',
          floor: '1',
          type: UnitType.threeBHK,
          area: 1500,
          bedrooms: 3,
          bathrooms: 2,
          isOccupied: true,
          currentResidentId: 'user123',
          monthlyMaintenance: 4200,
        ),
        UnitModel(
          id: '3',
          societyId: widget.society.id,
          unitNumber: '201',
          block: 'A',
          floor: '2',
          type: UnitType.twoBHK,
          area: 1200,
          bedrooms: 2,
          bathrooms: 2,
          isOccupied: false,
          monthlyMaintenance: 3500,
        ),
        UnitModel(
          id: '4',
          societyId: widget.society.id,
          unitNumber: '301',
          block: 'B',
          floor: '3',
          type: UnitType.oneBHK,
          area: 800,
          bedrooms: 1,
          bathrooms: 1,
          isOccupied: false,
          monthlyMaintenance: 2800,
        ),
        UnitModel(
          id: '5',
          societyId: widget.society.id,
          unitNumber: '401',
          block: 'B',
          floor: '4',
          type: UnitType.threeBHK,
          area: 1600,
          bedrooms: 3,
          bathrooms: 3,
          isOccupied: false,
          monthlyMaintenance: 4500,
        ),
      ];
      _isLoading = false;
    });
  }

  List<UnitModel> get _filteredUnits {
    if (_selectedFilter == 'All') {
      return _units;
    } else if (_selectedFilter == 'Available') {
      return _units.where((unit) => !unit.isOccupied).toList();
    } else {
      return _units.where((unit) => unit.type.displayName == _selectedFilter).toList();
    }
  }

  void _selectUnit(UnitModel unit) {
    if (!unit.isOccupied) {
      setState(() {
        _selectedUnit = unit;
      });
    }
  }

  void _continue() {
    if (_selectedUnit != null) {
      Navigator.pushNamed(
        context,
        '/allocation-request',
        arguments: {
          'society': widget.society,
          'unit': _selectedUnit,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Unit'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Your Unit',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Select an available unit in ${widget.society.name}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Filters
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('All'),
                _buildFilterChip('Available'),
                _buildFilterChip('1 BHK'),
                _buildFilterChip('2 BHK'),
                _buildFilterChip('3 BHK'),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Units Grid
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredUnits.isEmpty
                    ? _buildEmptyState()
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: _filteredUnits.length,
                        itemBuilder: (context, index) {
                          final unit = _filteredUnits[index];
                          return _buildUnitCard(unit);
                        },
                      ),
          ),
          
          // Continue Button
          if (_selectedUnit != null)
            Padding(
              padding: const EdgeInsets.all(24),
              child: CustomButton(
                onPressed: _continue,
                text: 'Send Allocation Request',
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = label;
          });
        },
        backgroundColor: Colors.grey[100],
        selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
        checkmarkColor: Theme.of(context).primaryColor,
        labelStyle: TextStyle(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[700],
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No units found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitCard(UnitModel unit) {
    final isSelected = _selectedUnit?.id == unit.id;
    final isAvailable = !unit.isOccupied;
    
    return Card(
      elevation: isSelected ? 8 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected 
              ? Theme.of(context).primaryColor 
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: isAvailable ? () => _selectUnit(unit) : null,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isAvailable ? null : Colors.grey[100],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Unit Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    unit.displayName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isAvailable ? null : Colors.grey[500],
                    ),
                  ),
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
                    )
                  else if (!isAvailable)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Occupied',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.red[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Unit Type
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  unit.type.displayName,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Unit Details
              _buildDetailRow(
                Icons.square_foot,
                '${unit.area.toInt()} sq ft',
                isAvailable,
              ),
              const SizedBox(height: 4),
              _buildDetailRow(
                Icons.bed,
                '${unit.bedrooms} Bed, ${unit.bathrooms} Bath',
                isAvailable,
              ),
              const SizedBox(height: 4),
              _buildDetailRow(
                Icons.layers,
                'Floor ${unit.floor}',
                isAvailable,
              ),
              
              const Spacer(),
              
              // Maintenance
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isAvailable 
                      ? Colors.green[50] 
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '₹${unit.monthlyMaintenance}/month',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isAvailable 
                        ? Colors.green[700] 
                        : Colors.grey[500],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, bool isAvailable) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: isAvailable ? Colors.grey[600] : Colors.grey[400],
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isAvailable ? Colors.grey[600] : Colors.grey[400],
          ),
        ),
      ],
    );
  }
}