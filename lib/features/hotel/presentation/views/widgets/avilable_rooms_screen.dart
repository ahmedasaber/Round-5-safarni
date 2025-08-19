import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/build_room_card.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/search_bar_widget.dart';

class AvailableRoomsScreen extends StatelessWidget {
  static const routeName = '/available-rooms-screen';
  const AvailableRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(),
            verticalSpace(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Rooms',
                  style: TextStyles.font17LightBlackNormal,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View all',
                    style: TextStyles.font15DarkBlueNormal,
                  ),
                ),
              ],
            ),
            // verticalSpace(16),
            // Rooms Grid
            GridView.count(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
              children: [
                BuildRoomCard(
                  roomName: 'Room_1',
                  price: '200\$',
                  imageUrl: Assets.assetsImagesRoom1,
                ),
                BuildRoomCard(
                  roomName: 'Room_1',
                  price: '200\$',
                  imageUrl: Assets.assetsImagesRoom2,
                ),
                BuildRoomCard(
                  roomName: 'Room_1',
                  price: '200\$',
                  imageUrl: Assets.assetsImagesRoom3,
                ),
                BuildRoomCard(
                  roomName: 'Room_1',
                  price: '200\$',
                  imageUrl: Assets.assetsImagesRoom4,
                ),
                BuildRoomCard(
                  roomName: 'Room_1',
                  price: '200\$',
                  imageUrl: Assets.assetsImagesRoom1,
                ),
                BuildRoomCard(
                  roomName: 'Room_1',
                  price: '200\$',
                  imageUrl: Assets.assetsImagesRoom5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
