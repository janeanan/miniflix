import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  void initState() {
    super.initState();
    movieViewModel = Provider.of<MovieViewModel>(context, listen: false);
    movieViewModel.getTrendingList();
    movieViewModel.getPopularList();
    movieViewModel.getUpcomingList();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'MiniFlix',
                  style: GoogleFonts.bebasNeue(color: Colors.red, fontSize: 48),
                ),
              ),
              Column(
                spacing: 30,
                children: [
                  trending(mediaHeight),
                  popular(),
                  upComing(orientation),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  trending(double mediaHeight) {
    const trendingHeight = 350.0;
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trending', style: GoogleFonts.abel(fontSize: 24)),
          SizedBox(
            height: trendingHeight,
            child: Consumer<MovieViewModel>(
              builder: (context, vm, child) {
                final status = vm.statusGetTrending;
                if (status == ConnectionStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (status == ConnectionStatus.success) {
                  final movieList = vm.responseGetTrending.results!;
                  final baseImg = UiConfiguration.baseImage;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movieList.length,
                    itemBuilder: (context, index) {
                      final movie = movieList[index];
                      final voteAverage = movie.voteAverage! * 10;

                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () => context.push(
                                '/viewDetails',
                                extra: movie.id.toString(),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: AspectRatio(
                                  aspectRatio: 3 / 4.5,
                                  child: CachedNetworkImage(
                                    imageUrl: '$baseImg${movie.posterPath}',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 2,
                              left: 2,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: calColor(voteAverage),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.black.withValues(
                                    alpha: 0.6,
                                  ),
                                  child: Text(
                                    voteAverage.toStringAsFixed(0),
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
                }
                return const Text('Error loading trending movies');
              },
            ),
          ),
        ],
      ),
    );
  }

  popular() {
    const popularHeight = 180.0;

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Popular', style: GoogleFonts.abel(fontSize: 24)),
          SizedBox(
            height: popularHeight,
            child: Consumer<MovieViewModel>(
              builder: (context, vm, child) {
                final status = vm.statusGetPopular;
                if (status == ConnectionStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (status == ConnectionStatus.success) {
                  final movieList = vm.responseGetPopular.results!;
                  final baseImg = UiConfiguration.baseImage;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movieList.length,
                    itemBuilder: (context, index) {
                      final posterPath = movieList[index].posterPath;

                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: AspectRatio(
                            aspectRatio: 3 / 4.5,
                            child: CachedNetworkImage(
                              imageUrl: '$baseImg$posterPath',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Text('Error loading popular movies');
              },
            ),
          ),
        ],
      ),
    );
  }

  upComing(Orientation orientation) {
    final crossCount = orientation == Orientation.portrait ? 2 : 3;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming', style: GoogleFonts.abel(fontSize: 24)),
          Consumer<MovieViewModel>(
            builder: (context, vm, child) {
              final status = vm.statusGetUpcoming;

              if (status == ConnectionStatus.loading) {
                return Center(child: CircularProgressIndicator());
              }

              if (status == ConnectionStatus.success) {
                final movieList = vm.responseGetUpcoming.results!;
                final baseImg = UiConfiguration.baseImage;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossCount,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 3 / 4.5,
                  ),
                  itemCount: movieList.length,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: '$baseImg${movieList[index].posterPath}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                );
              }

              return const Text('Error loading upcoming movies');
            },
          ),
        ],
      ),
    );
  }

  calColor(double voteAverage) {
    if (voteAverage <= 25) return Colors.red;
    if (voteAverage <= 50) return Colors.orange;
    if (voteAverage <= 75) return Colors.yellow;
    return Colors.greenAccent;
  }
}
