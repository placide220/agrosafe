import 'package:flutter/material.dart';
import '../../../core/services/audio_service.dart';

class VoiceNavigationModal extends StatefulWidget {
  const VoiceNavigationModal({super.key});

  @override
  State<VoiceNavigationModal> createState() => _VoiceNavigationModalState();
}

class _VoiceNavigationModalState extends State<VoiceNavigationModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  String _statusText = "Listening...";
  String _subStatusText = "Say 'Weather', 'Safety', or 'Cooperative'";

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onSelectCommand(String commandText, String subText) {
    setState(() {
      _statusText = "Processing...";
      _subStatusText = commandText;
    });

    AudioService().speakKinyarwandaPrompt(context: context, text: commandText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E5620),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 24,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        _statusText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _subStatusText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(height: 16),

                      // Glowing Microphone Center Icon
                      AnimatedBuilder(
                        animation: _animController,
                        builder: (context, child) {
                          return Container(
                            padding: EdgeInsets.all(
                              20 + (_animController.value * 10),
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF59E0B).withValues(
                                alpha: 0.2 + (_animController.value * 0.15),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: Color(0xFFF59E0B),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.mic_rounded,
                                size: 54,
                                color: Colors.black87,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      const Spacer(),

                      // Kinyarwanda Speech Box (Amber Gold #F59E0B)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.volume_up_rounded,
                              color: Color(0xFF78350F),
                              size: 24,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ubwumvi bw’ijwi burimo gukora...',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF78350F),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'AgroSafe irimo kumva ijwi ryawe mu Kinyarwanda.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF78350F),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Quick Command Pills Row
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildVoiceChip(
                            "Amakuru y'ikirere",
                            () => _onSelectCommand(
                              "Amakuru y'ikirere",
                              "Weather Forecast",
                            ),
                          ),
                          _buildVoiceChip(
                            "Ubutekamutwe",
                            () =>
                                _onSelectCommand("Ubutekamutwe", "Scam Alerts"),
                          ),
                          _buildVoiceChip(
                            "Koperative yanjye",
                            () => _onSelectCommand(
                              "Koperative yanjye",
                              "My Cooperative",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Stop Listening Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.white70,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () => Navigator.maybePop(context),
                          child: const Text(
                            'Stop Listening',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVoiceChip(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
