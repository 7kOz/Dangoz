import 'package:dangoz/apis/crypto_apis/general_crypto_api.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:emojis/emoji.dart';
import 'package:emojis/emojis.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CoinDetailsScreen extends StatefulWidget {
  String title;
  String id;
  CoinDetailsScreen({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);

  @override
  State<CoinDetailsScreen> createState() => _CoinDetailsScreenState();
}

class _CoinDetailsScreenState extends State<CoinDetailsScreen> {
  dynamic coinDetailsSnapshot;

  @override
  void initState() {
    super.initState();
    coinDetailsSnapshot = GeneralCryptoApi().getCoinData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.navy,
          elevation: 5,
          title: Text(
            widget.title,
            style: TextStyle(
              fontSize: Get.width * 0.05,
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: FutureBuilder(
          future: coinDetailsSnapshot,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              String name = snapshot.data!['name'] ?? '';
              String image = snapshot.data!['image']['small'] ?? '';
              int marketCapRank = snapshot.data!['market_cap_rank'] ?? 00;
              double upvotes =
                  snapshot.data!['sentiment_votes_up_percentage'] ?? 00;
              double downvotes =
                  snapshot.data!['sentiment_votes_down_percentage'] ?? 00;
              double low24hPrice =
                  snapshot.data!['market_data']['low_24h']['usd'] ?? 0;
              double high24Price =
                  snapshot.data!['market_data']['high_24h']['usd'] ?? 0;

              double lowMarketPrice24h =
                  snapshot.data!['market_data']['low_24h']['usd'] ?? 0;
              double highMarketPrice24h =
                  snapshot.data!['market_data']['high_24h']['usd'] ?? 0;

              double currentPrice =
                  snapshot.data!['market_data']['current_price']['usd'] ?? 0;

              double priceChange1h = snapshot.data!['market_data']
                      ['price_change_percentage_1h_in_currency']['usd'] ??
                  0.0000000;

              double priceChange24h = snapshot.data!['market_data']
                      ['price_change_percentage_24h_in_currency']['usd'] ??
                  0.000000;

              double priceChange7d = snapshot.data!['market_data']
                      ['price_change_percentage_7d_in_currency']['usd'] ??
                  0.000000;

              double priceChange30d = snapshot.data!['market_data']
                      ['price_change_percentage_30d_in_currency']['usd'] ??
                  0.00000;
              double priceChange60d = snapshot.data!['market_data']
                      ['price_change_percentage_60d_in_currency']['usd'] ??
                  0.00000;
              dynamic unsortedMap = snapshot.data!['tickers'];
              dynamic sortedMap = unsortedMap
                ..sort((a, b) => double.parse(
                        b['converted_volume']['usd'].toString())
                    .compareTo(
                        double.parse(a['converted_volume']['usd'].toString())));

              return Container(
                height: Get.height,
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: LiquidPullToRefresh(
                    height: Get.height * 0.3,
                    color: AppColors.navy,
                    backgroundColor: AppColors.white,
                    onRefresh: () async {
                      setState(
                        () {
                          coinDetailsSnapshot =
                              GeneralCryptoApi().getCoinData(widget.id);
                        },
                      );
                    },
                    child: ListView(
                      children: [
                        SizedBox(height: Get.height * 0.025),
                        Center(
                          child: Text(
                            name,
                            style: TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w500,
                              fontSize: Get.width * 0.04,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Center(
                          child: image != ''
                              ? Image.network(
                                  image,
                                  height: Get.height * 0.05,
                                  fit: BoxFit.contain,
                                )
                              : Container(),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Center(
                          child: Text(
                            '# $marketCapRank',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w500,
                              fontSize: Get.width * 0.04,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${Emoji.byChar(Emojis.thumbsUp)} $upvotes%',
                              style: TextStyle(
                                color: AppColors.green,
                                fontSize: Get.width * 0.04,
                              ),
                            ),
                            Text(
                              '${Emoji.byChar(Emojis.thumbsDown)} $downvotes%',
                              style: TextStyle(
                                color: AppColors.red,
                                fontSize: Get.width * 0.04,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(color: AppColors.navy),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Center(
                          child: Text(
                            '24h Price',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w500,
                              fontSize: Get.width * 0.04,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            height: Get.height * 0.4,
                            width: Get.width,
                            child: SfRadialGauge(
                              axes: <RadialAxis>[
                                RadialAxis(
                                  showFirstLabel: false,
                                  showLastLabel: false,
                                  minorTickStyle: MinorTickStyle(
                                      color: AppColors.lightGrey),
                                  majorTickStyle:
                                      MinorTickStyle(color: AppColors.green),
                                  tickOffset: 10,
                                  canScaleToFit: true,
                                  minimum: low24hPrice,
                                  maximum: high24Price,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                      startValue: lowMarketPrice24h,
                                      endValue: (highMarketPrice24h +
                                              lowMarketPrice24h) /
                                          2,
                                      color: AppColors.red,
                                    ),
                                    GaugeRange(
                                      startValue: (highMarketPrice24h +
                                              lowMarketPrice24h) /
                                          2,
                                      endValue: highMarketPrice24h,
                                      color: AppColors.green,
                                    ),
                                  ],
                                  pointers: <GaugePointer>[
                                    MarkerPointer(
                                      value: currentPrice,
                                      enableAnimation: true,
                                      color: AppColors.navy,
                                      markerHeight: Get.height * 0.02,
                                      markerWidth: Get.width * 0.05,
                                      markerOffset: -20,
                                    ),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Text(
                                        '\$ $currentPrice',
                                        style: TextStyle(
                                          color: AppColors.green,
                                          fontWeight: FontWeight.w600,
                                          fontSize: Get.width * 0.045,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      positionFactor: 0,
                                      angle: 90,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(color: AppColors.navy),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            height: Get.height * 0.1,
                            width: Get.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.navy),
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: Get.width * 0.1,
                                      child: Center(
                                        child: Text(
                                          '1h %',
                                          style: TextStyle(
                                              color: AppColors.navy,
                                              fontSize: Get.width * 0.025),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: Get.height * 0.025,
                                      child: VerticalDivider(
                                        color: AppColors.lightGrey,
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.1,
                                      child: Center(
                                        child: Text(
                                          '24h %',
                                          style: TextStyle(
                                              color: AppColors.navy,
                                              fontSize: Get.width * 0.025),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: Get.height * 0.025,
                                      child: VerticalDivider(
                                        color: AppColors.lightGrey,
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.1,
                                      child: Center(
                                        child: Text(
                                          '7d %',
                                          style: TextStyle(
                                              color: AppColors.navy,
                                              fontSize: Get.width * 0.025),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: Get.height * 0.025,
                                      child: VerticalDivider(
                                        color: AppColors.lightGrey,
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.1,
                                      child: Center(
                                        child: Text(
                                          '30d %',
                                          style: TextStyle(
                                              color: AppColors.navy,
                                              fontSize: Get.width * 0.025),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: Get.height * 0.025,
                                      child: VerticalDivider(
                                        color: AppColors.lightGrey,
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.1,
                                      child: Center(
                                        child: Text(
                                          '60d %',
                                          style: TextStyle(
                                              color: AppColors.navy,
                                              fontSize: Get.width * 0.025),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: AppColors.lightGrey,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: Get.width * 0.1,
                                      child: Center(
                                        child: Text(
                                          '${priceChange1h.toString().substring(0, 5)}%',
                                          style: TextStyle(
                                              color:
                                                  priceChange1h.toString()[0] ==
                                                          '-'
                                                      ? AppColors.red
                                                      : AppColors.green,
                                              fontSize: Get.width * 0.025),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: Get.height * 0.025,
                                      child: VerticalDivider(
                                        color: AppColors.lightGrey,
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.1,
                                      child: Center(
                                        child: Text(
                                          '${priceChange24h.toString().substring(0, 5)}%',
                                          style: TextStyle(
                                              color: priceChange24h
                                                          .toString()[0] ==
                                                      '-'
                                                  ? AppColors.red
                                                  : AppColors.green,
                                              fontSize: Get.width * 0.025),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: Get.height * 0.025,
                                      child: VerticalDivider(
                                        color: AppColors.lightGrey,
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.1,
                                      child: Center(
                                        child: Text(
                                          '${priceChange7d.toString().substring(0, 5)}%',
                                          style: TextStyle(
                                              color:
                                                  priceChange7d.toString()[0] ==
                                                          '-'
                                                      ? AppColors.red
                                                      : AppColors.green,
                                              fontSize: Get.width * 0.025),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: Get.height * 0.025,
                                      child: VerticalDivider(
                                        color: AppColors.lightGrey,
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.1,
                                      child: Center(
                                        child: Text(
                                          '${priceChange30d.toString().substring(0, 3)}%',
                                          style: TextStyle(
                                              color: priceChange30d
                                                          .toString()[0] ==
                                                      '-'
                                                  ? AppColors.red
                                                  : AppColors.green,
                                              fontSize: Get.width * 0.025),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: Get.height * 0.025,
                                      child: VerticalDivider(
                                        color: AppColors.lightGrey,
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.1,
                                      child: Center(
                                        child: Text(
                                          '${priceChange60d.toString().substring(0, 4)}%',
                                          style: TextStyle(
                                              color: priceChange60d
                                                          .toString()[0] ==
                                                      '-'
                                                  ? AppColors.red
                                                  : AppColors.green,
                                              fontSize: Get.width * 0.025),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(color: AppColors.navy),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Circulating Supply',
                                style: TextStyle(
                                  color: AppColors.navy,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Get.width * 0.035,
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Text(
                                snapshot.data!['market_data']
                                            ['circulating_supply'] ==
                                        null
                                    ? 'Not Available'
                                    : NumberFormat.compact()
                                        .format(snapshot.data!['market_data']
                                                ['circulating_supply'] ??
                                            0)
                                        .toString(),
                                style: TextStyle(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Get.width * 0.035,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SfLinearGauge(
                            minimum: 0,
                            maximum: snapshot.data!['market_data']
                                    ['total_supply'] ??
                                0,
                            showLabels: false,
                            showAxisTrack: false,
                            showTicks: false,
                            ranges: [
                              LinearGaugeRange(
                                startValue: 0,
                                endValue: snapshot.data!['market_data']
                                        ['circulating_supply'] ??
                                    0,
                                color: AppColors.green,
                              ),
                              LinearGaugeRange(
                                startValue: snapshot.data!['market_data']
                                        ['circulating_supply'] ??
                                    0,
                                endValue: snapshot.data!['market_data']
                                        ['total_supply'] ??
                                    0,
                                color: AppColors.navy,
                              ),
                            ],
                            markerPointers: [
                              LinearShapePointer(
                                value: snapshot.data!['market_data']
                                        ['circulating_supply'] ??
                                    0,
                                offset: 10,
                                elevation: 5,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Total Supply',
                                style: TextStyle(
                                  color: AppColors.navy,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Get.width * 0.035,
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Text(
                                snapshot.data!['market_data']['total_supply'] ==
                                        null
                                    ? 'Not Available'
                                    : NumberFormat.compact()
                                        .format(snapshot.data!['market_data']
                                                ['total_supply'] ??
                                            0)
                                        .toString(),
                                style: TextStyle(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Get.width * 0.035,
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.025),
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Max Supply',
                                      style: TextStyle(
                                        color: AppColors.navy,
                                        fontWeight: FontWeight.w500,
                                        fontSize: Get.width * 0.035,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    Text(
                                      snapshot.data!['market_data']
                                                  ['max_supply'] ==
                                              null
                                          ? 'Not Available'
                                          : NumberFormat.compact()
                                              .format(
                                                  snapshot.data!['market_data']
                                                          ['max_supply'] ??
                                                      0)
                                              .toString(),
                                      style: TextStyle(
                                        color: AppColors.green,
                                        fontWeight: FontWeight.w500,
                                        fontSize: Get.width * 0.035,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                NumberFormat.compact()
                                    .format(snapshot.data!['market_data']
                                        ['total_supply'])
                                    .toString(),
                                style: TextStyle(
                                  color: AppColors.navy,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Get.width * 0.03,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(color: AppColors.navy),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Market Cap',
                                    style: TextStyle(
                                      color: AppColors.navy,
                                      fontWeight: FontWeight.w500,
                                      fontSize: Get.width * 0.035,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Text(
                                    '\$ ${NumberFormat.compact().format(snapshot.data!['market_data']['market_cap']['usd'] ?? '')}',
                                    style: TextStyle(
                                      color: AppColors.green,
                                      fontWeight: FontWeight.w500,
                                      fontSize: Get.width * 0.035,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '24h Change',
                                    style: TextStyle(
                                      color: AppColors.navy,
                                      fontWeight: FontWeight.w500,
                                      fontSize: Get.width * 0.035,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Text(
                                    '${snapshot.data!['market_data']['market_cap_change_percentage_24h_in_currency']['usd']}%',
                                    style: TextStyle(
                                      color: snapshot.data!['market_data'][
                                                      'market_cap_change_percentage_24h_in_currency']
                                                      ['usd']
                                                  .toString()[0] ==
                                              '-'
                                          ? AppColors.red
                                          : AppColors.green,
                                      fontWeight: FontWeight.w500,
                                      fontSize: Get.width * 0.035,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(color: AppColors.navy),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Volume',
                                style: TextStyle(
                                  color: AppColors.navy,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Get.width * 0.035,
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Text(
                                NumberFormat.compact()
                                    .format(snapshot.data!['market_data']
                                            ['total_volume']['usd'] ??
                                        0)
                                    .toString(),
                                style: TextStyle(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Get.width * 0.035,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(color: AppColors.navy),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Center(
                          child: Text(
                            'ATH',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w500,
                              fontSize: Get.width * 0.035,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                snapshot.data!['market_data']['atl_date']['usd']
                                    .toString()
                                    .substring(0, 10),
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Get.width * 0.035,
                                  letterSpacing: 1,
                                ),
                              ),
                              Text(
                                snapshot.data!['market_data']['ath_date']['usd']
                                    .toString()
                                    .substring(0, 10),
                                style: TextStyle(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Get.width * 0.035,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            height: Get.height * 0.4,
                            width: Get.width,
                            child: SfRadialGauge(
                              axes: <RadialAxis>[
                                RadialAxis(
                                  showFirstLabel: false,
                                  showLastLabel: false,
                                  minorTickStyle: MinorTickStyle(
                                      color: AppColors.lightGrey),
                                  majorTickStyle:
                                      MinorTickStyle(color: AppColors.green),
                                  tickOffset: 10,
                                  canScaleToFit: true,
                                  minimum: snapshot.data!['market_data']['atl']
                                          ['usd']
                                      .toDouble(),
                                  maximum: snapshot.data!['market_data']['ath']
                                          ['usd']
                                      .toDouble(),
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                      startValue: snapshot.data!['market_data']
                                              ['atl']['usd']
                                          .toDouble(),
                                      endValue: (snapshot.data!['market_data']
                                                      ['atl']['usd']
                                                  .toDouble() +
                                              snapshot.data!['market_data']
                                                      ['ath']['usd']
                                                  .toDouble()) /
                                          2,
                                      color: AppColors.red,
                                    ),
                                    GaugeRange(
                                      startValue: (snapshot.data!['market_data']
                                                  ['atl']['usd'] +
                                              snapshot.data!['market_data']
                                                  ['ath']['usd']) /
                                          2,
                                      endValue: double.parse(snapshot
                                          .data!['market_data']['ath']['usd']
                                          .toString()),
                                      color: AppColors.green,
                                    ),
                                  ],
                                  pointers: <GaugePointer>[
                                    MarkerPointer(
                                      value: snapshot.data!['market_data']
                                          ['current_price']['usd'],
                                      enableAnimation: true,
                                      color: AppColors.navy,
                                      markerHeight: Get.height * 0.02,
                                      markerWidth: Get.width * 0.05,
                                      markerOffset: -20,
                                    ),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${snapshot.data!['market_data']['ath_change_percentage']['usd'].toString().substring(0, 6)}%',
                                            style: TextStyle(
                                              color: snapshot
                                                          .data!['market_data'][
                                                              'ath_change_percentage']
                                                              ['usd']
                                                          .toString()[0] ==
                                                      '-'
                                                  ? AppColors.red
                                                  : AppColors.green,
                                              fontWeight: FontWeight.w600,
                                              fontSize: Get.width * 0.045,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'From ATH',
                                            style: TextStyle(
                                              color: snapshot
                                                          .data!['market_data'][
                                                              'ath_change_percentage']
                                                              ['usd']
                                                          .toString()[0] ==
                                                      '-'
                                                  ? AppColors.red
                                                  : AppColors.green,
                                              fontWeight: FontWeight.w600,
                                              fontSize: Get.width * 0.025,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      positionFactor: 0,
                                      angle: 90,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(color: AppColors.navy),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            snapshot.data!['description']['en'] ?? '',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w600,
                              fontSize: Get.width * 0.035,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(color: AppColors.navy),
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Container(
                          height: Get.height * 0.08,
                          width: Get.width,
                          color: AppColors.navy,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: Get.width * 0.08,
                                  child: Center(
                                    child: Text(
                                      '#',
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: Get.width * 0.0325),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  color: AppColors.white,
                                ),
                                Container(
                                  width: Get.width * 0.2,
                                  child: Text(
                                    'Base/Target',
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: Get.width * 0.0325),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                VerticalDivider(
                                  color: AppColors.white,
                                ),
                                Container(
                                  width: Get.width * 0.18,
                                  child: Text(
                                    'Market',
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: Get.width * 0.0325),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                VerticalDivider(
                                  color: AppColors.white,
                                ),
                                Container(
                                  width: Get.width * 0.2,
                                  child: Text(
                                    'Volume',
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: Get.width * 0.0325),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                VerticalDivider(
                                  color: AppColors.white,
                                ),
                                Container(
                                  width: Get.width * 0.1,
                                  child: Text(
                                    'Trust',
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: Get.width * 0.0325),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: Get.height * 0.5,
                          width: Get.width,
                          child: ListView.builder(
                            itemCount: sortedMap.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Container(
                                    height: Get.height * 0.08,
                                    width: Get.width,
                                    color: AppColors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: Get.width * 0.08,
                                            child: Center(
                                              child: Text(
                                                (index + 1).toString(),
                                                style: TextStyle(
                                                    color: AppColors.navy,
                                                    fontSize:
                                                        Get.width * 0.0325),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: AppColors.lightGrey,
                                          ),
                                          Container(
                                            width: Get.width * 0.2,
                                            child: Text(
                                              '${snapshot.data!['tickers'][index]['base']}/${snapshot.data!['tickers'][index]['target']}',
                                              style: TextStyle(
                                                  color: AppColors.navy,
                                                  fontSize: Get.width * 0.0325),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: AppColors.lightGrey,
                                          ),
                                          Container(
                                            width: Get.width * 0.18,
                                            child: Text(
                                              snapshot.data!['tickers'][index]
                                                  ['market']['name'],
                                              style: TextStyle(
                                                  color: AppColors.navy,
                                                  fontSize: Get.width * 0.0325),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: AppColors.lightGrey,
                                          ),
                                          Container(
                                            width: Get.width * 0.2,
                                            child: Text(
                                              NumberFormat.compact()
                                                  .format(snapshot.data![
                                                                      'tickers']
                                                                  [index]
                                                              [
                                                              'converted_volume']
                                                          ['usd'] ??
                                                      0)
                                                  .toString(),
                                              style: TextStyle(
                                                  color: AppColors.navy,
                                                  fontSize: Get.width * 0.0325),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: AppColors.lightGrey,
                                          ),
                                          Container(
                                              width: Get.width * 0.1,
                                              child: snapshot.data!['tickers']
                                                              [index]
                                                          ['trust_score'] ==
                                                      'green'
                                                  ? Icon(
                                                      CupertinoIcons.check_mark,
                                                      color: AppColors.green,
                                                      size: Get.width * 0.04,
                                                    )
                                                  : Icon(
                                                      CupertinoIcons.xmark,
                                                      color: AppColors.red,
                                                      size: Get.width * 0.04,
                                                    )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: AppColors.lightGrey,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: Get.height * 0.05),
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitCubeGrid(
                  color: AppColors.navy,
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            return Container();
          },
        ));
  }
}
