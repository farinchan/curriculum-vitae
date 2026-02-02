import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cv_model.dart';
import 'data_service.dart';
import 'components/profile_header.dart';
import 'components/experience_item.dart';
import 'components/education_item.dart';
import 'components/skill_chip.dart';
import 'components/project_card.dart';
import 'components/info_row.dart';
import 'components/publication_item.dart';

// Breakpoints for responsive design
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

enum ScreenSize { mobile, tablet, desktop }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<CVSpec> _cvData;

  @override
  void initState() {
    super.initState();
    _cvData = DataService().loadData();
  }

  ScreenSize _getScreenSize(double width) {
    if (width < Breakpoints.mobile) return ScreenSize.mobile;
    if (width < Breakpoints.tablet) return ScreenSize.tablet;
    return ScreenSize.desktop;
  }

  double _getHorizontalPadding(ScreenSize size) {
    switch (size) {
      case ScreenSize.mobile:
        return 16;
      case ScreenSize.tablet:
        return 32;
      case ScreenSize.desktop:
        return 48;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CVSpec>(
        future: _cvData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          final data = snapshot.data!;
          return LayoutBuilder(
            builder: (context, constraints) {
              final screenSize = _getScreenSize(constraints.maxWidth);
              final horizontalPadding = _getHorizontalPadding(screenSize);

              return Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
                  child: _buildLayout(data, screenSize, constraints.maxWidth),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLayout(CVSpec data, ScreenSize screenSize, double screenWidth) {
    switch (screenSize) {
      case ScreenSize.desktop:
        return _buildDesktopLayout(data, screenWidth);
      case ScreenSize.tablet:
        return _buildTabletLayout(data, screenWidth);
      case ScreenSize.mobile:
        return _buildMobileLayout(data, screenWidth);
    }
  }

  // ============ DESKTOP LAYOUT ============
  Widget _buildDesktopLayout(CVSpec data, double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sidebar / Left Column (Sticky)
        SizedBox(
          width: 320,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(profile: data.profile, compact: false),
                const SizedBox(height: 32),
                _buildSidebarCard("Contact", _buildContactSection(data.profile)),
                const SizedBox(height: 24),
                _buildSidebarCard("Skills", _buildSkillsSection(data.skills)),
                const SizedBox(height: 24),
                _buildSidebarCard("Languages", _buildLanguagesSection(data.languages)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 48),
        // Main Content / Right Column
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle("Experience"),
                ...data.experience.asMap().entries.map((entry) {
                  return ExperienceItem(experience: entry.value, isLast: entry.key == data.experience.length - 1);
                }),
                const SizedBox(height: 40),

                _buildSectionTitle("Education"),
                ...data.education.map((e) => EducationItem(education: e)),
                const SizedBox(height: 40),

                _buildSectionTitle("Projects"),
                _buildProjectsGrid(data.projects, screenWidth - 320 - 48 - 96), // Account for sidebar
                const SizedBox(height: 40),

                _buildSectionTitle("Certifications & Awards"),
                _buildCertificationsAndAwards(data),

                if (data.organizations.isNotEmpty) ...[
                  const SizedBox(height: 40),
                  _buildSectionTitle("Organizations"),
                  ...data.organizations.map(
                    (o) => InfoRow(title: o.role, subtitle: "${o.name} | ${o.startDate} - ${o.endDate}"),
                  ),
                ],

                if (data.publications.isNotEmpty) ...[
                  const SizedBox(height: 40),
                  _buildSectionTitle("Publications"),
                  ...data.publications.map((p) => PublicationItem(publication: p)),
                ],
              ],
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.03, end: 0),
          ),
        ),
      ],
    );
  }

  // ============ TABLET LAYOUT ============
  Widget _buildTabletLayout(CVSpec data, double screenWidth) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section - Centered for Tablet
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: ProfileHeader(profile: data.profile, compact: true),
            ),
          ),
          const SizedBox(height: 32),

          // Contact & Skills in a Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildSidebarCard("Contact", _buildContactSection(data.profile))),
              const SizedBox(width: 24),
              Expanded(child: _buildSidebarCard("Skills", _buildSkillsSection(data.skills))),
            ],
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 32),

          _buildSectionTitle("Experience"),
          ...data.experience.asMap().entries.map((entry) {
            return ExperienceItem(experience: entry.value, isLast: entry.key == data.experience.length - 1);
          }),
          const SizedBox(height: 40),

          _buildSectionTitle("Education"),
          ...data.education.map((e) => EducationItem(education: e)),
          const SizedBox(height: 40),

          _buildSectionTitle("Projects"),
          _buildProjectsGrid(data.projects, screenWidth - 64), // Account for padding
          const SizedBox(height: 40),

          _buildSectionTitle("Certifications & Awards"),
          _buildCertificationsAndAwards(data),

          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data.languages.isNotEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildSectionTitle("Languages"), _buildLanguagesSection(data.languages)],
                  ),
                ),
              if (data.organizations.isNotEmpty) ...[
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("Organizations"),
                      ...data.organizations.map(
                        (o) => InfoRow(title: o.role, subtitle: "${o.name} | ${o.startDate} - ${o.endDate}"),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          if (data.publications.isNotEmpty) ...[
            const SizedBox(height: 40),
            _buildSectionTitle("Publications"),
            ...data.publications.map((p) => PublicationItem(publication: p)),
          ],
        ],
      ).animate().fadeIn(duration: 500.ms),
    );
  }

  // ============ MOBILE LAYOUT ============
  Widget _buildMobileLayout(CVSpec data, double screenWidth) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile - Centered on Mobile
          ProfileHeader(profile: data.profile, compact: true),
          const SizedBox(height: 24),
          _buildContactSection(data.profile),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 24),

          // All sections stacked vertically
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle("Experience"),
                ...data.experience.asMap().entries.map((entry) {
                  return ExperienceItem(experience: entry.value, isLast: entry.key == data.experience.length - 1);
                }),
                const SizedBox(height: 32),

                _buildSectionTitle("Education"),
                ...data.education.map((e) => EducationItem(education: e)),
                const SizedBox(height: 32),

                _buildSectionTitle("Projects"),
                ...data.projects.map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: AspectRatio(aspectRatio: 1.2, child: ProjectCard(project: p)),
                  ),
                ),
                const SizedBox(height: 32),

                _buildSectionTitle("Skills"),
                _buildSkillsSection(data.skills),
                const SizedBox(height: 32),

                _buildSectionTitle("Certifications & Awards"),
                _buildCertificationsAndAwards(data),

                if (data.languages.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  _buildSectionTitle("Languages"),
                  _buildLanguagesSection(data.languages),
                ],

                if (data.organizations.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  _buildSectionTitle("Organizations"),
                  ...data.organizations.map(
                    (o) => InfoRow(title: o.role, subtitle: "${o.name} | ${o.startDate} - ${o.endDate}"),
                  ),
                ],

                if (data.publications.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  _buildSectionTitle("Publications"),
                  ...data.publications.map((p) => PublicationItem(publication: p)),
                ],
              ],
            ),
          ),
        ],
      ).animate().fadeIn(duration: 500.ms),
    );
  }

  // ============ HELPER WIDGETS ============

  Widget _buildSidebarCard(String title, Widget content) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title.toUpperCase(),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                  Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_getSectionIcon(title), size: 20, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 2,
            width: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getSectionIcon(String title) {
    switch (title.toLowerCase()) {
      case 'experience':
        return Icons.work_outline_rounded;
      case 'education':
        return Icons.school_outlined;
      case 'projects':
        return Icons.code_rounded;
      case 'certifications & awards':
        return Icons.emoji_events_outlined;
      case 'organizations':
        return Icons.groups_outlined;
      case 'publications':
        return Icons.menu_book_outlined;
      default:
        return Icons.folder_outlined;
    }
  }

  Widget _buildContactSection(Profile profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoRow(icon: Icons.email_outlined, title: profile.email),
        InfoRow(icon: Icons.phone_outlined, title: profile.phone),
        InfoRow(icon: Icons.location_on_outlined, title: profile.location),
        InfoRow(icon: Icons.link, title: profile.website),
      ],
    );
  }

  Widget _buildSkillsSection(List<Skill> skills) {
    return Wrap(spacing: 8, runSpacing: 8, children: skills.map((s) => SkillChip(label: s.name)).toList());
  }

  Widget _buildLanguagesSection(List<Language> languages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: languages.map((l) => InfoRow(title: l.language, subtitle: l.proficiency)).toList(),
    );
  }

  Widget _buildProjectsGrid(List<Project> projects, double availableWidth) {
    // Calculate number of columns based on available width
    int crossAxisCount = 1;
    if (availableWidth > 800) {
      crossAxisCount = 3;
    } else if (availableWidth > 500) {
      crossAxisCount = 2;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) => ProjectCard(project: projects[index]),
    );
  }

  Widget _buildCertificationsAndAwards(CVSpec data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...data.certifications.map(
          (c) => InfoRow(icon: Icons.verified_outlined, title: c.name, subtitle: "${c.issuer} | ${c.issueDate}"),
        ),
        ...data.awards.map(
          (a) => InfoRow(icon: Icons.emoji_events_outlined, title: a.title, subtitle: "${a.issuer} | ${a.date}"),
        ),
      ],
    );
  }
}
