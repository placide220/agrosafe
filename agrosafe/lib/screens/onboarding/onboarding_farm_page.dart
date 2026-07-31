import 'package:flutter/material.dart';
import 'onboarding_accessibility_page.dart';

class OnboardingFarmPage extends StatefulWidget {
  final String farmerName;

  const OnboardingFarmPage({super.key, required this.farmerName});

  @override
  State<OnboardingFarmPage> createState() => _OnboardingFarmPageState();
}

class _OnboardingFarmPageState extends State<OnboardingFarmPage> {
  final _districtController = TextEditingController(text: 'Musanze');
  String _selectedCrop = 'Select your primary crop';
  String _selectedCategory = 'Cereals';

  @override
  void dispose() {
    _districtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('AgroSafe'),
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Segmented Progress Bar (3 steps: green, yellow, gray)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E5620),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Hero Landscape Banner Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E5620),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&w=1000&q=80',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'Tell us about your farm.',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 20),

              // District Label
              const Text(
                'District',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _districtController,
                decoration: const InputDecoration(
                  hintText: 'e.g., Musanze',
                  suffixIcon: Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Main Crops Label
              const Text(
                'Main Crops',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                isExpanded: true,
                value: _selectedCrop,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Select your primary crop',
                    child: Text(
                      'Select your primary crop',
                      style: TextStyle(color: Color(0xFF6B7280)),
                    ),
                  ),
                  DropdownMenuItem(value: 'Maize', child: Text('Maize')),
                  DropdownMenuItem(value: 'Beans', child: Text('Beans')),
                  DropdownMenuItem(
                    value: 'Irish Potatoes',
                    child: Text('Irish Potatoes'),
                  ),
                  DropdownMenuItem(value: 'Coffee', child: Text('Coffee')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCrop = val);
                },
              ),
              const SizedBox(height: 24),

              // Crop Category Cards Row
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _selectedCategory = 'Cereals'),
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _selectedCategory == 'Cereals'
                                ? const Color(0xFF1E5620)
                                : const Color(0xFFE5E7EB),
                            width: _selectedCategory == 'Cereals' ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.grass_rounded,
                              size: 32,
                              color: _selectedCategory == 'Cereals'
                                  ? const Color(0xFF1E5620)
                                  : const Color(0xFF4B5563),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Cereals',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _selectedCategory == 'Cereals'
                                    ? const Color(0xFF111827)
                                    : const Color(0xFF4B5563),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _selectedCategory = 'Tree Crops'),
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _selectedCategory == 'Tree Crops'
                                ? const Color(0xFF1E5620)
                                : const Color(0xFFE5E7EB),
                            width: _selectedCategory == 'Tree Crops' ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.park_outlined,
                              size: 32,
                              color: _selectedCategory == 'Tree Crops'
                                  ? const Color(0xFF1E5620)
                                  : const Color(0xFF4B5563),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tree Crops',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _selectedCategory == 'Tree Crops'
                                    ? const Color(0xFF111827)
                                    : const Color(0xFF4B5563),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Next Step Button
              SizedBox(
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E5620),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => OnboardingAccessibilityPage(
                          farmerName: widget.farmerName,
                          district: _districtController.text.trim(),
                        ),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next Step',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 22),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Step 2 of 3',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
