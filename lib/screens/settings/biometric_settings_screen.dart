import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/services/biometric_service.dart';

class BiometricSettingsScreen extends ConsumerStatefulWidget {
  const BiometricSettingsScreen({super.key});

  @override
  ConsumerState<BiometricSettingsScreen> createState() => _BiometricSettingsScreenState();
}

class _BiometricSettingsScreenState extends ConsumerState<BiometricSettingsScreen> {
  bool _isLoading = false;
  bool _biometricAvailable = false;
  bool _biometricEnabled = false;
  List<String> _availableBiometrics = [];

  @override
  void initState() {
    super.initState();
    _checkBiometricStatus();
  }

  Future<void> _checkBiometricStatus() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final available = await BiometricService.isBiometricAvailable();
      final enabled = await BiometricService.isBiometricLoginEnabled();
      final biometrics = await BiometricService.getAvailableBiometrics();

      setState(() {
        _biometricAvailable = available;
        _biometricEnabled = enabled;
        _availableBiometrics = biometrics;
      });
    } catch (e) {
      _showErrorSnackBar('Failed to check biometric status: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Settings'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBiometricStatusCard(theme),
                  const SizedBox(height: 20),
                  if (_biometricAvailable) ...[
                    _buildBiometricToggleCard(theme),
                    const SizedBox(height: 20),
                    _buildAvailableBiometricsCard(theme),
                    const SizedBox(height: 20),
                  ],
                  _buildSecurityInfoCard(theme),
                ],
              ),
            ),
    );
  }

  Widget _buildBiometricStatusCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _biometricAvailable ? Icons.check_circle : Icons.error,
                  color: _biometricAvailable ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  'Biometric Status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              _biometricAvailable
                  ? 'Biometric authentication is available on this device'
                  : 'Biometric authentication is not available on this device',
              style: theme.textTheme.bodyMedium,
            ),
            if (!_biometricAvailable) ...[
              const SizedBox(height: 8),
              Text(
                'Please ensure you have set up fingerprint or face recognition in your device settings.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBiometricToggleCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Login',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enable biometric authentication for quick and secure login',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Enable Biometric Login'),
              subtitle: Text(
                _biometricEnabled
                    ? 'You can use biometric authentication to login'
                    : 'Use your fingerprint or face to login quickly',
              ),
              value: _biometricEnabled,
              onChanged: _handleBiometricToggle,
              activeColor: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableBiometricsCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Biometric Methods',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (_availableBiometrics.isEmpty)
              Text(
                'No biometric methods detected',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              )
            else
              ...._availableBiometrics.map((biometric) => ListTile(
                    leading: Icon(_getBiometricIcon(biometric)),
                    title: Text(_getBiometricName(biometric)),
                    contentPadding: EdgeInsets.zero,
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityInfoCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.security, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Security Information',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              '• Your biometric data is stored securely on your device',
            ),
            const SizedBox(height: 4),
            const Text(
              '• Authentication tokens are encrypted using device security',
            ),
            const SizedBox(height: 4),
            const Text(
              '• You can disable biometric login at any time',
            ),
            const SizedBox(height: 4),
            const Text(
              '• Fallback to OTP login is always available',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleBiometricToggle(bool value) async {
    if (value) {
      await _enableBiometricLogin();
    } else {
      await _disableBiometricLogin();
    }
  }

  Future<void> _enableBiometricLogin() async {
    try {
      // First authenticate with biometric to ensure it works
      final authenticated = await BiometricService.authenticate(
        reason: 'Please authenticate to enable biometric login',
      );

      if (!authenticated) {
        _showErrorSnackBar('Biometric authentication failed');
        return;
      }

      // Enable biometric login through auth provider
      final authNotifier = ref.read(authStateProvider.notifier);
      final success = await authNotifier.enableBiometricLogin();

      if (success) {
        setState(() {
          _biometricEnabled = true;
        });
        _showSuccessSnackBar('Biometric login enabled successfully');
      } else {
        _showErrorSnackBar('Failed to enable biometric login');
      }
    } catch (e) {
      _showErrorSnackBar('Error enabling biometric login: $e');
    }
  }

  Future<void> _disableBiometricLogin() async {
    try {
      await BiometricService.disableBiometricLogin();
      setState(() {
        _biometricEnabled = false;
      });
      _showSuccessSnackBar('Biometric login disabled');
    } catch (e) {
      _showErrorSnackBar('Error disabling biometric login: $e');
    }
  }

  IconData _getBiometricIcon(String biometric) {
    switch (biometric.toLowerCase()) {
      case 'fingerprint':
        return Icons.fingerprint;
      case 'face':
        return Icons.face;
      case 'iris':
        return Icons.visibility;
      default:
        return Icons.security;
    }
  }

  String _getBiometricName(String biometric) {
    switch (biometric.toLowerCase()) {
      case 'fingerprint':
        return 'Fingerprint';
      case 'face':
        return 'Face Recognition';
      case 'iris':
        return 'Iris Recognition';
      default:
        return biometric;
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}