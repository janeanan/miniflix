import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniflix/model/apis/ui_configuration.dart';
import 'package:miniflix/utils/enum.dart';
import 'package:miniflix/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

class ViewDetail extends StatefulWidget {
  final String movieId;

  const ViewDetail({super.key, required this.movieId});

  @override
  State<ViewDetail> createState() => _ViewDetailState();
}

class _ViewDetailState extends State<ViewDetail> {
  late MovieViewModel movieDetailModel;
  final String baseImg = UiConfiguration.baseImage;
  String trailerKey = '';

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    movieDetailModel = Provider.of<MovieViewModel>(context, listen: false);
    movieDetailModel.getMovieDetail(widget.movieId);
    movieDetailModel.getVideos(widget.movieId);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<MovieViewModel>(
          builder: (context, vm, child) {
            final status = vm.statusGetMovieDetail;
            if (status == ConnectionStatus.loading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            if (status == ConnectionStatus.success) {
              final movie = vm.responseGetMovieDetail;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 4 / 2.5,
                        child: CachedNetworkImage(
                          imageUrl: '$baseImg${movie.backdropPath}',
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 4 / 2.5,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.1),
                                const Color.fromARGB(255, 20, 20, 20),
                              ],
                              stops: const [0.3, 1.0],
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: CircleAvatar(
                            backgroundColor: Colors.black.withValues(
                              alpha: 0.3,
                            ),
                            child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title ?? '',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.height * 0.15,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red.shade900,
                          ),
                          child: TextButton.icon(
                            onPressed: () {
                              for (var item
                                  in movieDetailModel
                                      .responseGetvideos
                                      .results!) {
                                if (item.type == 'Trailer') {
                                  trailerKey = item.key.toString();
                                  break;
                                }
                              }
                              context.push('/videoView', extra: trailerKey);
                            },
                            label: Text(
                              'Trailer',
                              style: TextStyle(color: Colors.white),
                            ),
                            icon: Icon(
                              Icons.play_arrow,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          'Storyline',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          movie.overview ?? '',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        castAndCrew(),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: Text(
                'Error loading movie details',
                style: TextStyle(color: Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }

  castAndCrew() {
    const double castHeight = 150;
    final double imageWidth = castHeight * 0.6;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cast & Crew',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: castHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: imageWidth,
                      height: castHeight * 0.75,
                      child: AspectRatio(
                        aspectRatio: 1 / 1.3,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://i.pinimg.com/1200x/3a/29/b4/3a29b4b45427220dbda245a0c143864c.jpg',
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: imageWidth,
                    child: const Text(
                      'Actor Name',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: imageWidth,
                    child: const Text(
                      'Character',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
