import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  bool _isOtpSent = false;
  bool _isLoading = false;
  String? _verificationId;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authStateProvider);
    
    // Listen to auth state changes
    ref.listen<AuthState>(authStateProvider, (previous, next) {
      if (next.isAuthenticated) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else if (next.error != null) {
        _showErrorSnackBar(next.error!);
      }
    });
    
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              
              // App Logo and Title
              _buildHeader(theme),
              
              const SizedBox(height: 60),
              

              
              // Login Form
              _buildLoginForm(theme),
              
              const SizedBox(height: 40),
              
              // Terms and Privacy
              _buildTermsText(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.home_work,
            size: 50,
            color: theme.colorScheme.primary,
          ),
        ),
        
        const SizedBox(height: 24),
        
        const Text(
          'Welcome to',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white70,
            fontWeight: FontWeight.w300,
          ),
        ),
        
        const Text(
          'HoodJunction',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        
        const SizedBox(height: 8),
        
        const Text(
          'Your Society Management Platform',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }





  Widget _buildLoginForm(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _isOtpSent ? _otpFormKey : _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _isOtpSent ? 'Verify OTP' : 'Login with Phone',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 24),
            
            if (!_isOtpSent) ...[
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '+91 9876543210',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  final formatted = FirebaseAuthService.formatPhoneNumber(value);
                  if (!FirebaseAuthService.isValidPhoneNumber(formatted)) {
                    return 'Please enter a valid phone number with +91';
                  }
                  return null;
                },
              ),
            ] else ...[
              Text(
                'Enter the OTP sent to ${_phoneController.text}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'OTP',
                  hintText: '123456',
                  prefixIcon: Icon(Icons.security),
                  border: OutlineInputBorder(),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  if (value.length != 6) {
                    return 'OTP must be 6 digits';
                  }
                  return null;
                },
              ),
              
              if (_otpAttempts > 0) ...[
                const SizedBox(height: 8),
                Text(
                  'Attempts remaining: ${_maxOtpAttempts - _otpAttempts}',
                  style: TextStyle(
                    fontSize: 12,
                    color: _otpAttempts >= _maxOtpAttempts ? Colors.red : Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
            
            const SizedBox(height: 24),
            
            ElevatedButton(
              onPressed: _isLoading || (_isOtpSent && _otpAttempts >= _maxOtpAttempts) 
                  ? null 
                  : _handleSubmit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      _isOtpSent ? 'Verify OTP' : 'Send OTP',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
            
            if (_isOtpSent) ...[
              const SizedBox(height: 16),
              
              TextButton(
                onPressed: _isLoading ? null : _resendOtp,
                child: const Text('Resend OTP'),
              ),
              
              TextButton(
                onPressed: _isLoading ? null : () {
                  setState(() {
                    _isOtpSent = false;
                    _otpController.clear();
                    _otpAttempts = 0;
                    _verificationId = null;
                  });
                },
                child: const Text('Change Phone Number'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTermsText(ThemeData theme) {
    return Text(
      'By continuing, you agree to our Terms of Service and Privacy Policy',
      style: TextStyle(
        fontSize: 12,
        color: Colors.white.withValues(alpha: 0.8),
      ),
      textAlign: TextAlign.center,
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate() && !_isOtpSent) return;
    if (!_otpFormKey.currentState!.validate() && _isOtpSent) return;

    setState(() {
      _isLoading = true;
    });

    try {
      if (!_isOtpSent) {
        await _sendOtp();
      } else {
        await _verifyOtp();
      }
    } catch (e) {
      _showErrorSnackBar(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _sendOtp() async {
    final authNotifier = ref.read(authStateProvider.notifier);
    final verificationId = await authNotifier.sendOTP(_phoneController.text.trim());
    
    if (verificationId != null) {
      setState(() {
        _verificationId = verificationId;
        _isOtpSent = true;
        _otpAttempts = 0;
      });
      _showSuccessSnackBar('OTP sent successfully');
    }
  }

  Future<void> _verifyOtp() async {
    if (_verificationId == null) {
      _showErrorSnackBar('Verification ID not found');
      return;
    }

    _otpAttempts++;
    
    final authNotifier = ref.read(authStateProvider.notifier);
    await authNotifier.verifyOTPAndLogin(
      verificationId: _verificationId!,
      otp: _otpController.text.trim(),
    );
  }

  Future<void> _handleBiometricLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final authNotifier = ref.read(authStateProvider.notifier);
      await authNotifier.loginWithBiometric();
    } catch (e) {
      _showErrorSnackBar(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resendOtp() async {
    setState(() {
      _isLoading = true;
      _isOtpSent = false;
      _otpController.clear();
      _otpAttempts = 0;
    });

    try {
      await _sendOtp();
    } catch (e) {
      _showErrorSnackBar(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
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
        duration: const Duration(seconds: 2),
      ),
    );
  }
}