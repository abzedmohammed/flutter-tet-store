import 'package:flutter/material.dart';
import 'package:tet_store/models/category_model.dart';
import 'package:tet_store/widgets/fake_search.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    for (var element in categoriesModel) {
      element.isSelected = false;
    }
    setState(() {
      categoriesModel[0].isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: FakeSearch(),
      ),
      body: Stack(
        children: [
          Positioned(bottom: 0, left: 0, child: sideNavigator(size)),
          Positioned(bottom: 0, right: 0, child: categoryView(size)),
        ],
      ),
    );
  }

  Widget sideNavigator(Size size) {
    return SizedBox(
      height: size.height * .8,
      width: size.width * .2,
      child: ListView.builder(
        itemCount: categoriesModel.length,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: Duration(microseconds: 100),
                curve: Curves.bounceInOut,
              );
            },
            child: Container(
              color:
                  categoriesModel[index].isSelected
                      ? Colors.white
                      : Colors.grey.shade300,
              height: 100,
              child: Center(child: Text(categoriesModel[index].label)),
            ),
          );
        },
      ),
    );
  }

  Widget categoryView(Size size) {
    return Container(
      height: size.height * .8,
      width: size.width * .8,
      color: Colors.white,
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: (value) {
          for (var element in categoriesModel) {
            element.isSelected = false;
          }
          setState(() {
            categoriesModel[value].isSelected = true;
          });
        },
        children:
            categoriesModel
                .map((widget) => widget.widget)
                .toList(),
      ),
    );
  }
}
