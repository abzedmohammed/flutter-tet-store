import 'package:flutter/material.dart';
import 'package:tet_store/widgets/app_bar_widgets.dart';

class EditBusiness extends StatelessWidget {
  const EditBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: AppBarBackButton(),
        title: AppBarTitle(title: 'Edit Business'),
      ),
    );
  }
}
