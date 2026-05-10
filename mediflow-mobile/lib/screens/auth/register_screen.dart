import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants.dart';
import '../../models/invite.dart';
import '../../services/auth_service.dart';
import '../../widgets/section_label.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  final String? inviteToken;
  final String? role;

  const RegisterScreen({super.key, this.inviteToken, this.role});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clinicNameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool _isValidatingToken = false;
  InviteValidationResponse? _inviteData;
  String? _tokenError;

  @override
  void initState() {
    super.initState();
    if (widget.inviteToken != null) {
      _validateToken();
    }
  }

  @override
  void dispose() {
    _clinicNameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _validateToken() async {
    setState(() => _isValidatingToken = true);
    final data = await ref.read(authServiceProvider).validateInviteToken(widget.inviteToken!);
    
    if (mounted) {
      setState(() {
        _isValidatingToken = false;
        if (data != null) {
          _inviteData = data;
          _clinicNameController.text = data.clinicName;
        } else {
          _tokenError = 'Invalid or expired invitation link.';
        }
      });
    }
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    bool success;
    if (widget.inviteToken != null) {
      success = await ref.read(authServiceProvider).registerStaff({
        'inviteToken': widget.inviteToken,
        'role': widget.role,
        'fullName': _fullNameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      });
    } else {
      success = await ref.read(authServiceProvider).registerHeadDoctor({
        'clinicName': _clinicNameController.text,
        'fullName': _fullNameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      });
    }

    if (mounted) setState(() => _isLoading = false);

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.inviteToken != null 
            ? 'Registration successful! Waiting for approval.' 
            : 'Clinic registered! Please log in.')),
        );
        context.go('/login');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration failed. Please check your data.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isValidatingToken) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_tokenError != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: AppColors.error),
                const SizedBox(height: 16),
                Text(_tokenError!, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 24),
                ElevatedButton(onPressed: () => context.go('/login'), child: const Text('Back to Login')),
              ],
            ),
          ),
        ),
      );
    }

    final isStaff = widget.inviteToken != null;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xxl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionLabel(label: isStaff ? 'Join Clinic' : 'Get Started'),
                const SizedBox(height: AppSpacing.md),
                Text(
                  isStaff ? 'Join the team at\n${_inviteData?.clinicName}.' : 'Onboard your\nclinic today.',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                if (isStaff) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'You are joining as a ${_inviteData?.role.toLowerCase()}.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                  ),
                ],
                const SizedBox(height: AppSpacing.xxl),
                if (!isStaff)
                  TextFormField(
                    controller: _clinicNameController,
                    decoration: const InputDecoration(
                      hintText: 'Clinic Name',
                      prefixIcon: Icon(Icons.local_hospital_outlined, color: AppColors.mutedForeground),
                    ),
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    hintText: 'Your Full Name',
                    prefixIcon: Icon(Icons.person_outline, color: AppColors.mutedForeground),
                  ),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Work Email',
                    prefixIcon: Icon(Icons.email_outlined, color: AppColors.mutedForeground),
                  ),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Create Password',
                    prefixIcon: Icon(Icons.lock_outline, color: AppColors.mutedForeground),
                  ),
                  validator: (v) => v!.length < 6 ? 'Min 6 characters' : null,
                ),
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(isStaff ? 'Join Clinic' : 'Register Clinic'),
                ),
                const SizedBox(height: AppSpacing.xl),
                Center(
                  child: TextButton(
                    onPressed: () => context.go('/login'),
                    child: Text(
                      'Already have an account? Login',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.mutedForeground,
                            decoration: TextDecoration.underline,
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
}
