import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:safarni/core/utils/app_assets.dart';

class ProfilePhotoWidget extends StatelessWidget {
  final String? imageUrl;
  final String? userName;
  final double size;
  final VoidCallback? onTap;

  const ProfilePhotoWidget({
    super.key,
    this.imageUrl,
    this.userName,
    this.size = 120,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF2E4BC6),
                width: 3,
              ),
            ),
            child: ClipOval(
              child: _buildProfileImage(),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 4,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Image.asset(
                Assets.assetsImagesCameraProfile,
                width: 16,
                height: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    // If we have a network image URL
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      if (imageUrl!.startsWith('http')) {
        return CachedNetworkImage(
          imageUrl: imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[200],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => _buildFallbackAvatar(),
        );
      } else {
        // Local asset image
        return Image.asset(
          imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildFallbackAvatar(),
        );
      }
    }

    // Fallback to default avatar or user initials
    return _buildFallbackAvatar();
  }

  Widget _buildFallbackAvatar() {
    // If we have a username, show initials
    if (userName != null && userName!.isNotEmpty) {
      return Container(
        width: size,
        height: size,
        color: const Color(0xFF2E4BC6).withOpacity(0.1),
        child: Center(
          child: Text(
            _getInitials(userName!),
            style: TextStyle(
              fontSize: size * 0.4,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2E4BC6),
            ),
          ),
        ),
      );
    }

    // Default avatar image
    return Image.asset(
      Assets.assetsImagesAvatar,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[200],
          child: Icon(
            Icons.person,
            size: size * 0.5,
            color: Colors.grey[400],
          ),
        );
      },
    );
  }

  String _getInitials(String name) {
    List<String> nameParts = name.trim().split(' ');
    if (nameParts.length == 1) {
      return nameParts[0].substring(0, 1).toUpperCase();
    } else if (nameParts.length >= 2) {
      return (nameParts[0].substring(0, 1) + nameParts[1].substring(0, 1))
          .toUpperCase();
    }
    return 'U'; // Default fallback
  }
}