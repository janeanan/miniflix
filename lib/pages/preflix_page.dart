import 'package:flutter/material.dart';
import 'package:miniflix/domain/tmdb_view_model.dart';
import 'package:miniflix/extension/space_extension.dart';
import 'package:provider/provider.dart';

class MiniFlix extends StatefulWidget {
  const MiniFlix({super.key});

  @override
  State<MiniFlix> createState() => _MiniFlixState();
}

class _MiniFlixState extends State<MiniFlix> {
  late TmdbViewModel tmdbViewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tmdbViewModel = Provider.of<TmdbViewModel>(context, listen: false);
    tmdbViewModel.getListPoplar();
  }

  @override
  Widget build(BuildContext context) {
    double sizedH = MediaQuery.of(context).size.height;
    double sizedW = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('MINIFLIX'),
              20.sBoxHeight,
              Text('Popular'),
              20.sBoxHeight,
              SizedBox(
                height: sizedH * 0.3,
                width: sizedW,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: sizedW,
                        width: sizedW * 0.5,
                        color: Colors.amber,
                      ),
                    );
                  },
                ),
              ),
              20.sBoxHeight,
              Text('Top Rated'),
              20.sBoxHeight,
              SizedBox(
                height: sizedH * 0.2,
                width: sizedW,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          height: sizedW,
                          width: sizedW * 0.3,
                          color: Colors.amber,
                        ),
                      );
                    },
                  ),
                ),
              ),
              20.sBoxHeight,
              Text('Upcoming'),
              20.sBoxHeight,
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    height: sizedH * 1,
                    width: sizedW * 1,
                    color: Colors.amber,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  popularMovie(double sizedH, double sizedW) {
    return SizedBox(
      height: sizedH * 0.3,
      width: sizedW,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: sizedW,
              width: sizedW * 0.5,
              color: Colors.amber,
            ),
          );
        },
      ),
    );
  }

  gridViewUpComing(double sizedH, double sizedW) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return Container(
          height: sizedH * 1,
          width: sizedW * 1,
          color: Colors.amber,
        );
      },
    );
  }
}
