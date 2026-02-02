import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../cv_model.dart';

class EducationItem extends StatelessWidget {
  final Education education;

  const EducationItem({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEDF2F7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Institution Logo
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                padding: const EdgeInsets.all(4),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: education.logoUrl,
                  fit: BoxFit.contain,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.school, color: Colors.grey);
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Main Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      education.institution,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 2),
                    Text(education.degree, style: Theme.of(context).textTheme.titleMedium),
                    if (education.fieldOfStudy.isNotEmpty)
                      Text(
                        education.fieldOfStudy,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                      ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          "${education.startDate} - ${education.endDate}",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                        ),
                        if (education.location.isNotEmpty) ...[
                          const SizedBox(width: 12),
                          Icon(Icons.location_on_outlined, size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            education.location,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              // GPA Badge
              if (education.gpa.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "GPA",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Text(
                        "${education.gpa}/${education.maxGpa}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          // Description
          if (education.description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(education.description, style: Theme.of(context).textTheme.bodyMedium),
          ],
          // Activities
          if (education.activities.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              "Activities & Societies",
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: education.activities.map((a) => _buildActivityChip(context, a)).toList(),
            ),
          ],
          // Relevant Courses
          if (education.courses.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              "Relevant Courses",
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Text(
              education.courses.join(" • "),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActivityChip(BuildContext context, String activity) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(4)),
      child: Text(
        activity,
        style: TextStyle(fontSize: 11, color: Colors.blue[700], fontWeight: FontWeight.w500),
      ),
    );
  }
}
