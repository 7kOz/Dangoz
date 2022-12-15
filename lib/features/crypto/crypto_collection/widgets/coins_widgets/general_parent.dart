import 'package:carousel_slider/carousel_slider.dart';
import 'package:dangoz/features/crypto/crypto_collection/widgets/coins_widgets/general_first_carousel.dart';
import 'package:dangoz/features/crypto/crypto_collection/widgets/coins_widgets/general_second_carousel.dart';
import 'package:dangoz/features/crypto/crypto_collection/widgets/coins_widgets/general_third_carousel.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GeneralParent extends StatefulWidget {
  dynamic cryptoMarketGeneralViewSnapshot;
  dynamic cryptoMarketCapSnapshot;
  GeneralParent({
    Key? key,
    required this.cryptoMarketGeneralViewSnapshot,
    required this.cryptoMarketCapSnapshot,
  }) : super(key: key);

  @override
  State<GeneralParent> createState() => _GeneralParentState();
}

class _GeneralParentState extends State<GeneralParent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Container(
                    height: Get.height * 0.15,
                    width: Get.width,
                    //Future Builder For MarketCap
                    child: FutureBuilder(
                      future: widget.cryptoMarketCapSnapshot,
                      builder: (BuildContext context,
                          AsyncSnapshot snapshotMarketcap) {
                        if (snapshotMarketcap.hasData) {
                          //FutureBuilder For General Data
                          return FutureBuilder(
                            future: widget.cryptoMarketGeneralViewSnapshot,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                int marketCap =
                                    snapshotMarketcap.data!['market_cap_usd'];
                                int volume =
                                    snapshotMarketcap.data!['volume_24h_usd'];
                                String _fromattedMarketCap =
                                    NumberFormat.compact(
                                  locale: 'en_IN',
                                ).format(marketCap);

                                String _formattedVolume = NumberFormat.compact(
                                  locale: 'en_IN',
                                ).format(volume);
                                List marketCapPercentageKeys = [];
                                List marketCapPercentageValues = [];

                                marketCapPercentageKeys = snapshot
                                    .data!['data']['market_cap_percentage'].keys
                                    .toList();
                                marketCapPercentageValues = snapshot
                                    .data!['data']['market_cap_percentage']
                                    .values
                                    .toList();
                                return CarouselSlider.builder(
                                  options: CarouselOptions(
                                    height: 400,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.8,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  itemCount: 3,
                                  itemBuilder: (BuildContext context,
                                          int itemIndex, int pageViewIndex) =>
                                      itemIndex == 1
                                          ? GeneralFirstCarousel(
                                              snapshot: snapshot)
                                          : itemIndex == 2
                                              ? GeneralSecondCarousel(
                                                  snapshot: snapshot,
                                                  marketCap:
                                                      _fromattedMarketCap,
                                                  marketCapPercentageKeys:
                                                      marketCapPercentageKeys,
                                                  marketCapPercentageValues:
                                                      marketCapPercentageValues,
                                                )
                                              : GeneralThirdCarousel(
                                                  snapshotMarketcap:
                                                      snapshotMarketcap,
                                                  volume: _formattedVolume,
                                                ),
                                );
                              } else if (snapshot.hasError) {
                                print(snapshot.error);
                                return const Text('Error');
                              }
                              return const CircularProgressIndicator();
                            },
                          );
                        } else if (snapshotMarketcap.hasError) {
                          print(snapshotMarketcap.error);
                          return const Text('Error');
                        }
                        return Container();
                      },
                    )))
          ],
        ),
      ),
    );
  }
}
