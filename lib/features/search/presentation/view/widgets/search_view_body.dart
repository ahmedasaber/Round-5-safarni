import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/extentions.dart';
import 'package:safarni/core/widgets/custom_app_bar.dart';
import 'package:safarni/features/search/presentation/view/pages/result_view.dart';
import 'package:safarni/features/search/presentation/view/widgets/locatio_item.dart';
import 'package:safarni/features/home/presentation/views/widgets/custom_search_text_field.dart';



class SearchViewBody extends StatelessWidget {
   SearchViewBody({super.key});

  List<LocationItem> list  = [
    LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts',),
    LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts',),
    LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts',),
    LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts',),
    LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts',),
    LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts',),
    LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts',),
    LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts',),
    LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts',),
    LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts',),
    LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts',),
    LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts',),
    LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts',),
    LocationItem(image: 'assets/icons/paris.svg', location: 'Paris', knownBy: 'City of arts',),
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
              CustomSearchTextField(),
              SizedBox(height: 24,),
              ListView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,i){
                  return GestureDetector(
                    onTap: (){
                      context.pushNamed(ResultView.routeName);
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
