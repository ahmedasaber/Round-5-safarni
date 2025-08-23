import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_cubit.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_state.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/build_room_card.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/search_bar_widget.dart';

class AvailableRoomsScreenBody extends StatefulWidget {
  final int? hotelId; // استقبال hotelId من الخارج

  const AvailableRoomsScreenBody({super.key, this.hotelId});

  @override
  State<AvailableRoomsScreenBody> createState() =>
      _AvailableRoomsScreenBodyState();
}

class _AvailableRoomsScreenBodyState extends State<AvailableRoomsScreenBody> {
  int? get hotelId => widget.hotelId; // استخدام hotelId من widget

  @override
  void initState() {
    super.initState();
    print(
      '🏨 AvailableRoomsScreenBody initialized with hotel ID: $hotelId',
    ); // Debug print
    // لا نحتاج addPostFrameCallback لأن hotelId متاح فوراً
    // الـ BlocProvider في الـ parent بيستدعي fetchAvailableRooms أصلاً
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          hotelId != null ? 'Hotel Rooms' : 'Available Rooms',
          style: TextStyles.font17LightBlackNormal,
        ),
        centerTitle: true,
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
      body: BlocBuilder<HotelCubit, HotelState>(
        builder: (context, state) {
          print('🔄 Current state: ${state.runtimeType}'); // Debug print

          if (state is HotelLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HotelError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  verticalSpace(16),
                  Text(
                    'Error: ${state.message}',
                    style: TextStyles.font16LightBlackNormal,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HotelCubit>().fetchAvailableRooms(
                        hotelId: hotelId,
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is HotelSuccess) {
            print(
              '✅ HotelSuccess state - Available rooms count: ${state.availableRooms.length}',
            ); // Debug print

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hotelId == null) ...[
                    const SearchBarWidget(),
                    verticalSpace(16),
                  ],

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hotelId != null
                            ? 'Available Rooms'
                            : 'All Available Rooms',
                        style: TextStyles.font17LightBlackNormal,
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<HotelCubit>().fetchAvailableRooms(
                            hotelId: hotelId,
                          );
                        },
                        child: Text(
                          'Refresh',
                          style: TextStyles.font15DarkBlueNormal,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(16),

                  // التحقق الصحيح من الغرف المتاحة
                  if (state.availableRooms.isEmpty) ...[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.hotel_outlined,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            verticalSpace(16),
                            Text(
                              hotelId != null
                                  ? 'No rooms available in this hotel today'
                                  : 'No rooms available for today',
                              style: TextStyles.font16LightBlackNormal,
                              textAlign: TextAlign.center,
                            ),
                            verticalSpace(8),
                            Text(
                              hotelId != null
                                  ? 'This hotel has no available rooms for today. Please check back later or try a different date.'
                                  : 'No rooms are currently available. Try selecting a different date.',
                              style: TextStyles.font14DarkGrayNormal,
                              textAlign: TextAlign.center,
                            ),
                            if (hotelId != null) ...[
                              verticalSpace(16),
                              ElevatedButton(
                                onPressed: () {
                                  // العودة للصفحة الرئيسية للفنادق
                                  Navigator.pop(context);
                                },
                                child: const Text('Try Another Hotel'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    // عرض الغرف المتاحة
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${state.availableRooms.length} rooms found',
                          style: TextStyles.font14DarkGrayNormal,
                        ),
                        verticalSpace(12),
                        GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.75,
                              ),
                          itemCount: state.availableRooms.length,
                          itemBuilder: (context, index) {
                            final room = state.availableRooms[index];
                            return BuildRoomCard(
                              roomId: room.id,
                              roomName: room.name,
                              price: '\$${room.price.toStringAsFixed(0)}',
                              imageUrl: room.image,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          }

          // الحالة الافتراضية
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Something went wrong',
                  style: TextStyles.font16LightBlackNormal,
                ),
                verticalSpace(16),
                ElevatedButton(
                  onPressed: () {
                    context.read<HotelCubit>().fetchAvailableRooms(
                      hotelId: hotelId,
                    );
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
