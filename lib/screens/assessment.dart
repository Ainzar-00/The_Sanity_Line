import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/profile_api_service.dart';
import '../api/mental_condition_api_service.dart';
import '../models/profile_model.dart';
import '../models/mental_condition_model.dart';
import '../widgets/character_chat_bubble.dart';

// ─── Data & State ────────────────────────────────────────────────────────────

class AssessmentData {
  // Section 1
  String age = '';
  String sex = '';
  String weight = '';

  // Section 2
  int mood = 0;
  int stress = 0;

  // Section 3
  Set<String> digestiveConditions = {};
  String digestiveOther = '';
  List<String> customDigestiveConditions = [];
  Set<String> foodSensitivities = {};
  String sensitivityOther = '';
  List<String> customSensitivities = [];
  String plantDiversity = '';
  String fermentedServings = '';

  // Section 4
  String sleep = '';
  String caffeine = '';
  String alcohol = '';

  // Section 5
  Set<String> mentalConditions = {};
  String mentalOther = '';
  List<String> customMentalConditions = [];
}

// ─── Main Screen ─────────────────────────────────────────────────────────────

class AssessmentScreen extends StatefulWidget {
  final String userId;
  const AssessmentScreen({super.key, required this.userId});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen>
    with TickerProviderStateMixin {
  int _currentStep = 0;
  bool _completed = false;
  bool _isSubmitting = false;
  bool _professorShown = false;
  final _data = AssessmentData();
  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  // ── Persistent text controllers (survive setState rebuilds) ───────────────
  late final TextEditingController _ageCtrl;
  late final TextEditingController _weightCtrl;
  late final TextEditingController _plantCtrl;
  late final TextEditingController _fermentedCtrl;
  late final TextEditingController _sleepCtrl;
  late final TextEditingController _caffeineCtrl;
  late final TextEditingController _alcoholCtrl;
  late final TextEditingController _digestiveOtherCtrl;
  late final TextEditingController _sensitivityOtherCtrl;
  late final TextEditingController _mentalOtherCtrl;

  static const _teal900 = Color(0xFF0d3d3d);
  static const _teal700 = Color(0xFF1a5f5f);
  static const _teal500 = Color(0xFF2a8a8a);
  static const _teal300 = Color(0xFF4aabab);
  static const _teal100 = Color(0xFFe0f2f2);
  static const _tealBorder = Color(0xFFb2d8d8);
  static const _tealMuted = Color(0xFF5a8a8a);
  static const _bg = Color(0xFFf7fafa);

  final _titles = [
    'Personal biometrics',
    'Wellbeing indicators',
    'Digestive health & diet',
    'Lifestyle factors',
    'Mental health',
  ];
  final _subs = [
    'Step 1 of 5 — Basic health information',
    'Step 2 of 5 — Mood & stress',
    'Step 3 of 5 — Digestion & nutrition',
    'Step 4 of 5 — Sleep & habits',
    'Step 5 of 5 — Mental health conditions',
  ];

  @override
  void initState() {
    super.initState();

    // ── Text controllers with listeners ─────────────────────────────────────
    _ageCtrl = TextEditingController()..addListener(() => _data.age = _ageCtrl.text);
    _weightCtrl = TextEditingController()..addListener(() => _data.weight = _weightCtrl.text);
    _plantCtrl = TextEditingController()..addListener(() => _data.plantDiversity = _plantCtrl.text);
    _fermentedCtrl = TextEditingController()..addListener(() => _data.fermentedServings = _fermentedCtrl.text);
    _sleepCtrl = TextEditingController()..addListener(() => _data.sleep = _sleepCtrl.text);
    _caffeineCtrl = TextEditingController()..addListener(() => _data.caffeine = _caffeineCtrl.text);
    _alcoholCtrl = TextEditingController()..addListener(() => _data.alcohol = _alcoholCtrl.text);
    _digestiveOtherCtrl = TextEditingController()..addListener(() => _data.digestiveOther = _digestiveOtherCtrl.text);
    _sensitivityOtherCtrl = TextEditingController()..addListener(() => _data.sensitivityOther = _sensitivityOtherCtrl.text);
    _mentalOtherCtrl = TextEditingController()..addListener(() => _data.mentalOther = _mentalOtherCtrl.text);

    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeInOut);
    _fadeCtrl.forward();
    // Show professor assessment bubble once on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showProfessorAssessmentBubble();
    });
  }

  @override
  void dispose() {
    _ageCtrl.dispose();
    _weightCtrl.dispose();
    _plantCtrl.dispose();
    _fermentedCtrl.dispose();
    _sleepCtrl.dispose();
    _caffeineCtrl.dispose();
    _alcoholCtrl.dispose();
    _digestiveOtherCtrl.dispose();
    _sensitivityOtherCtrl.dispose();
    _mentalOtherCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  void _showProfessorAssessmentBubble() {
    if (!mounted || _professorShown) return;
    _professorShown = true;
    CharacterChatBubble.show(
      context: context,
      characterName: 'THE PROFESSOR',
      steps: const [
        // Step 1 — Self-introduction
        ChatStep(
          imagePath: 'assets/chatPersonas/professorWaving.png',
          text:
              "Hello! I'm the Professor — your personal guide through the science of well-being. 👋\n\nI'll be with you every step of the way on this journey.",
        ),
        // Step 2 — Small app teaser (full intro will continue on home screen)
        ChatStep(
          imagePath: 'assets/chatPersonas/professorExplaining.png',
          text:
              "The Sanity Line is your companion for a healthier, more balanced life. There's a lot to discover together — but before we dive in, I need to learn a little about you first. 🔍",
        ),
        // Step 3 — Transition into assessment
        ChatStep(
          imagePath: 'assets/chatPersonas/professorAssesments.png',
          text:
              "Let's start with a quick health assessment! 📋\n\nAnswer as honestly as you can — there are no wrong answers. The more I know about you, the more personalised your experience will be. Let's go! 💪",
        ),
      ],
    );
  }

  void _goTo(int n) async {
    await _fadeCtrl.reverse();
    setState(() => _currentStep = n);
    _fadeCtrl.forward();
  }

  void _next() {
    if (_currentStep < 4) {
      _goTo(_currentStep + 1);
    } else {
      _submit();
    }
  }

  void _prev() {
    if (_currentStep > 0) _goTo(_currentStep - 1);
  }

  void _submit() async {
    setState(() => _isSubmitting = true);

    // Mark done locally first — ensures assessment never shows again even if
    // the API call below fails.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done_${widget.userId}', true);

    final profile = _buildProfile();
    final saved = await ProfileApiService.upsertProfile(profile);
    if (saved != null) {
      // Save mental conditions
      final conditionsToSave = <String>{};
      conditionsToSave.addAll(_data.mentalConditions);
      conditionsToSave.addAll(_data.customMentalConditions);
      if (_data.mentalOther.trim().isNotEmpty) {
        conditionsToSave.add(_data.mentalOther.trim());
      }
      for (final cond in conditionsToSave) {
        final mentalModel = MentalConditionModel(
          userId: widget.userId,
          conditionName: cond,
        );
        await MentalConditionApiService.saveCondition(mentalModel);
      }

      await ProfileApiService.markOnboardingComplete(widget.userId);
    }
    if (!mounted) return;
    setState(() => _isSubmitting = false);
    if (saved == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save your responses. Please try again.'),
        ),
      );
      return;
    }
    await _fadeCtrl.reverse();
    setState(() => _completed = true);
    _fadeCtrl.forward();
  }

  void _skipAll() async {
    setState(() => _isSubmitting = true);

    // Mark done locally first.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done_${widget.userId}', true);

    final profile = _buildProfile();
    await ProfileApiService.upsertProfile(profile);

    // Save mental conditions
    final conditionsToSave = <String>{};
    conditionsToSave.addAll(_data.mentalConditions);
    conditionsToSave.addAll(_data.customMentalConditions);
    if (_data.mentalOther.trim().isNotEmpty) {
      conditionsToSave.add(_data.mentalOther.trim());
    }
    for (final cond in conditionsToSave) {
      final mentalModel = MentalConditionModel(
        userId: widget.userId,
        conditionName: cond,
      );
      await MentalConditionApiService.saveCondition(mentalModel);
    }

    await ProfileApiService.markOnboardingComplete(widget.userId);
    if (!mounted) return;
    setState(() => _isSubmitting = false);
    await _fadeCtrl.reverse();
    setState(() => _completed = true);
    _fadeCtrl.forward();
  }

  ProfileModel _buildProfile() {
    return ProfileModel(
      userId: widget.userId,
      age: int.tryParse(_data.age),
      sex: _data.sex.isEmpty ? null : _data.sex,
      weightKg: double.tryParse(_data.weight),
      baselineMood: _data.mood > 0 ? _data.mood : null,
      stressLevel: _data.stress > 0 ? _data.stress : null,
      digestiveConditions: () {
        final list = _data.digestiveConditions.toList();
        list.addAll(_data.customDigestiveConditions);
        if (_data.digestiveOther.trim().isNotEmpty) {
          list.add(_data.digestiveOther.trim());
        }
        return list.isEmpty ? null : list.toSet().toList();
      }(),
      foodSensitivities: () {
        final list = _data.foodSensitivities.toList();
        list.addAll(_data.customSensitivities);
        if (_data.sensitivityOther.trim().isNotEmpty) {
          list.add(_data.sensitivityOther.trim());
        }
        return list.isEmpty ? null : list.toSet().toList();
      }(),
      initialPlantDiversity: int.tryParse(_data.plantDiversity),
      initialFermentedServings: double.tryParse(_data.fermentedServings),
      avgSleepHours: double.tryParse(_data.sleep),
      caffeineDailyMg: int.tryParse(_data.caffeine),
      alcoholWeeklyUnits: double.tryParse(_data.alcohol),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _teal900,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Stack(
              children: [
                Column(
                  children: [
                    _buildHeader(),
                    Expanded(
                      child: Container(
                        color: _bg,
                        child: FadeTransition(
                          opacity: _fadeAnim,
                          child: _completed
                              ? _buildDoneScreen()
                              : _buildStepBody(),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_isSubmitting)
                  Container(
                    color: Colors.black.withOpacity(0.35),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF4aabab),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      color: _teal900,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge
          Text(
            'HEALTH & WELLNESS ASSESSMENT',
            style: TextStyle(
              fontSize: 10,
              color: _teal300,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          // Title
          Text(
            _completed ? 'Assessment complete' : _titles[_currentStep],
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          // Subtitle
          Text(
            _completed ? 'All sections submitted' : _subs[_currentStep],
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withOpacity(0.45),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          // Step dots + skip all
          Row(
            children: [
              ...[0, 1, 2, 3, 4].map((i) => _buildDot(i)),
              const Spacer(),
              if (!_completed)
                GestureDetector(
                  onTap: _skipAll,
                  child: Text(
                    'Skip all',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.35),
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white.withOpacity(0.35),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int i) {
    final isActive = i == _currentStep && !_completed;
    final isDone = i < _currentStep || _completed;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isActive ? 22 : 7,
      height: 7,
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isActive
            ? _teal300
            : isDone
            ? _teal300.withOpacity(0.5)
            : Colors.white.withOpacity(0.2),
      ),
    );
  }

  // ── Step Body ─────────────────────────────────────────────────────────────

  Widget _buildStepBody() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: _buildStep(_currentStep),
          ),
        ),
        _buildNav(),
      ],
    );
  }

  Widget _buildStep(int step) {
    switch (step) {
      case 0:
        return _buildStep1();
      case 1:
        return _buildStep2();
      case 2:
        return _buildStep3();
      case 3:
        return _buildStep4();
      case 4:
        return _buildStep5();
      default:
        return const SizedBox();
    }
  }

  // ── Section 1 ─────────────────────────────────────────────────────────────

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Section 1 of 5'),
        _stepTitle('Personal biometrics'),
        _stepDesc(
          'Basic physical information to personalise your wellness plan.',
        ),
        const SizedBox(height: 20),
        _fieldGroup(
          number: '1',
          label: 'Age',
          hint: 'Years',
          child: _textInput(
            controller: _ageCtrl,
            placeholder: 'Enter your age',
            keyboardType: TextInputType.number,
          ),
        ),
        _fieldGroup(
          number: '2',
          label: 'Sex',
          child: _dropdownInput(
            items: ['male', 'female'],
            value: _data.sex.isEmpty ? null : _data.sex,
            onChanged: (v) => setState(() => _data.sex = v ?? ''),
          ),
        ),
        _fieldGroup(
          number: '3',
          label: 'Weight',
          hint: 'Kilograms',
          child: _textInput(
            controller: _weightCtrl,
            placeholder: 'e.g. 70.5',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // ── Section 2 ─────────────────────────────────────────────────────────────

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Section 2 of 5'),
        _stepTitle('Wellbeing indicators'),
        _stepDesc('How you feel day-to-day, mentally and emotionally.'),
        const SizedBox(height: 20),
        _fieldLabel(number: '4', label: 'Baseline mood'),
        const SizedBox(height: 4),
        Text(
          'Rate your overall mood.',
          style: TextStyle(fontSize: 11, color: _tealMuted),
        ),
        const SizedBox(height: 10),
        _starRating(
          value: _data.mood,
          onChanged: (v) => setState(() => _data.mood = v),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '1 — Very low',
              style: TextStyle(fontSize: 10, color: const Color(0xFF9ab8b8)),
            ),
            Text(
              '5 — Excellent',
              style: TextStyle(fontSize: 10, color: const Color(0xFF9ab8b8)),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _fieldLabel(number: '10', label: 'Stress level'),
        const SizedBox(height: 4),
        Text(
          'Rate your current stress level.',
          style: TextStyle(fontSize: 11, color: _tealMuted),
        ),
        const SizedBox(height: 10),
        _scaleSelector(
          value: _data.stress,
          onChanged: (v) => setState(() => _data.stress = v),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Very low',
              style: TextStyle(fontSize: 10, color: const Color(0xFF9ab8b8)),
            ),
            Text(
              'Very high',
              style: TextStyle(fontSize: 10, color: const Color(0xFF9ab8b8)),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // ── Section 3 ─────────────────────────────────────────────────────────────

  Widget _buildStep3() {
    const digestiveOptions = [
      'None',
      'IBS',
      'Bloating',
      'Acid Reflux / GERD',
      'Constipation',
      'Diarrhea',
    ];
    const sensitivityOptions = [
      'None',
      'Gluten',
      'Dairy',
      'Soy',
      'Nuts',
      'Eggs',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Section 3 of 5'),
        _stepTitle('Digestive health & diet'),
        _stepDesc(
          'Your digestive conditions, food sensitivities, and dietary habits.',
        ),
        const SizedBox(height: 20),
        _fieldLabel(number: '5', label: 'Digestive conditions'),
        const SizedBox(height: 4),
        Text(
          'Select all that apply.',
          style: TextStyle(fontSize: 11, color: _tealMuted),
        ),
        const SizedBox(height: 8),
        _checkboxList(
          options: digestiveOptions,
          selected: _data.digestiveConditions,
          onToggle: (v) => setState(() {
            if (_data.digestiveConditions.contains(v)) {
              _data.digestiveConditions.remove(v);
            } else {
              _data.digestiveConditions.add(v);
            }
          }),
        ),
        // "Other" text input for digestive conditions
        _otherTextInput(
          controller: _digestiveOtherCtrl,
          placeholder: 'Describe other condition...',
          customItems: _data.customDigestiveConditions,
          onAdd: () {
            final text = _digestiveOtherCtrl.text.trim();
            if (text.isNotEmpty && !_data.customDigestiveConditions.contains(text)) {
              setState(() {
                _data.customDigestiveConditions.add(text);
                _digestiveOtherCtrl.clear();
              });
            }
          },
          onDelete: (item) => setState(() => _data.customDigestiveConditions.remove(item)),
        ),
        const SizedBox(height: 20),
        _fieldLabel(number: '6', label: 'Food sensitivities'),
        const SizedBox(height: 4),
        Text(
          'Select all that apply.',
          style: TextStyle(fontSize: 11, color: _tealMuted),
        ),
        const SizedBox(height: 8),
        _checkboxList(
          options: sensitivityOptions,
          selected: _data.foodSensitivities,
          onToggle: (v) => setState(() {
            if (_data.foodSensitivities.contains(v)) {
              _data.foodSensitivities.remove(v);
            } else {
              _data.foodSensitivities.add(v);
            }
          }),
        ),
        // "Other" text input for food sensitivities
        _otherTextInput(
          controller: _sensitivityOtherCtrl,
          placeholder: 'Describe other sensitivity...',
          customItems: _data.customSensitivities,
          onAdd: () {
            final text = _sensitivityOtherCtrl.text.trim();
            if (text.isNotEmpty && !_data.customSensitivities.contains(text)) {
              setState(() {
                _data.customSensitivities.add(text);
                _sensitivityOtherCtrl.clear();
              });
            }
          },
          onDelete: (item) => setState(() => _data.customSensitivities.remove(item)),
        ),
        const SizedBox(height: 20),
        _fieldGroup(
          number: '7',
          label: 'Plant diversity',
          hint: 'Different plant foods per week',
          child: _textInput(
            controller: _plantCtrl,
            placeholder: 'e.g. 15',
            keyboardType: TextInputType.number,
          ),
        ),
        _fieldGroup(
          number: '8',
          label: 'Fermented servings',
          hint: 'Average servings per day',
          child: _textInput(
            controller: _fermentedCtrl,
            placeholder: 'e.g. 0.5',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // ── Section 4 ─────────────────────────────────────────────────────────────

  Widget _buildStep4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Section 4 of 5'),
        _stepTitle('Lifestyle factors'),
        _stepDesc(
          'Sleep, caffeine, and alcohol habits that shape your overall health.',
        ),
        const SizedBox(height: 20),
        _fieldGroup(
          number: '9',
          label: 'Average sleep',
          hint: 'Hours per night',
          child: _textInput(
            controller: _sleepCtrl,
            placeholder: 'e.g. 7.5',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        _fieldGroup(
          number: '11',
          label: 'Caffeine intake',
          hint: 'Milligrams (mg) per day',
          child: _textInput(
            controller: _caffeineCtrl,
            placeholder: 'e.g. 200',
            keyboardType: TextInputType.number,
          ),
        ),
        _fieldGroup(
          number: '12',
          label: 'Alcohol consumption',
          hint: 'Units per week',
          child: _textInput(
            controller: _alcoholCtrl,
            placeholder: 'e.g. 3',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // ── Section 5 ─────────────────────────────────────────────────────────────

  Widget _buildStep5() {
    const mentalOptions = [
      'anxiety',
      'depression',
      'brain_fog',
      'stress',
      'ibs'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Section 5 of 5'),
        _stepTitle('Mental health conditions'),
        _stepDesc(
          'Any mental conditions we should know about? Select all that apply.',
        ),
        const SizedBox(height: 20),
        _checkboxList(
          options: mentalOptions,
          selected: _data.mentalConditions,
          onToggle: (v) => setState(() {
            if (_data.mentalConditions.contains(v)) {
              _data.mentalConditions.remove(v);
            } else {
              _data.mentalConditions.add(v);
            }
          }),
        ),
        _otherTextInput(
          controller: _mentalOtherCtrl,
          placeholder: 'Describe other condition...',
          customItems: _data.customMentalConditions,
          onAdd: () {
            final text = _mentalOtherCtrl.text.trim();
            if (text.isNotEmpty && !_data.customMentalConditions.contains(text)) {
              setState(() {
                _data.customMentalConditions.add(text);
                _mentalOtherCtrl.clear();
              });
            }
          },
          onDelete: (item) => setState(() => _data.customMentalConditions.remove(item)),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // ── Done Screen ───────────────────────────────────────────────────────────

  Widget _buildDoneScreen() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: _teal100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: _teal500, size: 32),
          ),
          const SizedBox(height: 24),
          const Text(
            'Assessment complete',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: _teal900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Thank you. Your responses have been recorded. We'll use this information to tailor your personalised wellness journey.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: _tealMuted, height: 1.6),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/home',
                  arguments: widget.userId,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _teal500,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Start Your Journey',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Navigation ────────────────────────────────────────────────────────────

  Widget _buildNav() {
    final isLast = _currentStep == 4;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
      decoration: BoxDecoration(
        color: _bg,
        border: Border(top: BorderSide(color: const Color(0xFFcce6e6))),
      ),
      child: Row(
        children: [
          if (_currentStep > 0) _navIconBtn(Icons.chevron_left, _prev),
          if (_currentStep > 0) const SizedBox(width: 8),
          _navTextBtn('Skip section', _next),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: isLast ? _submit : _next,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLast ? _teal900 : _teal500,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isLast ? 'Submit ✓' : 'Next →',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navIconBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(color: _tealBorder),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Icon(icon, color: _tealMuted, size: 20),
      ),
    );
  }

  Widget _navTextBtn(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: _tealBorder),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, color: _tealMuted),
        ),
      ),
    );
  }

  // ── Shared UI Primitives ──────────────────────────────────────────────────

  Widget _sectionLabel(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 10,
      color: _teal500,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.4,
    ),
  );

  Widget _stepTitle(String text) => Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        color: _teal900,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _stepDesc(String text) => Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Text(
      text,
      style: TextStyle(fontSize: 12, color: _tealMuted, height: 1.5),
    ),
  );

  Widget _fieldLabel({required String number, required String label}) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: const BoxDecoration(
            color: _teal100,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: _teal700,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: _teal700,
            letterSpacing: 0.9,
          ),
        ),
      ],
    );
  }

  Widget _fieldGroup({
    required String number,
    required String label,
    String? hint,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fieldLabel(number: number, label: label),
          const SizedBox(height: 6),
          child,
          if (hint != null) ...[
            const SizedBox(height: 4),
            Text(hint, style: TextStyle(fontSize: 11, color: _tealMuted)),
          ],
        ],
      ),
    );
  }

  Widget _textInput({
    required TextEditingController controller,
    required String placeholder,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, color: _teal900),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: Color(0xFF9ab8b8), fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _tealBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _tealBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _teal500, width: 1.5),
        ),
      ),
    );
  }

  Widget _dropdownInput({
    required List<String> items,
    String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _tealBorder),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<String>(
        value: value,
        hint: const Text(
          'Select an option',
          style: TextStyle(color: Color(0xFF9ab8b8), fontSize: 14),
        ),
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down, color: _teal500),
        style: const TextStyle(fontSize: 14, color: _teal900),
        onChanged: onChanged,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
      ),
    );
  }

  // ── "Other" Open Text Input (replaces "Other" checkbox) ──────────────────

  Widget _otherTextInput({
    required TextEditingController controller,
    required String placeholder,
    required List<String> customItems,
    required VoidCallback onAdd,
    required ValueChanged<String> onDelete,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: 38,
                  height: 38,
                  margin: const EdgeInsets.only(top: 2, right: 10),
                  decoration: BoxDecoration(
                    color: _teal100,
                    border: Border.all(color: _teal500),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontSize: 22,
                        color: _teal500,
                        height: 1.1,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(fontSize: 13, color: _teal900),
                  decoration: InputDecoration(
                    hintText: placeholder,
                    hintStyle: const TextStyle(
                      color: Color(0xFF9ab8b8),
                      fontSize: 13,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: _tealBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: _tealBorder,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: _teal500, width: 1.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (customItems.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              children: customItems.map((item) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: _tealBorder),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 13, color: _teal900),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onDelete(item),
                        child: const Icon(Icons.close, size: 16, color: Colors.red),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _checkboxList({
    required List<String> options,
    required Set<String> selected,
    required ValueChanged<String> onToggle,
  }) {
    return Column(
      children: options.map((opt) {
        final on = selected.contains(opt);
        return GestureDetector(
          onTap: () => onToggle(opt),
          child: Container(
            margin: const EdgeInsets.only(bottom: 2),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: on ? _teal100 : Colors.transparent,
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: on ? _teal500 : Colors.white,
                    border: Border.all(color: on ? _teal500 : _tealBorder),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: on
                      ? const Icon(Icons.check, size: 12, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 10),
                Text(
                  opt,
                  style: const TextStyle(fontSize: 13, color: _teal900),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _starRating({
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return Row(
      children: List.generate(5, (i) {
        final filled = i < value;
        return GestureDetector(
          onTap: () => onChanged(i + 1),
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: Icon(
                filled ? Icons.star_rounded : Icons.star_outline_rounded,
                key: ValueKey(filled),
                size: 34,
                color: filled ? _teal500 : _tealBorder,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _scaleSelector({
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return Row(
      children: List.generate(5, (i) {
        final on = i < value;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < 4 ? 5 : 0),
            child: GestureDetector(
              onTap: () => onChanged(i + 1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                height: 42,
                decoration: BoxDecoration(
                  color: on ? _teal500 : Colors.white,
                  border: Border.all(color: on ? _teal500 : _tealBorder),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: on ? Colors.white : _tealMuted,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
