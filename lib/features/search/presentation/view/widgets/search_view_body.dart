import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/extentions.dart';
import 'package:safarni/core/widgets/custom_app_bar.dart';
import 'package:safarni/features/search/presentation/view/pages/result_view.dart';
import 'package:safarni/features/search/presentation/view/widgets/locatio_item.dart';
import 'package:safarni/features/home/presentation/views/widgets/custom_search_text_field.dart';

class SearchViewBody extends StatelessWidget {
   SearchViewBody({super.key});

   List<LocationItem> list = [
     LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts'),
     LocationItem(image: 'assets/icons/rome.svg', location: 'Rome', knownBy: 'History Event base'),
     LocationItem(image: 'assets/icons/rio.svg', location: 'Rio De Janeiro', knownBy: 'Adventures here'),
     LocationItem(image: 'assets/icons/dubai.svg', location: 'Dubai', knownBy: 'Boom in the town'),
     LocationItem(image: 'assets/icons/london.svg', location: 'London', knownBy: 'City of culture'),
     LocationItem(image: 'assets/icons/sydney.svg', location: 'Sydney', knownBy: 'Waves over here'),
     LocationItem(image: 'assets/icons/beijing.svg', location: 'Beijing', knownBy: 'Unique tradition'),
     LocationItem(image: 'assets/icons/amsterdam.svg', location: 'Amsterdam', knownBy: 'City of Flowers'),
     LocationItem(image: 'assets/icons/berlin.svg', location: 'Berlin', knownBy: 'City of arts'),
     LocationItem(image: 'assets/icons/ankara.svg', location: 'Ankara', knownBy: 'City of arts'),
     LocationItem(image: 'assets/icons/pizza.svg', location: 'Pizza', knownBy: 'City of arts'),
     LocationItem(image: 'assets/icons/washington.svg', location: 'Washington', knownBy: 'Family trendy'),
     LocationItem(image: 'assets/icons/malaysia.svg', location: 'Malaysia', knownBy: 'City of arts'),
     LocationItem(image: 'assets/icons/barcelona.svg', location: 'Barcelona', knownBy: 'City of arts'),
     LocationItem(image: 'assets/icons/florence.svg', location: 'Florence', knownBy: 'City of arts'),
     LocationItem(image: 'assets/icons/delhi.svg', location: 'Delhi', knownBy: 'City of color'),
     LocationItem(image: 'assets/icons/china.svg', location: 'China', knownBy: 'City of arts'),
     LocationItem(image: 'assets/icons/istanbul.svg', location: 'Istanbul', knownBy: 'City of arts'),
     LocationItem(image: 'assets/icons/egypt.svg', location: 'Egypt', knownBy: 'City of arts'),
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Search'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24,),
              CustomSearchTextField(
                onSubmitted: (value){
                  context.pushNamed(ResultView.routeName, arguments: value);
                },
              ),
              SizedBox(height: 24,),
              ListView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,i){
                  return GestureDetector(
                    onTap: (){
                      context.pushNamed(ResultView.routeName, arguments: list[i].location);
                    }, child: list[i]
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
