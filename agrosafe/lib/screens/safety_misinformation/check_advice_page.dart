import 'package:flutter/material.dart';

class CheckAdvicePage extends StatefulWidget {
  const CheckAdvicePage({super.key});

  @override
  State<CheckAdvicePage> createState() => _CheckAdvicePageState();
}

class _CheckAdvicePageState extends State<CheckAdvicePage> {
  final _adviceController = TextEditingController();
  String? _verificationResult;
  bool _isAnalyzing = false;

  void _verifyAdvice() {
    if (_adviceController.text.trim().isEmpty) return;

    setState(() {
      _isAnalyzing = true;
      _verificationResult = null;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
          _verificationResult =
              'VERIFIED ACCURATE (MINAGRI Certified)\n\nAdvice: "Waiting for soil moisture before bean planting prevents seed rot." Testing confirmed optimal germination results in Musanze District.';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Check Farming Advice'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFF59E0B),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.volume_up_rounded,
                color: Colors.black87,
                size: 22,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Combat misinformation in our community. Enter any farming techniques or advice you\'ve heard to verify its safety and scientific backing.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF4B5563),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Farming Advice',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: TextField(
                controller: _adviceController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText:
                      'Paste or type the farming advice you want to check.',
                  hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E5620),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: _verifyAdvice,
                icon: const Icon(Icons.verified_outlined, size: 22),
                label: const Text(
                  'Check Now',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 24),

            if (_isAnalyzing)
              const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(color: Color(0xFF1E5620)),
                    SizedBox(height: 12),
                    Text(
                      'Checking MINAGRI & RAB database...',
                      style: TextStyle(color: Color(0xFF4B5563)),
                    ),
                  ],
                ),
              ),

            if (_verificationResult != null)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F9F3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF1E5620),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: Color(0xFF1E5620),
                          size: 28,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Expert Analysis Result',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E5620),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _verificationResult!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF374151),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
