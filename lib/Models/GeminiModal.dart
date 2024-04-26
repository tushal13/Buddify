class GeminiModal {
  String content;

  GeminiModal({required this.content});

  factory GeminiModal.fromMap(Map gemini) {
    return GeminiModal(content: gemini['text']);
  }
}
