import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/viewmodel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final viewModel = Get.put(ViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                child: Stack(
                  children: [
                    if (viewModel.loading.value)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (!viewModel.loading.value &&
                        viewModel.contentData.value.message != null)
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  viewModel.contentData.value.message!,
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                  ],
                ),
              );
            }),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      splashColor: Colors.black.withOpacity(0.4),
                      onTap: () {
                        // Get.rawSnackbar(
                        //   borderRadius: 1,
                        //   snackPosition: SnackPosition.TOP,
                        //   snackStyle: SnackStyle.FLOATING,
                        //   animationDuration: const Duration(milliseconds: 300),
                        //   forwardAnimationCurve: Curves.elasticIn,
                        //   reverseAnimationCurve: Curves.elasticIn,
                        //   isDismissible: true,
                        //   dismissDirection: DismissDirection.horizontal,
                        //
                        //   // title,
                        //   message: "Data is fetched",
                        //   // icon: const Icon(Icons.info),
                        //   // titleText: Text(
                        //   //   title,
                        //   //   style: Get.textTheme.titleMedium!
                        //   //       .copyWith(color: Get.theme.colorScheme.onPrimary),
                        //   // ),
                        //   duration: const Duration(seconds: 2),
                        //   // mainButton: TextButton.icon(
                        //   //   onPressed: () => Get.back(),
                        //   //   icon: const Icon(
                        //   //     Icons.cancel,
                        //   //     color: SColors.white,
                        //   //   ),
                        //   //   label: const Text(''),
                        //   // ),
                        //   messageText: Text(
                        //     "Data is fetched",
                        //     maxLines: 4,
                        //     style: Get.textTheme.bodyMedium!
                        //         .copyWith(color: Get.theme.colorScheme.onPrimary),
                        //   ),
                        //   // borderRadius: 12,
                        //   // borderWidth: 2,
                        //   borderColor: Colors.red.withOpacity(0.8),
                        //   barBlur: 1,
                        //   // snackStyle: SnackStyle.GROUNDED,
                        //   // overlayColor: SColors.white,
                        //   // colorText: SColors.white,
                        //   // snackPosition: SnackPosition.BOTTOM,
                        //   backgroundColor: Colors.blue,
                        // );
                        viewModel.fetchAlbum();
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8.0),
                          child: const Text(
                            "Change Image",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                ),
              ],
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
