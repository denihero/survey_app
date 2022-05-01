import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUserCard extends StatelessWidget {
  const ShimmerUserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.only(bottom: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[300]!,
          child: ListTile(
            leading: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(12))
              ),
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 10,
                color: Colors.grey,
              ),
            ),
            subtitle: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 10,
                color: Colors.grey,
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
