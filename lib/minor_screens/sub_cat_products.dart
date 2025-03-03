import 'package:flutter/material.dart';
import 'package:tet_store/widgets/app_bar_widgets.dart';

class SubCategoryProducts extends StatelessWidget {
  const SubCategoryProducts({
    super.key,
    required this.mainCategoryname,
    required this.subCategoryname,
  });

  final String subCategoryname;
  final String mainCategoryname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AppBarTitle(title: subCategoryname),
        backgroundColor: Colors.white,
        leading: AppBarBackButton(),
      ),
      body: Center(child: Text(mainCategoryname)),
    );
  }
}
