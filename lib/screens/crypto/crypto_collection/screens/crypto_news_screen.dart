import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CryptoNewsScreen extends StatefulWidget {
  dynamic cryptoNewsSnapshot;
  CryptoNewsScreen({
    Key? key,
    required this.cryptoNewsSnapshot,
  }) : super(key: key);

  @override
  State<CryptoNewsScreen> createState() => _CryptoNewsScreenState();
}

class _CryptoNewsScreenState extends State<CryptoNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.025),
            FutureBuilder(
                future: widget.cryptoNewsSnapshot,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: Get.height * 0.70,
                      width: Get.width,
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 16,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: AppColors.navy,
                                ),
                                width: Get.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      SizedBox(height: Get.height * 0.01),
                                      Center(
                                        child: Text(
                                          snapshot.data![index]['date']
                                              .toString()
                                              .substring(0, 22),
                                          style: TextStyle(
                                            color: AppColors.green,
                                            fontWeight: FontWeight.w600,
                                            fontSize: Get.width * 0.03,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.025),
                                      Text(
                                        snapshot.data![index]['title'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: Get.width * 0.03,
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.025),
                                      Text(
                                        snapshot.data![index]['description'],
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: Get.width * 0.03,
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.025),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  } else if (snapshot.hasError) {
                    //print(snapshot.error);
                    return const Text('Error');
                  }
                  return Container();
                }),
          ],
        ),
      ),
    );
  }
}
