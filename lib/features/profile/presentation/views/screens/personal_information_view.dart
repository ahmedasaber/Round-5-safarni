import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/features/profile/domain/entities/profile_user_entity.dart';
import 'package:safarni/features/profile/domain/repositories/profile_repository.dart';
import 'package:safarni/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:safarni/features/profile/presentation/views/widgets/build_input_field.dart';

class PersonalInformationScreen extends StatefulWidget {
  static const routeName = '/personal-information-screen';

  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _countryController = TextEditingController();
  final _phoneController = TextEditingController();

  ProfileUserEntity? _currentUser;
  late ProfileCubit _profileCubit; // Store cubit reference

  @override
  void initState() {
    super.initState();
    // Initialize cubit once
    _profileCubit = ProfileCubit(repository: GetIt.instance<ProfileRepository>());
    
    // Get user data passed from previous screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is ProfileUserEntity) {
        _currentUser = args;
        _populateFields();
      }
    });
  }

  void _populateFields() {
    if (_currentUser != null) {
      _nameController.text = _currentUser!.name;
      _emailController.text = _currentUser!.email;
      _countryController.text = _currentUser!.country ?? '';
      _phoneController.text = _currentUser!.phone ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _phoneController.dispose();
    _profileCubit.close(); // Close cubit to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileCubit, // Use BlocProvider.value instead of create
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Personal Information',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileUpdateSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context, true); // Return true to indicate update
                } else if (state is ProfileError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return TextButton(
                  onPressed: state is ProfileLoading ? null : _saveProfile,
                  child: state is ProfileLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(20),
                BuildInputField(
                  label: 'Name',
                  icon: Assets.assetsImagesUserInput,
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    if (value.trim().length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),
                verticalSpace(24),
                BuildInputField(
                  label: 'Email',
                  icon: Assets.assetsImagesMessage,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                verticalSpace(24),
                BuildInputField(
                  label: 'Country',
                  icon: Assets.assetsImagesLocationInput,
                  controller: _countryController,
                  validator: (value) {
                    // Country is optional
                    return null;
                  },
                ),
                verticalSpace(24),
                BuildInputField(
                  label: 'Phone Number',
                  icon: Assets.assetsImagesPhone,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    // Phone is optional, but if provided should be valid
                    if (value != null && value.trim().isNotEmpty) {
                      final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
                      if (!phoneRegex.hasMatch(value.trim())) {
                        return 'Please enter a valid phone number';
                      }
                    }
                    return null;
                  },
                ),
                verticalSpace(40),
                // Additional information section
                if (_currentUser != null) ...[
                  const Divider(),
                  verticalSpace(20),
                  _buildInfoSection(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Account Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        verticalSpace(16),
        _buildInfoItem(
          'Account Created',
          _formatDate(_currentUser!.createdAt),
          Icons.calendar_today,
        ),
        if (_currentUser!.emailVerifiedAt != null)
          _buildInfoItem(
            'Email Verified',
            _formatDate(_currentUser!.emailVerifiedAt),
            Icons.verified_user,
            color: Colors.green,
          ),
        _buildInfoItem(
          'Last Updated',
          _formatDate(_currentUser!.updatedAt),
          Icons.update,
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon, {Color? color}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: color ?? Colors.grey[600],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'Invalid date';
    }
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      _profileCubit.updateUserProfile(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        country: _countryController.text.trim().isEmpty ? null : _countryController.text.trim(),
      );
    }
  }
}