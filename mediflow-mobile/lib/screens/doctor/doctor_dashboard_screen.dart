import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../../core/constants.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../services/auth_service.dart';
import '../../widgets/section_label.dart';

class DoctorDashboardScreen extends ConsumerWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Portal'),
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
            const SectionLabel(label: 'Clinical Hub'),
            const SizedBox(height: 16),
            Text(
              'Welcome,\nDr. ${user?.fullName.split(' ')[0]}.',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 32),
            _SummaryCard(
              title: 'Patients',
              value: '12',
              icon: Icons.people_outline,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _SummaryCard(
              title: 'Tasks Pending',
              value: '05',
              icon: Icons.assignment_outlined,
              onTap: () {},
            ),
            const SizedBox(height: 32),
            const SectionLabel(label: 'Team Management'),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person_add_outlined, color: AppColors.primary),
                title: const Text('Invite your Agent'),
                subtitle: const Text('Field or desk staff assigned to you'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showInviteDialog(context, ref, user?.id),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInviteDialog(BuildContext context, WidgetRef ref, String? doctorId) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Invite Agent'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Generating a unique invitation link for your team...'),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );

    try {
      final dio = ref.read(dioProvider);
      final response = await dio.post('/invites/generate', data: {
        'role': 'AGENT',
        'assignedDoctorId': doctorId,
      });

      if (!context.mounted) return;
      Navigator.pop(context); // Close loading

      if (response.statusCode == 200) {
        final token = response.data['data']['token'];

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Agent Invite Ready'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Share this code with your agent. It will expire in 12 hours.'),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.muted,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                  ),
                  child: SelectableText(
                    token, 
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                      letterSpacing: 1.2,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: token));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Code copied to clipboard')),
                  );
                },
                child: const Text('Copy & Close'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate invite: $e')),
      );
    }
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const _SummaryCard({
    required this.title,
    required this.value,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.mutedForeground)),
                  const SizedBox(height: 4),
                  Text(value, style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppColors.primary)),
                ],
              ),
              Icon(icon, size: 48, color: AppColors.primary.withOpacity(0.2)),
            ],
          ),
        ),
      ),
    );
  }
}
