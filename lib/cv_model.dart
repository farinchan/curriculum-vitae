class CVSpec {
  final Profile profile;
  final List<Experience> experience;
  final List<Education> education;
  final List<Skill> skills;
  final List<Project> projects;
  final List<Certification> certifications;
  final List<Language> languages;
  final List<Organization> organizations;
  final List<Award> awards;
  final List<Publication> publications;
  final List<Volunteering> volunteering;
  final List<Recommendation> recommendations;
  final List<String> interests;

  CVSpec({
    required this.profile,
    required this.experience,
    required this.education,
    required this.skills,
    required this.projects,
    required this.certifications,
    required this.languages,
    required this.organizations,
    required this.awards,
    required this.publications,
    required this.volunteering,
    required this.recommendations,
    required this.interests,
  });

  factory CVSpec.fromJson(Map<String, dynamic> json) {
    return CVSpec(
      profile: Profile.fromJson(json['profile']),
      experience: (json['experience'] as List).map((e) => Experience.fromJson(e)).toList(),
      education: (json['education'] as List).map((e) => Education.fromJson(e)).toList(),
      skills: (json['skills'] as List).map((e) => Skill.fromJson(e)).toList(),
      projects: (json['projects'] as List).map((e) => Project.fromJson(e)).toList(),
      certifications: (json['certifications'] as List).map((e) => Certification.fromJson(e)).toList(),
      languages: (json['languages'] as List).map((e) => Language.fromJson(e)).toList(),
      organizations: (json['organizations'] as List).map((e) => Organization.fromJson(e)).toList(),
      awards: (json['awards'] as List).map((e) => Award.fromJson(e)).toList(),
      publications: (json['publications'] as List?)?.map((e) => Publication.fromJson(e)).toList() ?? [],
      volunteering: (json['volunteering'] as List?)?.map((e) => Volunteering.fromJson(e)).toList() ?? [],
      recommendations: (json['recommendations'] as List?)?.map((e) => Recommendation.fromJson(e)).toList() ?? [],
      interests: List<String>.from(json['interests'] ?? []),
    );
  }
}

class Profile {
  final String name;
  final String headline;
  final String title;
  final String bio;
  final String location;
  final String email;
  final String phone;
  final String website;
  final String avatarUrl;
  final String backgroundUrl;
  final bool openToWork;
  final String pronouns;
  final int connections;
  final int followers;
  final List<Social> socials;

  Profile({
    required this.name,
    required this.headline,
    required this.title,
    required this.bio,
    required this.location,
    required this.email,
    required this.phone,
    required this.website,
    required this.avatarUrl,
    required this.backgroundUrl,
    required this.openToWork,
    required this.pronouns,
    required this.connections,
    required this.followers,
    required this.socials,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] ?? '',
      headline: json['headline'] ?? '',
      title: json['title'] ?? '',
      bio: json['bio'] ?? '',
      location: json['location'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      backgroundUrl: json['backgroundUrl'] ?? '',
      openToWork: json['openToWork'] ?? false,
      pronouns: json['pronouns'] ?? '',
      connections: json['connections'] ?? 0,
      followers: json['followers'] ?? 0,
      socials: (json['socials'] as List?)?.map((e) => Social.fromJson(e)).toList() ?? [],
    );
  }
}

class Social {
  final String platform;
  final String url;
  final String icon;

  Social({required this.platform, required this.url, required this.icon});

  factory Social.fromJson(Map<String, dynamic> json) {
    return Social(platform: json['platform'] ?? '', url: json['url'] ?? '', icon: json['icon'] ?? '');
  }
}

class Experience {
  final String role;
  final String company;
  final String companyLogoUrl;
  final String location;
  final String locationType;
  final String employmentType;
  final String startDate;
  final String endDate;
  final String description;
  final List<String> highlights;
  final List<String> skills;

  Experience({
    required this.role,
    required this.company,
    required this.companyLogoUrl,
    required this.location,
    required this.locationType,
    required this.employmentType,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.highlights,
    required this.skills,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      role: json['role'] ?? '',
      company: json['company'] ?? '',
      companyLogoUrl: json['companyLogoUrl'] ?? '',
      location: json['location'] ?? '',
      locationType: json['locationType'] ?? '',
      employmentType: json['employmentType'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      description: json['description'] ?? '',
      highlights: List<String>.from(json['highlights'] ?? []),
      skills: List<String>.from(json['skills'] ?? []),
    );
  }
}

class Education {
  final String degree;
  final String fieldOfStudy;
  final String institution;
  final String logoUrl;
  final String location;
  final String startDate;
  final String endDate;
  final String gpa;
  final String maxGpa;
  final String description;
  final List<String> activities;
  final List<String> courses;

