import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants.dart';
import '../../widgets/section_label.dart';

class RoleSelectorScreen extends StatelessWidget {
  const RoleSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join MediFlow'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionLabel(label: 'Account Type'),
            const SizedBox(height: 16),
            Text(
              'How will you use\nMediFlow today?',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 32),
            _RoleCard(
              title: 'Clinic Owner',
              description: 'Register a new clinic and manage your entire medical team.',
              icon: Icons.business_outlined,
              onTap: () => context.push('/register'),
            ),
            const SizedBox(height: 16),
            _RoleCard(
              title: 'Doctor',
              description: 'Join an existing clinic to manage patients and clinical notes.',
              icon: Icons.medical_services_outlined,
              onTap: () => _showTokenEntry(context, 'DOCTOR'),
            ),
            const SizedBox(height: 16),
            _RoleCard(
              title: 'Agent',
              description: 'Join as support staff to upload patients and fulfill tasks.',
              icon: Icons.support_agent_outlined,
              onTap: () => _showTokenEntry(context, 'AGENT'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTokenEntry(BuildContext context, String role) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionLabel(label: 'Verify Invitation ($role)'),
              const SizedBox(height: 16),
              Text(
                'Enter Invite Code',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Paste the code shared by your Head Doctor or Doctor via WhatsApp.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.mutedForeground),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'e.g. abc-123-xyz',
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  final token = controller.text.trim();
                  if (token.isNotEmpty) {
                    Navigator.pop(context);
                    context.push('/register?token=$token&role=$role');
                  }
                },
                child: const Text('Verify Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.description,
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
                child: Icon(icon, color: AppColors.primary, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.mutedForeground),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.border),
            ],
          ),
        ),
      ),
    );
  }
}
