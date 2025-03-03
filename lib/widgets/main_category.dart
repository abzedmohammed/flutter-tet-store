import 'package:flutter/material.dart';
import 'package:tet_store/minor_screens/sub_cat_products.dart';
import 'package:tet_store/utilities/utils.dart';

class SliderBar extends StatelessWidget {
  const SliderBar({super.key, required this.mainCategoryname});

  final String mainCategoryname;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .8,
      width: MediaQuery.of(context).size.width * .05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown.withAlpha(60),
            borderRadius: BorderRadius.circular(50),
          ),
          child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  mainCategoryname == 'bags' ? '' : "<<",
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 10,
                  ),
                ),
                Text(
                  mainCategoryname.toUpperCase(),
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 10,
                  ),
                ),
                Text(
                  mainCategoryname == 'men' ? '' : ">>",
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubCategoryModel extends StatelessWidget {
  const SubCategoryModel({
    super.key,
    required this.mainCategoryname,
    required this.subCategoryname,
    required this.assetName,
    required this.subCategorylabel,
  });

  final String mainCategoryname;
  final String subCategoryname;
  final String assetName;
  final String subCategorylabel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (ctx) => SubCategoryProducts(
                  mainCategoryname: mainCategoryname,
                  subCategoryname: capitalizeFirstLetter(subCategoryname),
                ),
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(
            child: Image(
              fit: BoxFit.contain,
              width: double.infinity,
              height: 50,
              image: AssetImage(assetName),
            ),
          ),
          Text(
            capitalizeFirstLetter(subCategorylabel),
            style: TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class CategoryHeaderLabel extends StatelessWidget {
  const CategoryHeaderLabel({super.key, required this.headerLabel});

  final String headerLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Text(
        capitalizeFirstLetter(headerLabel),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
