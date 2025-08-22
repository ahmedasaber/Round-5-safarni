import 'package:flutter/material.dart';
import 'package:safarni/features/home/domain/entities/category_entity.dart';
import 'package:safarni/features/home/presentation/views/widgets/cusrom_category_item.dart';

class ListOfCategories extends StatelessWidget {
  const ListOfCategories({
    super.key, required this.categories,
  });

  final List<CategoryEntity> categories;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 97,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, i){
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CustomCategoryItem(
              categoryImage: categories[i].image,
              categoryTitle: categories[i].title.split(' ').first,
            ),
          );
        }
      ),
    );
  }
}