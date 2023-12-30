class ProfanityCheckResponse {
  late final String originalText;
  late final String censoredText;
  late final bool hasProfanity;

  ProfanityCheckResponse({
    required this.originalText,
    required this.censoredText,
    required this.hasProfanity,
  });

  factory ProfanityCheckResponse.fromJson(Map<String, dynamic> json) {
    return ProfanityCheckResponse(
      originalText: json['original'] ?? '',
      censoredText: json['censored'] ?? '',
      hasProfanity: json['has_profanity'] ?? false,
    );
  }
}
