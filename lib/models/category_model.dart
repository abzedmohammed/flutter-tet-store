import 'package:flutter/widgets.dart';
import 'package:tet_store/categories/accessories_cat.dart';
import 'package:tet_store/categories/beauty_cat.dart';
import 'package:tet_store/categories/electronics_cat.dart';
import 'package:tet_store/categories/home_garden_cat.dart';
import 'package:tet_store/categories/kids_cat.dart';
import 'package:tet_store/categories/men_cat.dart';
import 'package:tet_store/categories/shoes_cat.dart';
import 'package:tet_store/categories/women_cat.dart';
import 'package:tet_store/categories/bags_cat.dart';

final List<ItemsData> categoriesModel = [
  ItemsData(label: 'Men', widget: MenCategory()),
  ItemsData(label: 'Women', widget: WomenCategory()),
  ItemsData(label: 'Shoes', widget: ShoesCategory()),
  ItemsData(label: 'Electronics', widget: ElectronicsCategory()),
  ItemsData(label: 'Accessories', widget: AccessoriesCategory()),
  ItemsData(label: 'Home & Garden', widget: HomeGardenCategory()),
  ItemsData(label: 'Beauty', widget: BeautyCategory()),
  ItemsData(label: 'Kids', widget: KidsCategory()),
  ItemsData(label: 'Bags', widget:  BagsCategory()),
];

final List<String> subcategoriesModel = [
  'Shirts',
  'T-shirts',
  'Jeans',
  'Shoes',
  'Electronics',
  'Accessories',
  'Home & Garden',
  'Beauty',
  'Kids',
  'Bags',
];

class ItemsData {
  String label;
  bool isSelected;
  Widget widget;
  ItemsData({
    required this.label,
    this.isSelected = false,
    this.widget = const Text('The Widget'),
  });
}
