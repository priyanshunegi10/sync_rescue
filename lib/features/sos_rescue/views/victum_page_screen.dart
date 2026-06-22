import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:sync_rescue/core/theme/app_colors.dart';
import 'package:sync_rescue/core/widgets/custom_home_screen_components.dart';
import 'package:sync_rescue/features/sos_rescue/view_models/sos_view_model.dart';
import 'package:sync_rescue/features/sos_rescue/views/rescuer_page_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SosViewModel>().stateRecover();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sosViewModel = context.watch<SosViewModel>();
    if (sosViewModel.errorMessage == "You have been marked as rescued!") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("🚀 Mission Accomplished! You are safe now."),
            backgroundColor: Colors.green,
          ),
        );
      });
    }
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: const DecoratedBox(
                decoration: BoxDecoration(color: AppColors.backgroundColor),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                              right: 30,
                              top: 30,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              height: 500,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.lightWhite),
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.lightblue,
                                    AppColors.darkblue,
                                  ],
                                  begin: AlignmentGeometry.topCenter,
                                  end: AlignmentGeometry.bottomCenter,
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    "Emergency",
                                    style: TextStyle(
                                      color: AppColors.lightWhite,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 20),

                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    height: 300,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),

                                    child: sosViewModel.isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.redColor,
                                              strokeWidth: 5,
                                            ),
                                          )
                                        : sosViewModel.currentSosRequest != null
                                        ? GestureDetector(
                                            onTap: () async {
                                              bool success = await context
                                                  .read<SosViewModel>()
                                                  .cancelActiveSos(
                                                    sosViewModel
                                                        .currentSosRequest!
                                                        .requestId,
                                                  );

                                              if (!success && context.mounted) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      context
                                                          .read<SosViewModel>()
                                                          .errorMessage,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(15),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade800,
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "CANCEL\nSOS",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 40,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () async {
                                              bool success = await context
                                                  .read<SosViewModel>()
                                                  .triggerSos('General');

                                              if (!success && context.mounted) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      context
                                                          .read<SosViewModel>()
                                                          .errorMessage,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(20),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "SOS",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 70,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),

                                  SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RescuerPageScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 70,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Rescuer Mode",
                                          style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 20,
                        bottom: 20,
                      ),
                      width: double.infinity,
                      height: sosViewModel.currentSosRequest != null
                          ? 350
                          : null,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.lightblue, AppColors.darkblue],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: sosViewModel.currentSosRequest != null
                          ? sosViewModel.currentPosition == null
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: FlutterMap(
                                      options: MapOptions(
                                        initialCenter: LatLng(
                                          sosViewModel
                                              .currentPosition!
                                              .latitude,
                                          sosViewModel
                                              .currentPosition!
                                              .longitude,
                                        ),
                                        initialZoom: 15.0,
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          userAgentPackageName:
                                              'com.sync_rescue.app',
                                        ),
                                        MarkerLayer(
                                          markers: [
                                            Marker(
                                              width: 40.0,
                                              height: 40.0,
                                              point: LatLng(
                                                sosViewModel
                                                    .currentPosition!
                                                    .latitude,
                                                sosViewModel
                                                    .currentPosition!
                                                    .longitude,
                                              ),
                                              child: const Icon(
                                                Icons.my_location,
                                                color: Colors.red,
                                                size: 35.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                          : SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomHomeScreenComponents(
                                    title: "My device",
                                    fisrt: Icons.phone,
                                    second: Icons.arrow_forward_ios_rounded,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomHomeScreenComponents(
                                    title: "Maps",
                                    fisrt: Icons.map_rounded,
                                    second: Icons.arrow_forward_ios_rounded,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
