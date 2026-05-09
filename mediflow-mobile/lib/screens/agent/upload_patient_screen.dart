import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants.dart';
import '../../services/patient_service.dart';
import '../../widgets/section_label.dart';

class UploadPatientScreen extends ConsumerStatefulWidget {
  const UploadPatientScreen({super.key});

  @override
  ConsumerState<UploadPatientScreen> createState() => _UploadPatientScreenState();
}

class _UploadPatientScreenState extends ConsumerState<UploadPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  final _complaintController = TextEditingController();
  String _gender = 'Male';
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _complaintController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final success = await ref.read(patientServiceProvider).uploadPatient({
      'fullName': _fullNameController.text,
      'phone': _phoneController.text,
      'dateOfBirth': _dobController.text,
      'gender': _gender,
      'chiefComplaint': _complaintController.text,
    });

    setState(() => _isLoading = false);

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Patient uploaded successfully!')),
        );
        context.pop();
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload failed. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Patient')),
      body: Form(
        key: _formKey,
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() => _currentStep += 1);
            } else {
              _submit();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep -= 1);
            }
          },
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : details.onStepContinue,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(_currentStep == 2 ? 'Finish Upload' : 'Next Step'),
                    ),
                  ),
                  if (_currentStep > 0) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: details.onStepCancel,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Back'),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
          steps: [
            Step(
              title: const Text('Basic'),
              isActive: _currentStep >= 0,
              content: Column(
                children: [
                  const SectionLabel(label: 'Step 1 of 3'),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      hintText: 'Full Name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('Details'),
              isActive: _currentStep >= 1,
              content: Column(
                children: [
                  const SectionLabel(label: 'Step 2 of 3'),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _gender,
                    decoration: const InputDecoration(hintText: 'Gender'),
                    items: ['Male', 'Female', 'Other']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => _gender = v!),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _dobController,
                    decoration: const InputDecoration(
                      hintText: 'Date of Birth (YYYY-MM-DD)',
                      prefixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('Clinical'),
              isActive: _currentStep >= 2,
              content: Column(
                children: [
                  const SectionLabel(label: 'Step 3 of 3'),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _complaintController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Chief Complaint / Initial Notes',
                      alignLabelWithHint: true,
                    ),
                    validator: (v) => v!.isEmpty ? 'Please enter initial notes' : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
