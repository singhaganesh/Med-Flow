import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/section_label.dart';

class PendingApprovalScreen extends ConsumerWidget {
  const PendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionLabel(label: 'Verification Pending'),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Almost there,\n${user?.fullName.split(' ')[0] ?? 'Doctor'}.',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Your account for ${user?.orgName ?? 'the clinic'} has been created. A Head Doctor needs to approve your registration before you can access patient data.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.mutedForeground),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.primary),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'You will receive a push notification once your account is activated.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => ref.read(authProvider.notifier).logout(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.muted,
                  foregroundColor: AppColors.textMain,
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
