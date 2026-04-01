import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProgressMeterWidget extends StatelessWidget {
  final double width;
  final double progress;

  const ProgressMeterWidget({
    super.key,
    required this.width,
    this.progress = 0.85,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: width * 0.6,
          width: width,
          child: CustomPaint(
            painter: _MeterPainter(progress: progress),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('OPTIMAL', 
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300, letterSpacing: 4, color: Colors.black)),
                SizedBox(height: 16),
                Text('Current Level', 
                  style: TextStyle(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.w300)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _MeterLevel(label: 'Off-Track', color: Color(0xFFDC143C)),
            _MeterLevel(label: 'Good', color: Colors.yellow),
            _MeterLevel(label: 'Optimal', color: Colors.black),
          ],
        ),
      ],
    );
  }
}

class _MeterPainter extends CustomPainter {
  final double progress;
  _MeterPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;
    
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // Background track
    paint.color = const Color(0xFFEEEEEE);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      paint,
    );

    // Levels indicators (thin lines)
    final markerPaint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 1;
    
    for (int i = 0; i <= 4; i++) {
      final angle = math.pi + (i * math.pi / 4);
      final start = Offset(
        center.dx + (radius - 10) * math.cos(angle),
        center.dy + (radius - 10) * math.sin(angle),
      );
      final end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(start, end, markerPaint);
    }

    // Active progress
    paint.color = Colors.black;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi * progress,
      false,
      paint,
    );

    // Glow
    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..color = const Color(0xFFE0E0E0)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), math.pi, math.pi * progress, false, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _MeterLevel extends StatelessWidget {
  final String label;
  final Color color;
  const _MeterLevel({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 2, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.black38, fontWeight: FontWeight.w300)),
      ],
    );
  }
}
