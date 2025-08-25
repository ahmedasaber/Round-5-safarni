import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'dart:io';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/features/hotel_about/presentation/view/widgets/hotel_content_section.dart';
import 'package:safarni/features/hotel_about/presentation/view/widgets/hotel_image_cursor.dart';
import 'package:safarni/features/hotel_about/presentation/cubit/room_detail_cubit.dart';

class HotelAboutPage extends StatefulWidget {
  static const routeName = '/hotel-about-screen';

  final int? roomId;
  final String roomName;
  final String price;
  final String imageUrl;
  final String address;
  final double rating;
  final int reviewsCount;

  const HotelAboutPage({
    super.key,
    this.roomId,
    required this.roomName,
    required this.price,
    required this.imageUrl,
    this.address = '1012 Ocean Avenue, New York ,USA',
    this.rating = 4.5,
    this.reviewsCount = 356,
  });

  @override
  State<HotelAboutPage> createState() => _HotelAboutPageState();
}

class _HotelAboutPageState extends State<HotelAboutPage> {
  int _selectedTabIndex = 0;
  final ImagePicker _picker = ImagePicker();
  final List<File> _selectedImages = [];

  Future<void> _pickImage() async {
    try {
      final ImageSource? source = await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Image Source'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Camera'),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Image Library'),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ),
          );
        },
      );

      if (source != null) {
        final XFile? image = await _picker.pickImage(
          source: source,
          maxWidth: 1920,
          maxHeight: 1080,
          imageQuality: 85,
        );

        if (image != null) {
          setState(() {
            _selectedImages.add(File(image.path));
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('The image has been added successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image please try again'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('The image has been removed successfully'),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> galleryImages = [
      Assets.assetsImagesHotel1,
      Assets.assetsImagesHotel2,
      Assets.assetsImagesHotel3,
      Assets.assetsImagesHotel1,
      Assets.assetsImagesHotel2,
      Assets.assetsImagesHotel3,
    ];

    return BlocProvider(
      create: (context) =>
          RoomDetailCubit(getIt())..getRoomDetails(widget.roomId ?? 1),
      child: Scaffold(
        body: BlocBuilder<RoomDetailCubit, RoomDetailState>(
          builder: (context, state) {
            if (state is RoomDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is RoomDetailError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 64, color: Colors.red),
                    SizedBox(height: 16),
                    Text('Error: ${state.message}'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<RoomDetailCubit>().getRoomDetails(
                          widget.roomId ?? 1,
                        );
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is RoomDetailSuccess) {
              final roomDetail = state.roomDetail;
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: HotelImageCarousel(
                      images: roomDetail.image.isNotEmpty
                          ? [roomDetail.image] + galleryImages
                          : galleryImages,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: HotelContentSection(
                      roomName: "Room_${roomDetail.id}",
                      address: widget.address,
                      rating: roomDetail.averageRating,
                      reviewsCount: roomDetail.totalReviews,
                      price: roomDetail.price,
                      selectedTabIndex: _selectedTabIndex,
                      onTabChanged: (index) {
                        setState(() {
                          _selectedTabIndex = index;
                        });
                      },
                      selectedImages: _selectedImages,
                      onPickImage: _pickImage,
                      onRemoveImage: _removeImage,
                      roomDetail: roomDetail, // Pass room details
                    ),
                  ),
                ],
              );
            }
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: HotelImageCarousel(images: galleryImages),
                ),
                Expanded(
                  flex: 3,
                  child: HotelContentSection(
                    roomName: widget.roomName,
                    address: widget.address,
                    rating: widget.rating,
                    reviewsCount: widget.reviewsCount,
                    price: widget.price,
                    selectedTabIndex: _selectedTabIndex,
                    onTabChanged: (index) {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                    selectedImages: _selectedImages,
                    onPickImage: _pickImage,
                    onRemoveImage: _removeImage,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
