import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  final String label;
  final String? level;
  final int? endorsements;

  const SkillChip({super.key, required this.label, this.level, this.endorsements});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).primaryColor.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontSize: 13),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
