import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:sync_rescue/core/theme/app_colors.dart';
import 'package:sync_rescue/features/sos_rescue/view_models/rescuer_view_model.dart';

class RescuerPageScreen extends StatefulWidget {
  const RescuerPageScreen({super.key});

  @override
  State<RescuerPageScreen> createState() => _RescuerPageScreenState();
}

class _RescuerPageScreenState extends State<RescuerPageScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RescuerViewModel>().fetchPendingEmergencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final rescuerViewModel = context.watch<RescuerViewModel>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: AppColors.whiteColor),
                ),
                Text(
                  "Rescuer Mode",
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 16),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(20),
                  child: rescuerViewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : FlutterMap(
                          options: const MapOptions(
                            initialCenter: LatLng(28.6139, 77.2090),
                            initialZoom: 12.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.sync_rescue.app',
                            ),
                            MarkerLayer(
                              markers: rescuerViewModel.fetchAllEmergencies.map((
                                emergency,
                              ) {
                                return Marker(
                                  width: 50.0,
                                  height: 50.0,
                                  point: LatLng(
                                    emergency.latitude,
                                    emergency.longitude,
                                  ),

                                  child: GestureDetector(
                                    onTap: () {
                                      if (kDebugMode) {
                                        print(
                                          "Clicked Victim ID: ${emergency.requestId}",
                                        );
                                      }
                                    },
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 45.0,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
