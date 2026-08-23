import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TrackStepIndicator extends StatelessWidget {
  final int currentStep;
  final ShadColorScheme colorScheme;

  const TrackStepIndicator({
    super.key,
    required this.currentStep,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStep(1, 'Enter Code', currentStep >= 1, colorScheme),
        Expanded(
          child: Container(
            height: 2,
            color: currentStep >= 2 ? colorScheme.primary : colorScheme.muted,
          ),
        ),
        _buildStep(2, 'Preview & Track', currentStep >= 2, colorScheme),
      ],
    );
  }

  Widget _buildStep(
    int step,
    String label,
    bool isActive,
    ShadColorScheme colorScheme,
  ) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? colorScheme.primary : colorScheme.muted,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                color: isActive ? Colors.white : colorScheme.mutedForeground,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive
                ? colorScheme.foreground
                : colorScheme.mutedForeground,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
