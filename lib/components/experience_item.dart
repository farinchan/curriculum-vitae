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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Logo with gradient border
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                      Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.all(3),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(11)),
                  padding: const EdgeInsets.all(8),
                  child: experience.companyLogoUrl.isNotEmpty
                      ? FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: experience.companyLogoUrl,
                          fit: BoxFit.contain,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.business_rounded, color: Theme.of(context).colorScheme.primary, size: 24);
                          },
                        )
                      : Icon(Icons.business_rounded, color: Theme.of(context).colorScheme.primary, size: 24),
                ),
              ),
              const SizedBox(width: 16),
              // Company info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(experience.company, style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 14, color: Theme.of(context).colorScheme.secondary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            experience.location,
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (hasMultipleRoles) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${experience.roles.length} positions • ${experience.totalDuration}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Roles
          ...experience.roles.asMap().entries.map((entry) {
            final index = entry.key;
            final role = entry.value;
            final isLastRole = index == experience.roles.length - 1;
            return _buildRoleItem(context, role, hasMultipleRoles, isLastRole, index);
          }),
        ],
      ),
    );
  }

  Widget _buildRoleItem(BuildContext context, ExperienceRole role, bool hasMultipleRoles, bool isLastRole, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: isLastRole ? 0 : 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          if (hasMultipleRoles) ...[
            Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                if (!isLastRole)
                  Container(
                    width: 2,
                    height: 100,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
                          Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
          ],
          // Role content
          Expanded(
            child: Container(
              padding: hasMultipleRoles ? const EdgeInsets.only(left: 4) : EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Role title
                  Text(
                    role.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  // Tags row
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      if (role.employmentType.isNotEmpty)
                        _buildTag(context, role.employmentType, Icons.work_outline_rounded),
                      if (role.locationType.isNotEmpty) _buildTag(context, role.locationType, Icons.home_work_outlined),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Duration
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, size: 12, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 4),
                      Text(
                        '${role.startDate} - ${role.endDate}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        role.duration,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  // Description
                  if (role.description.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      role.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  // Highlights
                  if (role.highlights.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    ...role.highlights
                        .take(3)
                        .map(
                          (h) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  child: Icon(
                                    Icons.arrow_right_rounded,
                                    size: 16,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Expanded(child: Text(h, style: Theme.of(context).textTheme.bodySmall)),
                              ],
                            ),
                          ),
                        ),
                  ],
                  // Skills
                  if (role.skills.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: role.skills.take(4).map((s) => _buildSkillChip(context, s)).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context, String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFF64748B)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(BuildContext context, String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)),
      ),
      child: Text(
        skill,
        style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
      ),
    );
  }
}
