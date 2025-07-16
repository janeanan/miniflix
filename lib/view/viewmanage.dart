import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniflix/model/apis/ui_configuration.dart';
import 'package:miniflix/utils/enum.dart';
import 'package:miniflix/view/component/shimmer.dart';
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
              Center(
                child: Text(
                  'MiniFlix',
                  style: GoogleFonts.bebasNeue(color: Colors.red, fontSize: 48),
                ),
              ),
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
    var trendingrWidth = trendingrHeight * 3 / 4.5;
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trending', style: GoogleFonts.abel(fontSize: 24)),
          SizedBox(
            height: trendingrHeight,
            child: Consumer<MovieViewModel>(
              builder: (context, trendingViewModel, child) {
                if (trendingViewModel.statusGetTrending ==
                    ConnectionStatus.loading) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: LoadShimmer(
                          width: trendingrWidth,
                          height: trendingrHeight,
                        ),
                      );
                    },
                  );
                } else if (trendingViewModel.statusGetTrending ==
                    ConnectionStatus.success) {
                  var movieList = trendingViewModel.responseGetTrending.results;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: movieList!.length,
                    itemBuilder: (context, index) {
                      var baseImg = UiConfiguration.baseImage;
                      var movieId = movieList[index].id;
                      var posterPath = movieList[index].posterPath;
                      var voteAverage = movieList[index].voteAverage! * 10;
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.go(
                                  '/viewDetails',
                                  extra: movieId.toString(),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: AspectRatio(
                                  aspectRatio: 3 / 4.5,
                                  child: CachedNetworkImage(
                                    imageUrl: '$baseImg$posterPath',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: CircleAvatar(
                                maxRadius: trendingrWidth * 0.06,
                                backgroundColor: calColor(voteAverage),
                                child: CircleAvatar(
                                  maxRadius: trendingrWidth * 0.05,
                                  backgroundColor: Colors.black.withValues(
                                    alpha: 0.7,
                                  ),
                                  child: Text(
                                    voteAverage.toStringAsFixed(0).toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
    var popularWidth = popularHeight * 3 / 4.5;
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Popular', style: GoogleFonts.abel(fontSize: 24)),
          SizedBox(
            height: popularHeight,
            child: Consumer<MovieViewModel>(
              builder: (context, popularViewModel, child) {
                if (popularViewModel.statusGetPopular ==
                    ConnectionStatus.loading) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: LoadShimmer(
                          width: popularWidth,
                          height: popularHeight,
                        ),
                      );
                    },
                  );
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
                          child: AspectRatio(
                            aspectRatio: 3 / 4.5,
                            child: CachedNetworkImage(
                              imageUrl: '$baseImg$posterPath',
                              fit: BoxFit.cover,
                            ),
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
    var upComingWidth = upComingHeight * 3 / 4.5;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming', style: GoogleFonts.abel(fontSize: 24)),
          Consumer<MovieViewModel>(
            builder: (context, upcomingViewModel, child) {
              if (upcomingViewModel.statusGetUpcoming ==
                  ConnectionStatus.loading) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 3 / 4.5,
                  ),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: LoadShimmer(
                        width: upComingWidth,
                        height: upComingHeight,
                      ),
                    );
                  },
                );
              } else if (upcomingViewModel.statusGetUpcoming ==
                  ConnectionStatus.success) {
                var movieList = upcomingViewModel.responseGetUpcoming.results;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 25,
                    childAspectRatio: 3 / 4.5,
                  ),
                  itemCount: movieList!.length,
                  itemBuilder: (context, index) {
                    var baseImg = UiConfiguration.baseImage;
                    var posterPath = movieList[index].posterPath;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: '$baseImg$posterPath',
                        fit: BoxFit.cover,
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

  calColor(double voteAverage) {
    if (voteAverage <= 25) {
      return Colors.red;
    } else if (voteAverage <= 50) {
      return Colors.orange;
    } else if (voteAverage <= 75) {
      return Colors.yellow;
    } else {
      return Colors.greenAccent;
    }
  }
}
