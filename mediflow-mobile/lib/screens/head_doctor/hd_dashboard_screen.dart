import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../../core/constants.dart';
import '../../providers/auth_provider.dart';
import '../../services/auth_service.dart';
import '../../widgets/section_label.dart';

class HdDashboardScreen extends ConsumerWidget {
  const HdDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            onPressed: () => ref.read(authProvider.notifier).logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionLabel(label: 'Clinic Overview'),
            const SizedBox(height: 16),
            Text(
              'Welcome,\n${user?.fullName.split(' ')[0]}.',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 32),
            _ActionButton(
              title: 'Invite a Doctor',
              subtitle: 'Generate a 48h secure link',
              icon: Icons.person_add_outlined,
              onTap: () => _showInviteDialog(context, ref, 'DOCTOR'),
            ),
            const SizedBox(height: 16),
            _ActionButton(
              title: 'Clinic Settings',
              subtitle: 'Manage roles and billing',
              icon: Icons.settings_outlined,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _showInviteDialog(BuildContext context, WidgetRef ref, String role) async {
    // In a real app, we'd call the backend to get the token.
    // For now, we simulate the link generation.
    final dio = ref.read(authServiceProvider);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invite $role'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Generating a unique invitation link for your clinic...'),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );

    // TODO: Call real generate endpoint
    await Future.delayed(const Duration(seconds: 1));
    if (!context.mounted) return;
    Navigator.pop(context);

    const fakeLink = 'https://app.mediflow.in/register?token=abc-123-xyz';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invite Link Ready'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Share this link with the doctor. It will expire in 48 hours.'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.muted,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(fakeLink, style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(const ClipboardData(text: fakeLink));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Link copied to clipboard')),
              );
            },
            child: const Text('Copy & Close'),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge),
                    Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.mutedForeground)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.border),
            ],
          ),
        ),
      ),
    );
  }
}
