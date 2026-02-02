import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cv_model.dart';

class ProfileHeader extends StatelessWidget {
  final Profile profile;
  final bool compact;

  const ProfileHeader({super.key, required this.profile, required this.compact});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: compact ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Avatar with status badge
        Stack(
          children: [
            Container(
              width: compact ? 100 : 130,
              height: compact ? 100 : 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  image: DecorationImage(image: NetworkImage(profile.avatarUrl), fit: BoxFit.cover),
                ),
              ),
            ),
            // Open to work badge
            if (profile.openToWork)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Text(
                    'Open',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
        // Name
        Text(
          profile.name,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: compact ? 22 : 28),
          textAlign: compact ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 8),
        // Title with accent
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.secondary.withValues(alpha: 0.15),
                Theme.of(context).colorScheme.secondary.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            profile.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: compact ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 16),
        // Bio
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: compact ? 400 : double.infinity),
          child: Text(
            profile.bio,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: compact ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 20),
        // Social icons
        Wrap(
          spacing: 8,
          alignment: compact ? WrapAlignment.center : WrapAlignment.start,
          children: profile.socials.map((s) => _buildSocialButton(context, s)).toList(),
        ),
      ],
    );
  }

  Widget _buildSocialButton(BuildContext context, Social social) {
    IconData iconData;
    switch (social.icon.toLowerCase()) {
      case 'github':
        iconData = FontAwesomeIcons.github;
        break;
      case 'linkedin':
        iconData = FontAwesomeIcons.linkedin;
        break;
      case 'twitter':
        iconData = FontAwesomeIcons.twitter;
        break;
      case 'instagram':
        iconData = FontAwesomeIcons.instagram;
        break;
      default:
        iconData = FontAwesomeIcons.link;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(social.url)),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15)),
          ),
          child: FaIcon(iconData, size: 18, color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
