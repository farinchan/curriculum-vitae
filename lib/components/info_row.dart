import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;

  const InfoRow({super.key, required this.title, this.subtitle, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[Icon(icon, size: 18, color: Theme.of(context).primaryColor), const SizedBox(width: 12)],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: icon != null ? FontWeight.w500 : FontWeight.bold),
                ),
                if (subtitle != null)
                  Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
