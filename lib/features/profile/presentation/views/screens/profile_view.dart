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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is ProfileLoaded) {
              setState(() {
                currentUser = state.user;
              });
            } else if (state is ProfileUpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              // إعادة تحميل البيانات بعد التحديث
              context.read<ProfileCubit>().getUserProfile();
            } else if (state is ProfileLogoutSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
            } else if (state is ProfileAccountDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.orange,
                ),
              );
              Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (route) => false);
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
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileUserEntity user) {
    return Padding(
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
          Text(
            user.name,
            style: TextStyles.font16GrayLighterSemiBold,
          ),
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
          Expanded(
            child: Column(
              children: [
                BuildMenuItem(
                  image: Assets.assetsImagesUser,
                  title: 'Personal info',
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      PersonalInformationScreen.routeName,
                      arguments: user,
                    );
                    // إذا تم التحديث، أعد تحميل البيانات
                    if (result == true) {
                      context.read<ProfileCubit>().getUserProfile();
                    }
                  },
                  showArrow: true,
                ),
                BuildMenuItem(
                  image: Assets.assetsImagesSecurity,
                  title: 'Account & Security',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AccountSecurityScreen.routeName,
                    );
                  },
                  showArrow: true,
                ),
                BuildMenuItem(
                  image: Assets.assetsImagesBooking,
                  title: 'My Booking',
                  onTap: () {
                    Navigator.pushNamed(context, MyBookingScreen.routeName);
                  },
                  showArrow: true,
                ),
                BuildMenuItem(
                  image: Assets.assetsImagesLanguage,
                  title: 'App Language',
                  onTap: () {
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
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
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
            onPressed: () {
              context.read<ProfileCubit>().getUserProfile();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void _showImagePickerDialog(BuildContext context) {
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: double.infinity,
            height: 170,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Do You Want To Register The Exit Already ?',
                  textAlign: TextAlign.center,
                  style: TextStyles.font18DarkBlackNormal,
                ),
                verticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: Text(
                        'NO',
                        style: TextStyles.font18DarkBlackNormal,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // إضافة منطق الخروج هنا
                        // context.read<ProfileCubit>().logout();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}