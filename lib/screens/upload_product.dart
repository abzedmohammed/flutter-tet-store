import 'package:flutter/material.dart';
import 'package:tet_store/widgets/app_bar_widgets.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppBarTitle(title: 'Upload Product')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    color: Colors.blueGrey.shade100,
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Center(
                      child: Text(
                        "You have not \n \n picked any image yet",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
                child: Divider(color: Colors.yellow, thickness: 1.5),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: textFomDecoration.copyWith(
                      labelText: 'Price',
                      hintText: 'KES 0.00',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    decoration: textFomDecoration.copyWith(
                      labelText: 'Quantity',
                      hintText: 'Add quantity',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    maxLength: 100,
                    maxLines: 3,
                    decoration: textFomDecoration.copyWith(
                      labelText: 'Product Name',
                      hintText: 'Add Product Name',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    maxLength: 800,
                    maxLines: 5,
                    decoration: textFomDecoration.copyWith(
                      labelText: 'Product description',
                      hintText: 'Add Product description',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

var textFomDecoration = InputDecoration(
  labelText: 'Price',
  labelStyle: TextStyle(color: Colors.purple),
  hintText: 'KES 0.00',
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.yellow, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
    borderRadius: BorderRadius.circular(10),
  ),
);
