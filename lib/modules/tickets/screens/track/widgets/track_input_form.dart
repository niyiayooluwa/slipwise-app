import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TrackInputForm extends StatelessWidget {
  final ShadThemeData theme;
  final ShadColorScheme colorScheme;
  final TextEditingController codeController;

  final String selectedProvider;
  final Function(String?) onProviderSelected;

  const TrackInputForm({
    super.key,
    required this.theme,
    required this.colorScheme,
    required this.codeController,
    required this.selectedProvider,
    required this.onProviderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Betting Provider',
          style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ShadSelect<String>(
          placeholder: const Text('Select a provider'),
          initialValue: selectedProvider,
          onChanged: onProviderSelected,
          options: [
            ShadOption<String>(value: 'SPORTYBET', child: const Text('Sportybet')),
            ShadOption<String>(value: 'BET9JA', child: const Text('Bet9ja (Coming Soon)')),
            ShadOption<String>(value: '1XBET', child: const Text('1xBet (Coming Soon)')),
          ],
          selectedOptionBuilder: (context, value) {
            final text = value == 'SPORTYBET' ? 'Sportybet' : (value == 'BET9JA' ? 'Bet9ja' : '1xBet');
            return Text(text);
          },
        ),
        const SizedBox(height: 12),
        if (selectedProvider != 'SPORTYBET')
          const ShadAlert(
            icon: Icon(LucideIcons.info),
            description: Text('Only Sportybet is fully supported currently.'),
          ),
        
        const SizedBox(height: 24),
        
        Text(
          'Booking Code',
          style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ShadInput(
          controller: codeController,
          placeholder: const Text('e.g., J6J2TN'),
          textCapitalization: TextCapitalization.characters,
          trailing: Icon(LucideIcons.ticket, size: 16, color: colorScheme.mutedForeground),
        ),
        const SizedBox(height: 12),
        Text(
          'Enter the 6-character alphanumeric booking code',
          style: theme.textTheme.small.copyWith(
            color: colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }
}
