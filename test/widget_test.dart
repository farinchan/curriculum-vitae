import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_cv/cv_model.dart';

void main() {
  group('Profile Model Tests', () {
    test('Profile.fromJson should parse correctly', () {
      final json = {
        'name': 'John Doe',
        'headline': 'Software Developer',
        'title': 'Senior Developer',
        'bio': 'Passionate developer',
        'location': 'Jakarta, Indonesia',
        'email': 'john@example.com',
        'phone': '+62 123456789',
        'website': 'https://johndoe.com',
        'avatarUrl': 'https://example.com/avatar.jpg',
        'backgroundUrl': 'https://example.com/bg.jpg',
        'openToWork': true,
        'pronouns': 'He/Him',
        'connections': 500,
        'followers': 1000,
        'socials': [
          {'platform': 'GitHub', 'url': 'https://github.com/johndoe', 'icon': 'github'},
        ],
      };

      final profile = Profile.fromJson(json);

      expect(profile.name, 'John Doe');
      expect(profile.headline, 'Software Developer');
      expect(profile.title, 'Senior Developer');
      expect(profile.bio, 'Passionate developer');
      expect(profile.location, 'Jakarta, Indonesia');
      expect(profile.email, 'john@example.com');
      expect(profile.openToWork, true);
      expect(profile.connections, 500);
      expect(profile.followers, 1000);
      expect(profile.socials.length, 1);
      expect(profile.socials.first.platform, 'GitHub');
    });

    test('Profile.fromJson should handle missing fields with defaults', () {
      final json = <String, dynamic>{};

      final profile = Profile.fromJson(json);

      expect(profile.name, '');
      expect(profile.headline, '');
      expect(profile.openToWork, false);
      expect(profile.connections, 0);
      expect(profile.socials, isEmpty);
    });
  });

  group('Skill Model Tests', () {
    test('Skill.fromJson should parse correctly', () {
      final json = {'name': 'Flutter', 'level': 'Expert', 'endorsements': 25};

      final skill = Skill.fromJson(json);

      expect(skill.name, 'Flutter');
      expect(skill.level, 'Expert');
      expect(skill.endorsements, 25);
    });

    test('Skill.fromJson should handle missing fields', () {
      final json = <String, dynamic>{};

      final skill = Skill.fromJson(json);

      expect(skill.name, '');
      expect(skill.level, '');
      expect(skill.endorsements, 0);
    });
  });

  group('Education Model Tests', () {
    test('Education.fromJson should parse correctly', () {
      final json = {
        'degree': 'Bachelor',
        'fieldOfStudy': 'Computer Science',
        'institution': 'University of Indonesia',
        'logoUrl': 'https://example.com/logo.png',
        'location': 'Jakarta',
        'startDate': '2018',
        'endDate': '2022',
        'gpa': '3.8',
        'maxGpa': '4.0',
        'description': 'Studied computer science',
        'activities': ['Programming Club', 'Debate Team'],
        'courses': ['Data Structures', 'Algorithms'],
      };

      final education = Education.fromJson(json);

      expect(education.degree, 'Bachelor');
      expect(education.fieldOfStudy, 'Computer Science');
      expect(education.institution, 'University of Indonesia');
      expect(education.gpa, '3.8');
      expect(education.activities.length, 2);
      expect(education.courses.length, 2);
    });
  });

  group('Project Model Tests', () {
    test('Project.fromJson should parse correctly', () {
      final json = {
        'name': 'Portfolio App',
        'description': 'A flutter portfolio app',
        'imageUrl': 'https://example.com/project.png',
        'link': 'https://github.com/user/project',
        'demoUrl': 'https://portfolio.example.com',
        'startDate': '2023-01',
        'endDate': '2023-06',
        'technologies': ['Flutter', 'Dart'],
        'highlights': ['Responsive design', 'Dark mode'],
      };

      final project = Project.fromJson(json);

      expect(project.name, 'Portfolio App');
      expect(project.description, 'A flutter portfolio app');
      expect(project.technologies.length, 2);
      expect(project.technologies, contains('Flutter'));
      expect(project.highlights.length, 2);
    });
  });

  group('Experience Model Tests', () {
    test('Experience.fromJson should parse correctly', () {
      final json = {
        'company': 'Tech Corp',
        'companyLogoUrl': 'https://example.com/logo.png',
        'location': 'Jakarta',
        'totalDuration': '2 years',
        'roles': [
          {
            'title': 'Senior Developer',
            'employmentType': 'Full-time',
            'locationType': 'Remote',
            'startDate': '2022-01',
            'endDate': 'Present',
            'duration': '2 years',
            'description': 'Lead development team',
            'highlights': ['Led team of 5', 'Improved performance'],
            'skills': ['Flutter', 'Firebase'],
          },
        ],
      };

      final experience = Experience.fromJson(json);

      expect(experience.company, 'Tech Corp');
      expect(experience.totalDuration, '2 years');
      expect(experience.roles.length, 1);
      expect(experience.roles.first.title, 'Senior Developer');
      expect(experience.roles.first.skills, contains('Flutter'));
    });
  });

  group('Certification Model Tests', () {
    test('Certification.fromJson should parse correctly', () {
      final json = {
        'name': 'Flutter Developer Certification',
        'issuer': 'Google',
        'issuerLogoUrl': 'https://example.com/google.png',
        'issueDate': '2023-06',
        'expirationDate': '2026-06',
        'credentialId': 'CERT-12345',
        'credentialUrl': 'https://credential.example.com/12345',
      };

      final certification = Certification.fromJson(json);

      expect(certification.name, 'Flutter Developer Certification');
      expect(certification.issuer, 'Google');
      expect(certification.credentialId, 'CERT-12345');
    });
  });

  group('Language Model Tests', () {
    test('Language.fromJson should parse correctly', () {
      final json = {'language': 'English', 'proficiency': 'Fluent'};

      final language = Language.fromJson(json);

      expect(language.language, 'English');
      expect(language.proficiency, 'Fluent');
    });
  });

  group('CVSpec Model Tests', () {
    test('CVSpec.fromJson should parse complete data correctly', () {
      final json = {
        'profile': {
          'name': 'John Doe',
          'headline': 'Developer',
          'title': 'Senior Dev',
          'bio': 'Bio text',
          'location': 'Jakarta',
          'email': 'john@example.com',
          'phone': '+62123',
          'website': 'https://site.com',
          'avatarUrl': '',
          'backgroundUrl': '',
          'openToWork': true,
          'pronouns': 'He/Him',
          'connections': 100,
          'followers': 200,
          'socials': [],
        },
        'experience': [],
        'education': [],
        'skills': [
          {'name': 'Flutter', 'level': 'Expert', 'endorsements': 10},
        ],
        'projects': [],
        'certifications': [],
        'languages': [],
        'organizations': [],
        'awards': [],
        'publications': [],
        'volunteering': [],
        'recommendations': [],
        'interests': ['Coding', 'Gaming'],
      };

      final cvSpec = CVSpec.fromJson(json);

      expect(cvSpec.profile.name, 'John Doe');
      expect(cvSpec.skills.length, 1);
      expect(cvSpec.skills.first.name, 'Flutter');
      expect(cvSpec.interests.length, 2);
      expect(cvSpec.interests, contains('Coding'));
    });
  });
}