  Education({
    required this.degree,
    required this.fieldOfStudy,
    required this.institution,
    required this.logoUrl,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.gpa,
    required this.maxGpa,
    required this.description,
    required this.activities,
    required this.courses,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      degree: json['degree'] ?? '',
      fieldOfStudy: json['fieldOfStudy'] ?? '',
      institution: json['institution'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      location: json['location'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      gpa: json['gpa'] ?? '',
      maxGpa: json['maxGpa'] ?? '',
      description: json['description'] ?? '',
      activities: List<String>.from(json['activities'] ?? []),
      courses: List<String>.from(json['courses'] ?? []),
    );
  }
}

class Skill {
  final String name;
  final String level;
  final int endorsements;

  Skill({required this.name, required this.level, required this.endorsements});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(name: json['name'] ?? '', level: json['level'] ?? '', endorsements: json['endorsements'] ?? 0);
  }
}

class Project {
  final String name;
  final String description;
  final String imageUrl;
  final String link;
  final String demoUrl;
  final String startDate;
  final String endDate;
  final List<String> technologies;
  final List<String> highlights;

  Project({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.link,
    required this.demoUrl,
    required this.startDate,
    required this.endDate,
    required this.technologies,
    required this.highlights,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      link: json['link'] ?? '',
      demoUrl: json['demoUrl'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      technologies: List<String>.from(json['technologies'] ?? []),
      highlights: List<String>.from(json['highlights'] ?? []),
    );
  }
}

class Certification {
  final String name;
  final String issuer;
  final String issuerLogoUrl;
  final String issueDate;
  final String expirationDate;
  final String credentialId;
  final String credentialUrl;

  Certification({
    required this.name,
    required this.issuer,
    required this.issuerLogoUrl,
    required this.issueDate,
    required this.expirationDate,
    required this.credentialId,
    required this.credentialUrl,
  });

  factory Certification.fromJson(Map<String, dynamic> json) {
    return Certification(
      name: json['name'] ?? '',
      issuer: json['issuer'] ?? '',
      issuerLogoUrl: json['issuerLogoUrl'] ?? '',
      issueDate: json['issueDate'] ?? json['date'] ?? '',
      expirationDate: json['expirationDate'] ?? '',
      credentialId: json['credentialId'] ?? '',
      credentialUrl: json['credentialUrl'] ?? '',
    );
  }
}

class Language {
  final String language;
  final String proficiency;

  Language({required this.language, required this.proficiency});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(language: json['language'] ?? '', proficiency: json['proficiency'] ?? '');
  }
}

class Organization {
  final String role;
  final String name;
  final String logoUrl;
  final String startDate;
  final String endDate;
  final String description;

  Organization({
    required this.role,
    required this.name,
    required this.logoUrl,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      role: json['role'] ?? '',
      name: json['name'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? json['period'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Award {
  final String title;
  final String issuer;
  final String issuerLogoUrl;
  final String date;
  final String description;

  Award({
    required this.title,
    required this.issuer,
    required this.issuerLogoUrl,
    required this.date,
    required this.description,
  });

  factory Award.fromJson(Map<String, dynamic> json) {
    return Award(
      title: json['title'] ?? '',
      issuer: json['issuer'] ?? '',
      issuerLogoUrl: json['issuerLogoUrl'] ?? '',
      date: json['date'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Publication {
  final String title;
  final String publisher;
  final String publisherLogoUrl;
  final String date;
  final String url;
  final String description;

  Publication({
    required this.title,
    required this.publisher,
    required this.publisherLogoUrl,
    required this.date,
    required this.url,
    required this.description,
  });

  factory Publication.fromJson(Map<String, dynamic> json) {
    return Publication(
      title: json['title'] ?? '',
      publisher: json['publisher'] ?? '',
      publisherLogoUrl: json['publisherLogoUrl'] ?? '',
      date: json['date'] ?? '',
      url: json['url'] ?? json['link'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Volunteering {
  final String role;
  final String organization;
  final String logoUrl;
  final String startDate;
  final String endDate;
  final String cause;
  final String description;

  Volunteering({
    required this.role,
    required this.organization,
    required this.logoUrl,
    required this.startDate,
    required this.endDate,
    required this.cause,
    required this.description,
  });

  factory Volunteering.fromJson(Map<String, dynamic> json) {
    return Volunteering(
      role: json['role'] ?? '',
      organization: json['organization'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      cause: json['cause'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Recommendation {
  final String name;
  final String title;
  final String avatarUrl;
  final String relationship;
  final String date;
  final String text;

  Recommendation({
    required this.name,
    required this.title,
    required this.avatarUrl,
    required this.relationship,
    required this.date,
    required this.text,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      relationship: json['relationship'] ?? '',
      date: json['date'] ?? '',
      text: json['text'] ?? '',
    );
  }
}
