import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/profile/domain/repositories/profile_repository.dart';
import 'package:safarni/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:safarni/features/profile/presentation/views/widgets/build_navigation_item.dart';
import 'package:safarni/features/profile/presentation/views/widgets/build_toggle_item.dart';
import 'dart:async';

class AccountSecurityScreen extends StatefulWidget {
  static const String routeName = '/account-security-screen';
  const AccountSecurityScreen({super.key});

  @override
  State<AccountSecurityScreen> createState() => _AccountSecurityScreenState();
}

class _AccountSecurityScreenState extends State<AccountSecurityScreen> {
  bool biometricEnabled = false;
  bool faceIdEnabled = false;
  late ProfileCubit _profileCubit;
  bool _isProcessingDelete = false;
  Timer? _operationTimer;

  @override
  void initState() {
    super.initState();
    _profileCubit = ProfileCubit(
      repository: GetIt.instance<ProfileRepository>(),
    );
  }

  @override
  void dispose() {
    _operationTimer?.cancel();
    if (!_profileCubit.isClosed) {
      _profileCubit.close();
    }
    super.dispose();
  }

  void _safePopWithResult(String result) {
    if (!mounted || _isProcessingDelete) return;

    setState(() => _isProcessingDelete = true);

    _operationTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        try {
          Navigator.of(context).pop(result);
        } catch (e) {
          debugPrint('Navigation error: $e');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !_isProcessingDelete,
      child: BlocProvider.value(
        value: _profileCubit,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: _isProcessingDelete
                  ? null
                  : () => Navigator.pop(context),
            ),
            title: Text(
              'Account & Security',
              style: TextStyles.font18DarkBlackNormal,
            ),
            centerTitle: true,
          ),
          body: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileAccountDeleted) {
                if (mounted && !_isProcessingDelete) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.orange,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                  _safePopWithResult('account_deleted');
                }
              } else if (state is ProfileError) {
                if (mounted) {
                  setState(() => _isProcessingDelete = false);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                // Added to prevent overflow
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      verticalSpace(20),
                      BuildToggleItem(
                        title: 'Biometric ID',
                        value: biometricEnabled,
                        onChanged: _isProcessingDelete
                            ? null
                            : (value) {
                                setState(() => biometricEnabled = value);
                              },
                      ),
                      verticalSpace(20),
                      BuildToggleItem(
                        title: 'Face ID',
                        value: faceIdEnabled,
                        onChanged: _isProcessingDelete
                            ? null
                            : (value) {
                                setState(() => faceIdEnabled = value);
                              },
                      ),
                      verticalSpace(40),
                      BuildNavigationItem(
                        title: 'Device Management',
                        subtitle:
                            'Manage your account on the various devices you own.',
                        onTap: _isProcessingDelete
                            ? () {}
                            : () {
                                // Navigate to Device Management
                              },
                      ),
                      verticalSpace(20),
                      BuildNavigationItem(
                        title: 'Deactivate Account',
                        subtitle:
                            'Temporarily deactivate your account. Easily reactivate when you\'re ready.',
                        onTap: _isProcessingDelete
                            ? () {}
                            : () {
                               
                              },
                      ),
                      verticalSpace(20),
                      BuildNavigationItem(
                        title: 'Delete Account',
                        subtitle:
                            'Permanently remove your account and data from Tripmate. Proceed with caution.',
                        titleColor: Colors.red,
                        onTap: _isProcessingDelete
                            ? () {}
                            : _showDeleteAccountDialog,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    if (!mounted || _isProcessingDelete) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return WillPopScope(
          onWillPop: () async => !_isProcessingDelete,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                    size: 48,
                  ),
                  verticalSpace(16),
                  const Text(
                    'Delete Account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  verticalSpace(16),
                  const Text(
                    'Are you sure you want to permanently delete your account? This action cannot be undone.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  verticalSpace(24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: _isProcessingDelete
                              ? null
                              : () {
                                  if (Navigator.of(dialogContext).canPop()) {
                                    Navigator.of(dialogContext).pop();
                                  }
                                },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: BlocConsumer<ProfileCubit, ProfileState>(
                          bloc:
                              _profileCubit, 
                          listener: (context, state) {
                            if ((state is ProfileError ||
                                    state is ProfileAccountDeleted) &&
                                Navigator.of(dialogContext).canPop()) {
                              Navigator.of(dialogContext).pop();
                            }
                          },
                          builder: (context, state) {
                            final isLoading = state is ProfileLoading;
                            return TextButton(
                              onPressed: (isLoading || _isProcessingDelete)
                                  ? null
                                  : () {
                                      _showFinalConfirmationDialog(
                                        dialogContext,
                                      );
                                    },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Delete Account',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showFinalConfirmationDialog(BuildContext parentDialogContext) {
    if (!mounted || _isProcessingDelete) return;

    Navigator.of(parentDialogContext).pop();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext finalDialogContext) {
        return WillPopScope(
          onWillPop: () async => !_isProcessingDelete,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.delete_forever, color: Colors.red, size: 48),
                  verticalSpace(16),
                  const Text(
                    'Delete Account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  verticalSpace(16),
                  const Text(
                    'Are you sure you want to permanently delete your account?\n\nThis action cannot be undone.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  verticalSpace(24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: _isProcessingDelete
                              ? null
                              : () {
                                  if (Navigator.of(
                                    finalDialogContext,
                                  ).canPop()) {
                                    Navigator.of(finalDialogContext).pop();
                                  }
                                },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: BlocConsumer<ProfileCubit, ProfileState>(
                          bloc:
                              _profileCubit,
                          listener: (context, state) {
                            if ((state is ProfileAccountDeleted ||
                                    state is ProfileError) &&
                                Navigator.of(finalDialogContext).canPop()) {
                              Navigator.of(finalDialogContext).pop();
                            }
                          },
                          builder: (context, state) {
                            final isLoading = state is ProfileLoading;
                            return TextButton(
                              onPressed: (isLoading || _isProcessingDelete)
                                  ? null
                                  : () {
                                      if (!_profileCubit.isClosed) {
                                        _profileCubit.deleteAccount();
                                      }
                                    },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                backgroundColor: Colors.red[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Delete Account',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
