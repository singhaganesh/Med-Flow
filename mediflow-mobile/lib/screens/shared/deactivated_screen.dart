import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/section_label.dart';

class DeactivatedAccountScreen extends ConsumerWidget {
  const DeactivatedAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionLabel(label: 'Account Restricted'),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Access suspended.',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppColors.error),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Your account has been deactivated by your clinic administrator. If you believe this is a mistake, please contact your Head Doctor.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.mutedForeground),
              ),
              const SizedBox(height: AppSpacing.xxl),
              ElevatedButton(
                onPressed: () => ref.read(authProvider.notifier).logout(),
                child: const Text('Return to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
