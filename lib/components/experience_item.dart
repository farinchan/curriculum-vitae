import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../cv_model.dart';

class ExperienceItem extends StatelessWidget {
  final Experience experience;
  final bool isLast;

  const ExperienceItem({super.key, required this.experience, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company Logo
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[200]!),
            ),
            padding: const EdgeInsets.all(4),
            child: experience.companyLogoUrl.isNotEmpty
                ? FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: experience.companyLogoUrl,
                    fit: BoxFit.contain,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.business, color: Theme.of(context).primaryColor);
                    },
                  )
                : Icon(Icons.business, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(experience.role, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 18)),
                const SizedBox(height: 4),
                Text(
                  experience.company,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                // Employment details row
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    if (experience.employmentType.isNotEmpty)
                      _buildTag(context, experience.employmentType, Icons.work_outline),
                    if (experience.location.isNotEmpty)
                      _buildTag(context, experience.location, Icons.location_on_outlined),
                    if (experience.locationType.isNotEmpty)
                      _buildTag(context, experience.locationType, Icons.home_work_outlined),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "${experience.startDate} - ${experience.endDate}",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600], fontWeight: FontWeight.w500),
                ),
                if (experience.description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    experience.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                // Highlights (limited to 3)
                if (experience.highlights.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  ...experience.highlights
                      .take(3)
                      .map(
                        (h) => Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.check_circle, size: 14, color: Theme.of(context).colorScheme.secondary),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  h,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
                // Skills used (limited to 4)
                if (experience.skills.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: experience.skills.take(4).map((s) => _buildSkillChip(context, s)).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context, String text, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600], fontSize: 11)),
      ],
    );
  }

  Widget _buildSkillChip(BuildContext context, String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        skill,
        style: TextStyle(fontSize: 10, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
      ),
    );
  }
}
