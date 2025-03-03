import 'package:flutter/material.dart';
import 'package:tet_store/minor_screens/search.dart';

class FakeSearch extends StatelessWidget {
  const FakeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.yellow, width: 1.4),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.search, color: Colors.grey.shade600),
                ),
                Text(
                  'What are you looking for',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                ),
              ],
            ),
            Container(
              height: 32,
              width: 75,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
