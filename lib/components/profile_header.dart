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
        Container(
          width: compact ? 120 : 140,
          height: compact ? 120 : 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5)),
            ],
            image: DecorationImage(image: NetworkImage(profile.avatarUrl), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          profile.name,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: compact ? 24 : 28),
          textAlign: compact ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 8),
        Text(
          profile.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w600,
            fontSize: compact ? 16 : 20,
          ),
          textAlign: compact ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: compact ? 400 : double.infinity),
          child: Text(
            profile.bio,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: compact ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          alignment: compact ? WrapAlignment.center : WrapAlignment.start,
          children: profile.socials.map((s) => _buildSocialIcon(s)).toList(),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(Social social) {
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

    return IconButton(
      onPressed: () => launchUrl(Uri.parse(social.url)),
      icon: FaIcon(iconData, size: 24),
      color: const Color(0xFF2C3E50),
      tooltip: social.platform,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}
