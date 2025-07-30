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
  List<ValueNotifier<bool>> _expandedList = [];
  final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    movieDetailModel = Provider.of<MovieViewModel>(context, listen: false);
    movieDetailModel.getMovieDetail(widget.movieId);
    movieDetailModel.getCredits(widget.movieId);
    movieDetailModel.getVideos(widget.movieId);
    movieDetailModel.getReviews(widget.movieId);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _isExpanded.dispose();
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
            } else if (status == ConnectionStatus.success) {
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
                        reviews(),
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
      spacing: 20,
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
        SizedBox(
          height: castHeight,
          child: Consumer<MovieViewModel>(
            builder: (context, vm, child) {
              var cast = vm.responseGetCredits.cast;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cast!.length,
                itemBuilder: (context, index) {
                  var castIndex = cast[index];
                  return Padding(
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
                                imageUrl: '$baseImg${castIndex.profilePath}',
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.grey[300],
                                  alignment: Alignment.center,
                                  child: Text(
                                    'No Image',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: imageWidth,
                          child: Text(
                            '${castIndex.name}',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: imageWidth,
                          child: Text(
                            '${castIndex.character}',
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  reviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Consumer<MovieViewModel>(
          builder: (context, vm, child) {
            final status = vm.statusGetReviws;
            if (status == ConnectionStatus.loading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (status == ConnectionStatus.success) {
              var review = vm.responseGetReviews.results;
              _expandedList = List.generate(
                review!.length,
                (_) => ValueNotifier(false),
              );
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                itemCount: review.length,
                itemBuilder: (context, index) {
                  var reviewIndex = review[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              radius: 18,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '$baseImg${reviewIndex.authorDetails?.avatarPath}',
                                  fit: BoxFit.cover,
                                  width: 48,
                                  height: 48,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${reviewIndex.author}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      DateFormatter.formatDateTime(
                                        reviewIndex.createdAt.toString(),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                ValueListenableBuilder<bool>(
                                  valueListenable: _expandedList[index],
                                  builder: (context, isExpanded, child) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          reviewIndex.content!,
                                          style: const TextStyle(fontSize: 14),
                                          maxLines: isExpanded ? null : 4,
                                          overflow: isExpanded
                                              ? TextOverflow.visible
                                              : TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        if (reviewIndex.content!.length > 200)
                                          GestureDetector(
                                            onTap: () {
                                              _expandedList[index].value =
                                                  !_expandedList[index].value;
                                            },
                                            child: Text(
                                              isExpanded
                                                  ? 'Show less'
                                                  : 'Read more',
                                              style: const TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'Error loading movie details',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
