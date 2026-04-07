import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/fitness_models.dart';
import 'workout_complete_screen.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback? onDone;

  const ExerciseDetailScreen({super.key, required this.exercise, this.onDone});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  int _activeSet = 1;
  late int _totalSets;
  
  final TextEditingController _weightController = TextEditingController(text: '4.5');
  final TextEditingController _repsController = TextEditingController(text: '8-10');


  final Set<int> _completedSets = {};
  
  bool _restTimerEnabled = true;

  @override
  void initState() {
    super.initState();
    _totalSets = widget.exercise.sets;
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }
  
  void _showWorkoutOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(2))),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Complete Workout', style: TextStyle(fontWeight: FontWeight.w600)),
                    trailing: const Icon(Icons.check_circle, color: Color(0xFF121B28)),
                    onTap: () {
                      Navigator.pop(context);
                      _navigateToComplete();
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('End Workout', style: TextStyle(fontWeight: FontWeight.w600)),
                    trailing: const Icon(Icons.output_rounded, color: Color(0xFF121B28)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('Rest timer', style: TextStyle(fontWeight: FontWeight.w600)),
                    value: _restTimerEnabled,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (val) {
                      setModalState(() { _restTimerEnabled = val; });
                      setState(() { _restTimerEnabled = val; });
                    },
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.85),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                        ),
                        child: const Text('DONE', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          }
        );
      }
    );
  }

  void _showSetOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Set'),
              onTap: () {
                setState(() => _totalSets++);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.remove),
              title: const Text('Remove Set'),
              onTap: () {
                if (_totalSets > 1) {
                  setState(() {
                    _totalSets--;
                    if (_activeSet > _totalSets) _activeSet = _totalSets;
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              color: Colors.white,
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(24),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Help', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF121B28))),
                      IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(widget.exercise.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF121B28))),
                  const SizedBox(height: 24),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(color: const Color(0xFFFAFAFA), borderRadius: BorderRadius.circular(16)),
                    child: const Icon(Icons.fitness_center, size: 80, color: Colors.black12),
                  ),
                  const SizedBox(height: 32),
                  _buildInstructionStep(1, 'Lying on an incline bench at 45 degrees, with a dumbbell in each hand with a neutral grip either side of your chest.'),
                  const SizedBox(height: 24),
                  _buildInstructionStep(2, 'Push both dumbbells up by straightening your arms, keeping them inline with your chest throughout.'),
                  const SizedBox(height: 24),
                  _buildInstructionStep(3, 'Lower them down, elbows by your sides at a 45 degree angle.'),
                ],
              ),
            );
          }
        );
      }
    );
  }

  Widget _buildInstructionStep(int step, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24, height: 24,
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: Color(0xFFEEEEEE), shape: BoxShape.circle),
          child: Text('$step', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
        ),
        const SizedBox(width: 16),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 15, color: Color(0xFF121B28), height: 1.5, fontWeight: FontWeight.w500))),
      ],
    );
  }

  void _showRestTimerOverlay() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          int seconds = 73; 
          return StatefulBuilder(
            builder: (context, setOverlayState) {
              Timer? t;
              t = Timer.periodic(const Duration(seconds: 1), (timer) {
                if (seconds > 0) {
                  setOverlayState(() => seconds--);
                } else {
                  timer.cancel();
                  if (Navigator.canPop(context)) Navigator.pop(context);
                }
              });
              
              String formatTime(int s) {
                final mStr = (s ~/ 60).toString().padLeft(2, '0');
                final sStr = (s % 60).toString().padLeft(2, '0');
                return '$mStr:$sStr';
              }
              
              return Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(icon: const Icon(Icons.chevron_left, size: 30, color: Color(0xFF121B28)), onPressed: () { t?.cancel(); Navigator.pop(context); }),
                            ),
                            const Text('REST', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF121B28), letterSpacing: 1)),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(icon: const Icon(Icons.more_horiz, color: Color(0xFF121B28)), onPressed: (){}),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.85), 
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('REST', style: TextStyle(color: Colors.white70, fontSize: 16, letterSpacing: 1)),
                              const SizedBox(height: 16),
                              Text(formatTime(seconds), style: const TextStyle(color: Colors.white, fontSize: 80, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 48),
                              ElevatedButton(
                                onPressed: () { t?.cancel(); Navigator.pop(context); },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(0.15),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                                  elevation: 0,
                                ),
                                child: const Text('SKIP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 1)),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            }
          );
        }
      ),
    ).then((_) {
      setState(() {
        if (_activeSet < _totalSets) {
          _activeSet++;
        }
      });
    });
  }

  void _navigateToComplete() {
    widget.exercise.isCompleted = true;
    if (widget.onDone != null) widget.onDone!();
    Navigator.push(context, MaterialPageRoute(builder: (_) => const WorkoutCompleteScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final isLastSet = _activeSet == _totalSets;

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            widget.exercise.name,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF121B28), letterSpacing: -0.5),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$_totalSets Sets',
                            style: const TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: IconButton(
                       icon: const Icon(Icons.more_horiz, color: Color(0xFF121B28), size: 28),
                       onPressed: () => _showWorkoutOptions(context),
                    ),
                  ),
                ],
              ),
             
              const SizedBox(height: 24),
              

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
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Row(
                      children: [
                        ...List.generate(_totalSets, (index) {
                          final int setNum = index + 1;
                          final bool isActive = _activeSet == setNum;
                          final bool isCompleted = _completedSets.contains(setNum);

                          return Expanded(
                            child: GestureDetector(
                              onTap: null,
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: isCompleted ? Theme.of(context).primaryColor.withOpacity(0.1) : (isActive ? Theme.of(context).primaryColor.withOpacity(0.85) : Colors.white),
                                  border: Border(
                                    bottom: BorderSide(
                                        color: isCompleted || isActive
                                            ? Theme.of(context).primaryColor
                                            : const Color(0xFFEEEEEE),
                                        width: isActive ? 3 : 1
                                    ),
                                    right: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '$setNum',
                                  style: TextStyle(
                                    fontSize: isActive ? 18 : 16,
                                    fontWeight: isActive || isCompleted ? FontWeight.w800 : FontWeight.w600,
                                    color: isActive ? Colors.white : (isCompleted ? const Color(0xFF121B28) : Colors.black45),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _showSetOptions(context),
                            child: Container(
                              height: 48,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.more_horiz, color: Color(0xFF121B28)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text('LAST ENTRY', style: TextStyle(fontSize: 11, color: Colors.black38, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 52,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: const Color(0xFFEEEEEE)),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: _weightController,
                                              keyboardType: TextInputType.number,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF121B28)),
                                              decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                                              scrollPadding: EdgeInsets.zero,
                                            ),
                                          ),
                                          const Text('Kg', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 16)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text('x', style: TextStyle(color: Colors.black26, fontSize: 18, fontWeight: FontWeight.w600)),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text('TARGET', style: TextStyle(fontSize: 11, color: Colors.black38, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 52,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: const Color(0xFFEEEEEE)),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: _repsController,
                                              keyboardType: TextInputType.text,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF121B28)),
                                              decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                                            ),
                                          ),
                                          const Text('Reps', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 16)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(border: Border.all(color: const Color(0xFFEEEEEE)), borderRadius: BorderRadius.circular(12)),
                                child: IconButton(icon: const Icon(Icons.help_outline, color: Color(0xFF121B28)), onPressed: () => _showHelpBottomSheet(context)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SizedBox(
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        _completedSets.add(_activeSet);
                                      });
                                      if (isLastSet) {
                                        _navigateToComplete();
                                      } else {
                                        if (_restTimerEnabled) {
                                          _showRestTimerOverlay();
                                        } else {
                                          setState(() => _activeSet++);
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.85), 
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                                      elevation: 0,
                                    ),
                                    child: Text(isLastSet ? 'COMPLETE ALL' : 'NEXT', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Personal Best', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF121B28))),
                        Text('09/10/24', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black45)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.85), 
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('8 REPS', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                          Text('7.5 KG', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Last entry', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF121B28))),
                        Text('View all >', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF121B28))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(bottom: 12),
                      child: const Text('27/11/2025', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black45)),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                      ),
                      child: Column(
                        children: [
                          _buildHistoryRow(1, '4.5 Kg', '12 Reps'),
                          _buildHistoryRow(2, '4.5 Kg', '8 Reps'),
                          _buildHistoryRow(3, '4.5 Kg', '8 Reps'),
                          _buildHistoryRow(4, '4.5 Kg', '8 Reps', isLast: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryRow(int setNum, String weight, String reps, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: isLast ? Colors.transparent : const Color(0xFFEEEEEE), width: 1)),
      ),
      child: Row(
        children: [
          SizedBox(width: 40, child: Text('$setNum', style: const TextStyle(fontSize: 16, color: Color(0xFF121B28), fontWeight: FontWeight.w600))),
          Container(width: 1, height: 24, color: const Color(0xFFEEEEEE)),
          const SizedBox(width: 16),
          Expanded(child: Text('$weight x $reps', style: const TextStyle(fontSize: 16, color: Color(0xFF121B28), fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
