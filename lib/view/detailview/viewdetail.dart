import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  String baseImg = UiConfiguration.baseImage;
  late MovieViewModel movieDetailModel;

  setData() {
    movieDetailModel = Provider.of<MovieViewModel>(context, listen: false);
    movieDetailModel.getMovieDetail(widget.movieId);
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    // double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<MovieViewModel>(
          builder: (context, movieDetailviewModel, child) {
            if (movieDetailviewModel.statusGetMovieDetail ==
                ConnectionStatus.loading) {
              return Text('load');
            } else if (movieDetailviewModel.statusGetMovieDetail ==
                ConnectionStatus.success) {
              var movieDetailData = movieDetailviewModel.responseGetMovieDetail;
              var backdropPath = movieDetailData.backdropPath;
              var movieTitle = movieDetailData.title;
              var movieOverview = movieDetailData.overview;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 4 / 2.5,
                        child: CachedNetworkImage(
                          imageUrl: '$baseImg$backdropPath',
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
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.1),
                                Color.fromARGB(255, 20, 20, 20),
                              ],
                              stops: [0.3, 1.0],
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
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieTitle.toString(),
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                        ),
                        Text(
                          'Storyline',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                        ),
                        Text(
                          movieOverview.toString(),
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        castAndCrew(mediaHeight),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Text('Error');
            }
          },
        ),
      ),
    );
  }

  castAndCrew(double mediaHeight) {
    var theCastHeight = mediaHeight * 0.2;
    // var theCastWidth = theCastHeight * 3 / 4;
    final double imageWidth = theCastHeight * 0.6;
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
          height: theCastHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: imageWidth,
                        child: AspectRatio(
                          aspectRatio: 1 / 1.3, // อัตราส่วนภาพ
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://i.pinimg.com/1200x/3a/29/b4/3a29b4b45427220dbda245a0c143864c.jpg',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error, color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Actor Name',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const Text(
                      'Character',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
