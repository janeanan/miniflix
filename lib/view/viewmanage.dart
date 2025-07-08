import 'package:flutter/material.dart';

class ViewManage extends StatefulWidget {
  const ViewManage({super.key});

  @override
  State<ViewManage> createState() => _ViewManageState();
}

class _ViewManageState extends State<ViewManage> {
  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('Title')),
              popular(mediaHeight, mediaWidth),
              topRate(mediaHeight, mediaWidth),
              upComing(),
            ],
          ),
        ),
      ),
    );
  }

  popular(double mediaHeight, double mediaWidth) {
    var popularHeight = mediaHeight * 0.3;
    var popularWidth = popularHeight * 4 / 3;
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Popular'),
          SizedBox(
            height: popularHeight,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(color: Colors.black, width: popularWidth),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  topRate(double mediaHeight, double mediaWidth) {
    var popularHeight = mediaHeight * 0.2;
    var popularWidth = popularHeight * 3 / 4;
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top Rate'),
          SizedBox(
            height: popularHeight,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(color: Colors.black, width: popularWidth),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  upComing() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming'),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 4 / 3,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.black,
                child: Center(
                  child: Text(
                    'Item $index',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
