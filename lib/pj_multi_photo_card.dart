import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PJPadding {
  static const double page = 20.0;
  static const double gap5 = 5.0;
  static const double gap10 = 10.0;
  static const double gap15 = 15.0;
  static const double gap20 = 20.0;
  static const double gap25 = 25.0;
  static const double gap30 = 30.0;
  static const double gap35 = 35.0;
  static const double gap50 = 50.0;
}

class PJMultiPhotoCard extends StatefulWidget {
  final List<dynamic> images; // can be http urls, or assets
  final Function(int)? pageChanged;
  final int? initialPage;
  final bool allowReorder;

  const PJMultiPhotoCard({super.key, required this.images, this.pageChanged, this.initialPage, required this.allowReorder});

  @override
  State<PJMultiPhotoCard> createState() => _PJMultiPhotoCardState();
}

class _PJMultiPhotoCardState extends State<PJMultiPhotoCard> {
  final controller = PageController(viewportFraction: 1.0, keepPage: true);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.jumpToPage(widget.initialPage ?? 0);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: PJPadding.gap5),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(249, 249, 249, 1.0),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffdddddd),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(244, 244, 244, 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: PageView.builder(
                    controller: controller,
                    pageSnapping: true,

                    onPageChanged: widget.pageChanged,
                    itemCount: widget.images.length,
                    itemBuilder: (_, index) {
                      Widget? image;
                      // handle pure urls
                      if (widget.images[index] is String) {
                        image = CachedNetworkImage(
                            fadeOutDuration: const Duration(milliseconds: 50),
                            fadeInDuration: const Duration(milliseconds: 50),
                            imageUrl: widget.images[index],
                            imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain
                                    )
                                )
                            ),
                            progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  value: downloadProgress.progress,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            errorWidget: (BuildContext context, String str, dynamic args) => Container(
                              padding: const EdgeInsets.all(PJPadding.page),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Unable to load image', style: Theme.of(context).textTheme.headlineSmall),
                                    ],
                                  ),
                                  const SizedBox(height: PJPadding.gap5),
                                  const Text('Check your network and try again')
                                ],
                              ),
                            )

                        );
                      }

                      return GestureDetector(
                        onTap: () {
                          debugPrint('tapped');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: PJPadding.gap5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: image,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: PJPadding.gap5, top: PJPadding.gap10),
                child: SmoothPageIndicator(
                  controller: controller,
                  count: widget.images.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.black.withOpacity(0.8),
                    dotColor: Colors.black.withOpacity(0.25),
                    dotHeight: 6,
                    dotWidth: 6,
                  ),
                ),
              )
            ],
          ),
        ),

      ],
    );
  }
}
