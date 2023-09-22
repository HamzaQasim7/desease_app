import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/resources/app_colors.dart';
import 'package:test_app/view_model/slider_view_model.dart';

class FeatureCarousel extends StatefulWidget {
  const FeatureCarousel({super.key});

  @override
  State<FeatureCarousel> createState() => _FeatureCarouselState();
}

class _FeatureCarouselState extends State<FeatureCarousel> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Consumer<SliderItemViewModel>(
      builder: (context, sliderProvider, child) {
        if (!sliderProvider.isLoading && sliderProvider.sliderItem == null) {
          sliderProvider.fetchSliderItem();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              itemCount: sliderProvider.sliderItem == null
                  ? 0
                  : sliderProvider.sliderItem!.length,
              // Only one item or none, as SliderItemModel is not a collection
              itemBuilder: (BuildContext context, int index, int realIndex) {
                if (sliderProvider.sliderItem == null) {
                  return const Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: AppColors.primaryColor,
                  ));
                }
                final item = sliderProvider.sliderItem![index];
                final imageUrl = item.image;
                // final link = item.link;

                return GestureDetector(
                  onTap: () {
                    // Handle tapping on the carousel item here
                    // You can navigate to the link or perform some action.
                    // if (link != null && link.isNotEmpty) {
                    //   launch(link);
                    // }
                  },
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: width,
                    height: height,
                  ),
                );
              },
              options: CarouselOptions(
                height: 150.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0;
                    i < (sliderProvider.sliderItem?.length ?? 0);
                    i++)
                  Container(
                    height: 13,
                    width: 13,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: currentIndex == i ? Colors.blue : Colors.grey,
                      shape: BoxShape.circle,
                      boxShadow: currentIndex == i
                          ? const [
                              BoxShadow(
                                color: Colors.blue,
                                spreadRadius: 1,
                                blurRadius: 0,
                                offset: Offset(1, 0),
                              ),
                            ]
                          : null, // Add a shadow for the selected dot
                    ),
                  )
              ],
            ),
          ],
        );
      },
    );
  }
}
