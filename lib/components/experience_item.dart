import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../cv_model.dart';

class ExperienceItem extends StatelessWidget {
  final Experience experience;
  final bool isLast;

  const ExperienceItem({super.key, required this.experience, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final hasMultipleRoles = experience.roles.length > 1;

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
                // Company name and total duration
                Text(experience.company, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 18)),
                if (hasMultipleRoles) ...[
                  const SizedBox(height: 2),
                  Text(
                    "${experience.totalDuration} • ${experience.location}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                ],
                const SizedBox(height: 8),
                // Roles
                ...experience.roles.asMap().entries.map((entry) {
                  final index = entry.key;
                  final role = entry.value;
                  final isLastRole = index == experience.roles.length - 1;
                  return _buildRoleItem(context, role, hasMultipleRoles, isLastRole);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleItem(BuildContext context, ExperienceRole role, bool hasMultipleRoles, bool isLastRole) {
    return Container(
      margin: EdgeInsets.only(bottom: isLastRole ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator for multiple roles
          if (hasMultipleRoles) ...[
            Column(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                ),
                if (!isLastRole) Container(width: 2, height: 80, color: Colors.grey[300]),
              ],
            ),
            const SizedBox(width: 12),
          ],
          // Role content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                // Employment details
                Wrap(
                  spacing: 8,
                  runSpacing: 2,
                  children: [
                    if (role.employmentType.isNotEmpty) _buildTag(context, role.employmentType),
                    if (!hasMultipleRoles && experience.location.isNotEmpty) _buildTag(context, experience.location),
                    if (role.locationType.isNotEmpty) _buildTag(context, role.locationType),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  "${role.startDate} - ${role.endDate} • ${role.duration}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
                if (role.description.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    role.description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                // Highlights
                if (role.highlights.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  ...role.highlights
                      .take(2)
                      .map(
                        (h) => Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.check_circle, size: 12, color: Theme.of(context).colorScheme.secondary),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  h,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
                // Skills
                if (role.skills.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: role.skills.take(3).map((s) => _buildSkillChip(context, s)).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600], fontSize: 11));
  }

  Widget _buildSkillChip(BuildContext context, String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
