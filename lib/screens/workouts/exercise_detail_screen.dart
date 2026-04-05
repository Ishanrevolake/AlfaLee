import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/fitness_models.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback? onDone;

  const ExerciseDetailScreen({super.key, required this.exercise, this.onDone});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  int _activeSet = 1;
  int _weight = 35;
  int _reps = 8;
  bool _isKg = true;

  bool _isNotesExpanded = false;
  Set<int> _completedSets = {};
  
  int _restSecondsRemaining = 0;
  Timer? _restTimer;

  @override
  void dispose() {
    _restTimer?.cancel();
    super.dispose();
  }

  void _startRestTimer() {
    _restTimer?.cancel();
    setState(() {
      _restSecondsRemaining = 3 * 60; // 3 minutes
    });
    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_restSecondsRemaining > 0) {
        setState(() {
          _restSecondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final isLastSet = _activeSet == widget.exercise.sets;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D1B26), 
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.transparent, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
        ), 
        toolbarHeight: 0, 
      ),
      body: SafeArea(
        top: false, 
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Video Player Mock
              Container(
                width: double.infinity,
                height: 260,
                color: const Color(0xFF1D1B26),
                child: SafeArea(
                  bottom: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 8,
                        left: 8,
                        child: IconButton(
                          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 32),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.more_horiz, color: Colors.white, size: 28),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white38, width: 2),
                          color: Colors.white12,
                        ),
                        child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
                      ),
                      Positioned(
                        bottom: 16,
                        child: Text(
                          '${widget.exercise.name} · Technique Video',
                          style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Header
              Text(
                widget.exercise.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF121B28), letterSpacing: -0.5),
              ),
              const SizedBox(height: 4),
              Text(
                '${widget.exercise.sets} Sets',
                style: const TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),

              // Notes from Trainer Box (Separated)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isNotesExpanded = !_isNotesExpanded;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEEEEEE)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2)),
                    ]
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Notes from Trainer:', style: TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w600)),
                          Icon(_isNotesExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.black38),
                        ],
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        alignment: Alignment.topCenter,
                        child: _isNotesExpanded 
                          ? Column(
                              children: [
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                                      child: const Icon(Icons.play_arrow, color: Colors.white, size: 18),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 4,
                                            width: double.infinity,
                                            decoration: BoxDecoration(color: const Color(0xFFEEEEEE), borderRadius: BorderRadius.circular(2)),
                                          ),
                                          Container(
                                            height: 4,
                                            width: 40,
                                            decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(2)),
                                          ),
                                          Positioned(
                                            left: 36,
                                            top: -3,
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Keep shoulders loose and grip intact. Focus on the squeeze at the bottom of the movement. Make sure to drive through your heels and control the eccentric.',
                                  style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Sets Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                clipBehavior: Clip.antiAlias, // Explicit clipping to fix any edge bleeding
                child: Column(
                  children: [
                    // Tabs
                    Row(
                      children: List.generate(widget.exercise.sets, (index) {
                        final int setNum = index + 1;
                        final bool isActive = _activeSet == setNum;
                        final bool isCompleted = _completedSets.contains(setNum);

                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _activeSet = setNum;
                              });
                            },
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: isCompleted ? Theme.of(context).primaryColor.withOpacity(0.12) : Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                      color: isCompleted || isActive
                                          ? Theme.of(context).primaryColor 
                                          : const Color(0xFFEEEEEE),
                                      width: isActive ? 3 : 1
                                  ),
                                  right: BorderSide(color: const Color(0xFFEEEEEE), width: index < widget.exercise.sets - 1 ? 1 : 0),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '$setNum',
                                style: TextStyle(
                                  fontSize: isActive ? 18 : 16,
                                  fontWeight: isActive || isCompleted ? FontWeight.w800 : FontWeight.w600,
                                  color: isActive || isCompleted ? const Color(0xFF121B28) : Colors.black45,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    // Set Details
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          // Weight
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildCounterBtn(Icons.remove, () => setState(() => _weight--)),
                              SizedBox(
                                width: 80,
                                child: Text('$_weight', textAlign: TextAlign.center, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w800, color: Color(0xFF121B28), height: 1.1)),
                              ),
                              _buildCounterBtn(Icons.add, () => setState(() => _weight++)),
                            ],
                          ),
                          // Toggle KG / LB
                          Container(
                            margin: const EdgeInsets.only(top: 8, bottom: 32),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildToggleText('KG', _isKg, () => setState(() => _isKg = true)),
                                _buildToggleText('LB', !_isKg, () => setState(() => _isKg = false)),
                              ],
                            ),
                          ),
                          // Reps
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildCounterBtn(Icons.remove, () => setState(() => _reps--)),
                              SizedBox(
                                width: 80,
                                child: Text('$_reps', textAlign: TextAlign.center, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: Color(0xFF121B28), height: 1.1)),
                              ),
                              _buildCounterBtn(Icons.add, () => setState(() => _reps++)),
                            ],
                          ),
                          const Text('REPS', style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w700, letterSpacing: 1)),
                          
                          const SizedBox(height: 32),
                          
                          // Start Rest Timer
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                if (_restSecondsRemaining == 0) {
                                  _startRestTimer();
                                } else {
                                  _restTimer?.cancel();
                                  setState(() => _restSecondsRemaining = 0);
                                }
                              },
                              icon: const Icon(Icons.timer_outlined, size: 20),
                              label: Text(
                                _restSecondsRemaining > 0 ? "Resting: ${_formatTime(_restSecondsRemaining)} - Tap to Cancel" : 'Start Rest Timer: 3 mins', 
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: _restSecondsRemaining > 0 ? Theme.of(context).primaryColor : const Color(0xFF121B28),
                                side: BorderSide(color: _restSecondsRemaining > 0 ? Theme.of(context).primaryColor : const Color(0xFFEEEEEE), width: 1.5),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                backgroundColor: const Color(0xFFFAFAFA),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Next Set Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _completedSets.add(_activeSet);
                        if (!isLastSet) {
                           _activeSet++;
                        } else {
                           widget.exercise.isCompleted = true;
                           if (widget.onDone != null) widget.onDone!();
                           Navigator.pop(context, true);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: Text(isLastSet ? 'Complete All' : 'Next Set →', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Message Trainer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Message Trainer:', style: TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: const Color(0xFFEEEEEE), width: 1.5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Ask your trainer something...',
                                hintStyle: TextStyle(color: Colors.black38, fontSize: 14, fontWeight: FontWeight.w500),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                            child: const Icon(Icons.play_arrow, color: Colors.white, size: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounterBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 44,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Icon(icon, color: Colors.black38, size: 20),
      ),
    );
  }

  Widget _buildToggleText(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: isActive ? Colors.white : Colors.black38,
          ),
        ),
      ),
    );
  }
}
