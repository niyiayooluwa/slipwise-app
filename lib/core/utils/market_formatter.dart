extension StringExtension on String {
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ')
        .map(
          (word) => word.isEmpty
              ? ''
              : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }
}

class MarketFormatter {
  static String formatMarket(String marketType, String? marketSpec) {
    // 1. Replace underscores with spaces
    String formatted = marketType.replaceAll('_', ' ');

    // 2. Append the specifier if it exists (e.g., "OVER UNDER 1.5")
    if (marketSpec != null && marketSpec.isNotEmpty) {
      formatted = '$formatted $marketSpec';
    }

    // 3. Make it Title Case
    return formatted.toTitleCase();
  }
}
