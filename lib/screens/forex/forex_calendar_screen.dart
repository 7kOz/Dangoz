import 'dart:convert';

import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/models/econimoc_calendar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ForexCalendarScreen extends StatefulWidget {
  const ForexCalendarScreen({Key? key}) : super(key: key);

  @override
  State<ForexCalendarScreen> createState() => _ForexCalendarScreenState();
}

class _ForexCalendarScreenState extends State<ForexCalendarScreen> {
  late Future<dynamic> uniqueDates;
  bool showImp = false;

  @override
  void initState() {
    super.initState();
    uniqueDates = getUniqueDates();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 0.7,
        width: Get.width,
        color: AppColors.white,
        child: FutureBuilder(
          future: getEconomicCalendar(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.02),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          height: Get.height * 0.05,
                          width: Get.width * 0.5,
                          color: AppColors.navy,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  bottomLeft: Radius.circular(24),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showImp = false;
                                    });
                                  },
                                  splashColor: Colors.transparent,
                                  splashFactory: NoSplash.splashFactory,
                                  child: Container(
                                    height: Get.height * 0.05,
                                    width: Get.width * 0.25,
                                    color: showImp == false
                                        ? AppColors.green
                                        : AppColors.navy,
                                    child: Center(
                                        child: Text(
                                      'All',
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: Get.width * 0.04),
                                    )),
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  bottomRight: Radius.circular(24),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showImp = true;
                                    });
                                  },
                                  splashColor: Colors.transparent,
                                  splashFactory: NoSplash.splashFactory,
                                  child: Container(
                                    height: Get.height * 0.05,
                                    width: Get.width * 0.25,
                                    color: showImp == true
                                        ? AppColors.green
                                        : AppColors.navy,
                                    child: Center(
                                        child: Text(
                                      'Important',
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: Get.width * 0.04),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    date1(snapshot, uniqueDates),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return const Text('Error');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Widget date1(AsyncSnapshot snapshot, Future uniqueDates) {
  return Container(
    height: Get.height,
    width: Get.width,
    child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) {
        String date = snapshot.data!['result'][index]['date'].toString() ?? '';
        return FutureBuilder(
          future: uniqueDates,
          builder: (context, snapshots) {
            return Column(
              children: [
                Container(
                  height: Get.height * 0.05,
                  width: Get.width,
                  color: AppColors.green,
                  child: Center(
                    child:
                        Text((snapshots.data! as List<dynamic>)[0].toString()),
                  ),
                ),
                (snapshots.data! as List<dynamic>)[0].toString() ==
                        date.substring(0, 10)
                    ? Container(
                        height: Get.height,
                        child: ListView.builder(
                            itemCount: date.length,
                            itemBuilder: (context, i) {
                              String uniqueTitle = snapshot.data!['result'][i]
                                          ['title']
                                      .toString() ??
                                  '';
                              String uniqueCountry = snapshot.data!['result'][i]
                                          ['country']
                                      .toString() ??
                                  '';
                              String uniqueIndicator = snapshot.data!['result']
                                          [i]['indicator']
                                      .toString() ??
                                  '';
                              String uniqueTicker = snapshot.data!['result'][i]
                                          ['ticker']
                                      .toString() ??
                                  '';
                              String uniqueComment = snapshot.data!['result'][i]
                                          ['comment']
                                      .toString() ??
                                  '';
                              String uniquePeriod = snapshot.data!['result'][i]
                                          ['period']
                                      .toString() ??
                                  '';
                              String uniqueSource = snapshot.data!['result'][i]
                                          ['source']
                                      .toString() ??
                                  '';
                              String uniqueActual = snapshot.data!['result'][i]
                                          ['actual']
                                      .toString() ??
                                  '';
                              String uniquePrevious = snapshot.data!['result']
                                          [i]['previous']
                                      .toString() ??
                                  '';
                              String uniqueForecast = snapshot.data!['result']
                                          [i]['forecast']
                                      .toString() ??
                                  '';
                              String uniqueCurrency = snapshot.data!['result']
                                          [i]['currency']
                                      .toString() ??
                                  '';
                              String uniqueImportance = snapshot.data!['result']
                                          [i]['importance']
                                      .toString() ??
                                  '';
                              String uniqueDate = snapshot.data!['result'][i]
                                          ['date']
                                      .toString() ??
                                  '';

                              return Container(
                                color: uniqueImportance == '1'
                                    ? AppColors.red.withOpacity(0.1)
                                    : Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: Get.height * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            uniqueCurrency,
                                            style: TextStyle(
                                                color: AppColors.green),
                                          ),
                                          Text(
                                            DateTime.parse(uniqueDate)
                                                .toString()
                                                .substring(0, 16),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'Previous',
                                                style: TextStyle(
                                                    color: AppColors.red),
                                              ),
                                              Text(
                                                uniquePrevious == 'null'
                                                    ? '-'
                                                    : uniquePrevious,
                                                style: TextStyle(
                                                    color: AppColors.red),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Forecast',
                                                style: TextStyle(
                                                    color: AppColors.navy),
                                              ),
                                              Text(
                                                uniqueForecast == 'null'
                                                    ? '-'
                                                    : uniqueForecast,
                                                style: TextStyle(
                                                    color: AppColors.navy),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text(
                                                'Actual',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              Text(
                                                uniqueActual == 'null'
                                                    ? '-'
                                                    : uniqueActual,
                                                style: const TextStyle(
                                                    color: Colors.blue),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height * 0.01),
                                      Text(uniqueTitle),
                                      SizedBox(height: Get.height * 0.01),
                                      Text(uniqueComment),
                                      SizedBox(height: Get.height * 0.01),
                                      Divider(
                                        color: AppColors.lightGrey,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    : Container(),
              ],
            );
          },
        );
      },
    ),
  );
}

getUniqueDates() async {
  List dates = [];
  dynamic results = await getEconomicCalendar();
  int resultsCount = results['result'].length;
  for (int i = 0; i < resultsCount; i++) {
    dates.add(results['result'][i]['date'].toString().substring(0, 10));
  }
  dates = dates.toSet().toList();
  print(dates);
  return dates;
}

Future getEconomicCalendar() async {
  final queryParameters = {
    'from': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'to': DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(const Duration(days: 14))),
    'countries': 'US,EU,JP,AU,DE,GB,CA,FR,IT,NZ,ES,MX,CH,TR,ZA',
    'lang': 'en'
  };

  final uri = Uri.https('www.trading-view.p.rapidapi.com',
      '/calendars/get-economic-calendar', queryParameters);
  final response = await http.get(uri, headers: {
    'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
    'X-RapidAPI-Host': 'trading-view.p.rapidapi.com'
  });

  if (response.statusCode == 200) {
    //print(response.body);
    print('done');
    return jsonDecode(response.body);
  } else {
    print('not done');
    throw Exception('Failed to load');
  }
}
