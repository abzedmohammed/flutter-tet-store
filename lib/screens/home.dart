import 'package:flutter/material.dart';
import 'package:tet_store/models/category_model.dart';
import 'package:tet_store/widgets/fake_search.dart';
import 'package:tet_store/widgets/repeated_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: FakeSearch(),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.yellow,
            indicatorWeight: 8,
            tabs: categoriesModel.map((label) => RepeatedTab(label: label.label)).toList(),
          ),
        ),
        body: TabBarView(
          children:
              categoriesModel
                  .map((label) => Center(child: Text('${label.label} Screen')))
                  .toList(),
        ),
      ),
    );
  }
}
