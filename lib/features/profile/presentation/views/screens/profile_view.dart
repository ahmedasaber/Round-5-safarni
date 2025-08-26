import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/profile/domain/entities/profile_user_entity.dart';
import 'package:safarni/features/profile/domain/repositories/profile_repository.dart';
import 'package:safarni/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:safarni/features/profile/presentation/views/screens/account_security_screen.dart';
import 'package:safarni/features/profile/presentation/views/screens/my_booking_screen.dart';
import 'package:safarni/features/profile/presentation/views/screens/personal_information_view.dart';
import 'package:safarni/features/profile/presentation/views/widgets/build_menu_item.dart';
import 'package:safarni/features/profile/presentation/views/widgets/profile_photo_widget.dart';
import 'dart:async';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(repository: GetIt.instance<ProfileRepository>())
            ..getUserProfile(),
      child: const ProfileScreenView(),
    );
  }
}

class ProfileScreenView extends StatefulWidget {
  const ProfileScreenView({super.key});

  @override
  State<ProfileScreenView> createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
  ProfileUserEntity? currentUser;
  bool _isNavigating = false;
  Timer? _navigationTimer;

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  void _safeNavigate(
    BuildContext context,
    String routeName, {
    bool removeAll = false,
  }) {
    if (_isNavigating || !mounted) return;

    setState(() => _isNavigating = true);

    _navigationTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        try {
          if (removeAll) {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamedAndRemoveUntil(routeName, (route) => false);
          } else {
            Navigator.of(context).pushNamed(routeName);
          }
        } catch (e) {
          debugPrint('Navigation error: $e');
        } finally {
          if (mounted) {
            setState(() => _isNavigating = false);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !_isNavigating,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (_isNavigating) return;

              if (state is ProfileError) {
                _showMessage(context, state.message, Colors.red);
              } else if (state is ProfileLoaded) {
                setState(() => currentUser = state.user);
              } else if (state is ProfileUpdateSuccess) {
                _showMessage(context, state.message, Colors.green);
                context.read<ProfileCubit>().getUserProfile();
              } else if (state is ProfileLogoutSuccess) {
                _handleLogoutSuccess(context, state.message);
              } else if (state is ProfileAccountDeleted) {
                _handleAccountDeleted(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is ProfileLoading && currentUser == null) {
                return const Center(child: CircularProgressIndicator());
              }

              if (currentUser != null) {
                return _buildProfileContent(context, currentUser!);
              }

              if (state is ProfileError) {
                return _buildErrorContent(context, state.message);
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message, Color color) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleLogoutSuccess(BuildContext context, String message) {
    if (_isNavigating || !mounted) return;

    _showMessage(context, message, Colors.green);

    Timer(const Duration(seconds: 1), () {
      _safeNavigate(context, '/splash-screen', removeAll: true);
    });
  }

  void _handleAccountDeleted(BuildContext context, String message) {
    if (_isNavigating || !mounted) return;

    _showMessage(context, message, Colors.orange);

    Timer(const Duration(seconds: 1), () {
      _safeNavigate(context, '/splash-screen', removeAll: true);
    });
  }

  Widget _buildProfileContent(BuildContext context, ProfileUserEntity user) {
    return SingleChildScrollView(
      // Added to prevent overflow
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            verticalSpace(40),
            GestureDetector(
              onTap: () => _showImagePickerDialog(context),
              child: ProfilePhotoWidget(
                imageUrl: user.image,
                userName: user.name,
              ),
            ),
            verticalSpace(16),
            Text(user.name, style: TextStyles.font16GrayLighterSemiBold),
            verticalSpace(8),
            Text(
              user.email,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff6B6E80),
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(32),
            // Changed from Expanded to Column to prevent overflow
            Column(
              children: [
                BuildMenuItem(
                  image: Assets.assetsImagesUser,
                  title: 'Personal info',
                  onTap: () async {
                    if (_isNavigating) return;

                    final result = await Navigator.pushNamed(
                      context,
                      PersonalInformationScreen.routeName,
                      arguments: user,
                    );

                    if (result == true && mounted) {
                      context.read<ProfileCubit>().getUserProfile();
                    }
                  },
                  showArrow: true,
                ),
                BuildMenuItem(
                  image: Assets.assetsImagesSecurity,
                  title: 'Account & Security',
                  onTap: () async {
                    if (_isNavigating) return;

                    final result = await Navigator.pushNamed(
                      context,
                      AccountSecurityScreen.routeName,
                    );

                    if (result == 'account_deleted' && mounted) {
                      _safeNavigate(context, '/splash-screen', removeAll: true);
                    }
                  },
                  showArrow: true,
                ),
                BuildMenuItem(
                  image: Assets.assetsImagesBooking,
                  title: 'My Booking',
                  onTap: () {
                    if (_isNavigating) return;
                    Navigator.pushNamed(context, MyBookingScreen.routeName);
                  },
                  showArrow: true,
                ),
                BuildMenuItem(
                  image: Assets.assetsImagesLanguage,
                  title: 'App Language',
                  onTap: () {
                    if (_isNavigating) return;
                    // Navigate to language settings
                  },
                  showArrow: true,
                ),
                BuildMenuItem(
                  image: Assets.assetsImagesLogout,
                  title: 'Logout',
                  textColor: Colors.red,
                  showArrow: false,
                  onTap: () {
                    if (_isNavigating) return;
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorContent(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          verticalSpace(16),
          Text(
            'Error loading profile',
            style: TextStyles.font18DarkBlackNormal,
          ),
          verticalSpace(8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          verticalSpace(24),
          ElevatedButton(
            onPressed: () => context.read<ProfileCubit>().getUserProfile(),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void _showImagePickerDialog(BuildContext context) {
    if (!mounted || _isNavigating) return;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Update Profile Picture',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImageOption(
                    context,
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImageFromCamera(context);
                    },
                  ),
                  _buildImageOption(
                    context,
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImageFromGallery(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30, color: Theme.of(context).primaryColor),
          ),
          verticalSpace(8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _pickImageFromCamera(BuildContext context) {
    final picker = ImagePicker();
    picker.pickImage(source: ImageSource.camera).then((pickedFile) {});
  }

  void _pickImageFromGallery(BuildContext context) {
    final picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((pickedFile) {});
  }

  void _showLogoutDialog(BuildContext context) {
    if (!mounted || _isNavigating) return;

    // Get the ProfileCubit from the main context
    final profileCubit = context.read<ProfileCubit>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return WillPopScope(
          onWillPop: () async => !_isNavigating,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.logout, color: Colors.orange, size: 48),
                  verticalSpace(16),
                  Text('Logout', style: TextStyles.font18DarkBlackNormal),
                  verticalSpace(12),
                  const Text(
                    'Are you sure you want to log out? You will be logged out of all devices.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                  verticalSpace(24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: _isNavigating
                              ? null
                              : () => Navigator.of(dialogContext).pop(),
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
                          bloc: profileCubit, // Use the specific cubit instance
                          listener: (context, state) {
                            if ((state is ProfileLogoutSuccess ||
                                    state is ProfileError) &&
                                Navigator.of(dialogContext).canPop()) {
                              Navigator.of(dialogContext).pop();
                            }
                          },
                          builder: (context, state) {
                            return TextButton(
                              onPressed:
                                  (state is ProfileLoading || _isNavigating)
                                  ? null
                                  : () => profileCubit.logout(),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: state is ProfileLoading
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Logout',
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
