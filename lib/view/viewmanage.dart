import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:miniflix/model/apis/ui_configuration.dart';
import 'package:miniflix/utils/enum.dart';
import 'package:miniflix/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

class ViewManage extends StatefulWidget {
  const ViewManage({super.key});

  @override
  State<ViewManage> createState() => _ViewManageState();
}

class _ViewManageState extends State<ViewManage> {
  late MovieViewModel movieViewModel;

  setDatas() {
    movieViewModel = Provider.of<MovieViewModel>(context, listen: false);
    movieViewModel.getTrendingList();
    movieViewModel.getPopularList();
    movieViewModel.getUpcomingList();
  }

  @override
  void initState() {
    super.initState();
    setDatas();
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    // double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('Title')),
              trending(mediaHeight),
              popular(mediaHeight),
              upComing(mediaHeight),
            ],
          ),
        ),
      ),
    );
  }

  trending(double mediaHeight) {
    var trendingrHeight = mediaHeight * 0.4;
    var trendingrWidth = trendingrHeight * 3 / 4;
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trending'),
          SizedBox(
            height: trendingrHeight,
            child: Consumer<MovieViewModel>(
              builder: (context, trendingViewModel, child) {
                if (trendingViewModel.statusGetTrending ==
                    ConnectionStatus.loading) {
                  return Text('load');
                } else if (trendingViewModel.statusGetTrending ==
                    ConnectionStatus.success) {
                  var movieList = trendingViewModel.responseGetTrending.results;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: movieList!.length,
                    itemBuilder: (context, index) {
                      var baseImg = UiConfiguration.baseImage;
                      var posterPath = movieList[index].posterPath;
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            width: trendingrWidth,
                            imageUrl: '$baseImg$posterPath',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Text('error');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  popular(double mediaHeight) {
    var popularHeight = mediaHeight * 0.2;
    var popularWidth = popularHeight * 3 / 4;
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Popular'),
          SizedBox(
            height: popularHeight,
            child: Consumer<MovieViewModel>(
              builder: (context, popularViewModel, child) {
                if (popularViewModel.statusGetPopular ==
                    ConnectionStatus.loading) {
                  return Text('load');
                } else if (popularViewModel.statusGetPopular ==
                    ConnectionStatus.success) {
                  var movieList = popularViewModel.responseGetPopular.results;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: movieList!.length,
                    itemBuilder: (context, index) {
                      var baseImg = UiConfiguration.baseImage;
                      var posterPath = movieList[index].posterPath;
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            width: popularWidth,
                            imageUrl: '$baseImg$posterPath',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Text('error');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  upComing(double mediaHeight) {
    var upComingHeight = mediaHeight * 0.2;
    var upComingWidth = upComingHeight * 3 / 4;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming'),
          Consumer<MovieViewModel>(
            builder: (context, upcomingViewModel, child) {
              if (upcomingViewModel.statusGetUpcoming ==
                  ConnectionStatus.loading) {
                return Text('load');
              } else if (upcomingViewModel.statusGetUpcoming ==
                  ConnectionStatus.success) {
                var movieList = upcomingViewModel.responseGetUpcoming.results;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: movieList!.length,
                  itemBuilder: (context, index) {
                    var baseImg = UiConfiguration.baseImage;
                    var posterPath = movieList[index].posterPath;
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          width: upComingWidth,
                          imageUrl: '$baseImg$posterPath',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Text('error');
              }
            },
          ),
        ],
      ),
    );
  }
}
