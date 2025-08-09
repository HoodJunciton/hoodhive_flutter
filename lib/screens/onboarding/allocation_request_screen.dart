import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/society_model.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';

class AllocationRequestScreen extends ConsumerStatefulWidget {
  final SocietyModel society;
  final UnitModel unit;
  
  const AllocationRequestScreen({
    super.key,
    required this.society,
    required this.unit,
  });

  @override
  ConsumerState<AllocationRequestScreen> createState() => _AllocationRequestScreenState();
}

class _AllocationRequestScreenState extends ConsumerState<AllocationRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Submit allocation request to API
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/request-submitted',
          (route) => false,
          arguments: {
            'society': widget.society,
            'unit': widget.unit,
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit request: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Allocation Request'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Request Unit Allocation',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Review your selection and send allocation request',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Selection Summary
              _buildSummaryCard(),
              
              const SizedBox(height: 24),
              
              // Message Field
              CustomTextField(
                controller: _messageController,
                label: 'Message to Society Admin (Optional)',
                prefixIcon: Icons.message_outlined,
                maxLines: 4,
                hintText: 'Add any additional information or special requests...',
              ),
              
              const SizedBox(height: 32),
              
              // Terms and Conditions
              _buildTermsSection(),
              
              const SizedBox(height: 32),
              
              // Submit Button
              CustomButton(
                onPressed: _isLoading ? null : _submitRequest,
                text: 'Submit Request',
                isLoading: _isLoading,
              ),
              
              const SizedBox(height: 16),
              
              // Cancel Button
              TextButton(
                onPressed: _isLoading ? null : () {
                  Navigator.pop(context);
                },
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selection Summary',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Society Info
            _buildSummaryRow(
              icon: Icons.apartment,
              title: 'Society',
              value: widget.society.name,
              subtitle: '${widget.society.address}, ${widget.society.city}',
            ),
            
            const Divider(height: 24),
            
            // Unit Info
            _buildSummaryRow(
              icon: Icons.home,
              title: 'Unit',
              value: widget.unit.displayName,
              subtitle: '${widget.unit.type.displayName} • ${widget.unit.area.toInt()} sq ft',
            ),
            
            const Divider(height: 24),
            
            // Maintenance Info
            _buildSummaryRow(
              icon: Icons.account_balance_wallet,
              title: 'Monthly Maintenance',
              value: '₹${widget.unit.monthlyMaintenance}',
              subtitle: 'Per month',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow({
    required IconData icon,
    required String title,
    required String value,
    String? subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[500],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTermsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.blue[700],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Important Information',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '• Your request will be reviewed by the society admin\n'
            '• You will be notified once the request is processed\n'
            '• Approval may require additional documentation\n'
            '• Monthly maintenance is subject to society rules',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.blue[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}