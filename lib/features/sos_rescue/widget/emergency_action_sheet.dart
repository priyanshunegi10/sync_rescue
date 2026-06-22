import 'package:flutter/material.dart';
import 'package:sync_rescue/core/theme/app_colors.dart';
import 'package:sync_rescue/features/sos_rescue/view_models/rescuer_view_model.dart';

class EmergencyActionSheet extends StatelessWidget {
  final dynamic emergency;
  final RescuerViewModel viewModel;

  const EmergencyActionSheet({
    super.key,
    required this.emergency,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      height: 250,
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Emergency Type: ${emergency.emergencyType}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Status: PENDING",
            style: TextStyle(color: Colors.redAccent, fontSize: 16),
          ),
          const Spacer(),

          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () async {
                bool success = await viewModel.acceptRequest(
                  emergency.requestId,
                );

                if (context.mounted) Navigator.pop(context);

                if (success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Rescue Accepted! Locking coordinates..."),
                    ),
                  );
                } else if (!success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(viewModel.errorMessage)),
                  );
                }
              },
              child: viewModel.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "ACCEPT RESCUE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
