import 'package:ecommerce_app/widgets/export.dart';
import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:flutter/material.dart';

class LatestShoesCard extends StatelessWidget {
  const LatestShoesCard({
    super.key,
    required this.sneakers,
  });

  final Future<List<Sneaker>> sneakers;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sneakers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else {
          final sneaker = snapshot.data!;
          return StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            crossAxisSpacing: 20.w,
            mainAxisSpacing: 16.h,
            itemCount: sneaker.length,
            scrollDirection: Axis.vertical,
            //useful to define the size on a specific index
            staggeredTileBuilder: (index) =>
                StaggeredTile.extent(1, (index % 2 != 0) ? 285.h : 252.h),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ProductDetailPage(sneaker: sneaker[index]);
                      },
                    ),
                  );
                },
                child: StaggerTile(
                  sneaker: sneaker[index],
                ),
              );
            },
          );
        }
      },
    );
  }
}
