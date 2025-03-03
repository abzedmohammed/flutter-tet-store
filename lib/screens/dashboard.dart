import 'package:flutter/material.dart';
import 'package:tet_store/dashboard_components/edit_business.dart';
import 'package:tet_store/dashboard_components/manage_products.dart';
import 'package:tet_store/dashboard_components/my_store.dart';
import 'package:tet_store/dashboard_components/orders.dart';
import 'package:tet_store/dashboard_components/supplier_balance.dart';
import 'package:tet_store/dashboard_components/supplier_statics.dart';
import 'package:tet_store/widgets/app_bar_widgets.dart';

List<String> labels = [
  'My store',
  'Orders',
  'Edit profile',
  'Manage products',
  'Balance',
  'Statistics',
];

List <Widget> widgets = [
  MyStore(),
  SupplierOrders(),
  EditBusiness(),
  ManageProducts(),
  SupplierBalance(),
  SupplierStatics(),
];

List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: 'Dashboard'),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/welcome_screen');
            },
            icon: Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
          mainAxisSpacing: 50,
          crossAxisSpacing: 50,
          crossAxisCount: 2,
          children: List.generate(
            6,
            (index) => InkWell(
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (ctx) => widgets[index]));
              },
              child: Card(
                elevation: 20,
                shadowColor: Colors.purpleAccent.shade200,
                color: Colors.blueGrey.withAlpha(100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(icons[index], size: 50, color: Colors.yellowAccent),
                    Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Acme',
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
