import 'package:flutter/material.dart';
import 'package:tet_store/utilities/categ_list.dart';
import 'package:tet_store/utilities/utils.dart';
import 'package:tet_store/widgets/main_category.dart';

class BeautyCategory extends StatelessWidget {
  const BeautyCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryHeaderLabel(headerLabel: 'beauty'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.68,
                    child: GridView.count(
                      mainAxisSpacing: 50,
                      crossAxisSpacing: 9,
                      crossAxisCount: 3,
                      children: List.generate(beauty.length, (index) {
                        return SubCategoryModel(
                          assetName: 'images/beauty/beauty$index.jpg',
                          mainCategoryname: 'beauty',
                          subCategoryname: capitalizeFirstLetter(beauty[index]),
                          subCategorylabel: beauty[index],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(bottom: 0, right: 0, child: SliderBar(mainCategoryname: 'beauty',)),
        ],
      ),
    );
  }
}

