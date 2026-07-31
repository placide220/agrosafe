import 'package:flutter/material.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  Future<void> speakKinyarwandaPrompt({
    required BuildContext context,
    required String text,
    VoidCallback? onComplete,
  }) async {
    _isPlaying = true;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.graphic_eq_rounded, color: Colors.white, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ijwi ririmo kuvuga (Kinyarwanda Voice Output)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color(0xFF81C784),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1E5620),
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    await Future.delayed(const Duration(seconds: 4));
    _isPlaying = false;
    if (onComplete != null) onComplete();
  }
}
