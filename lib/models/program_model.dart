class Program {
  final String title;
  final String role;
  final String description;
  final String duration;
  final String scholarship;
  final String fee;
  final String location;
  final String lastDateToApply;
  final String startdate;
  final String enddate;
  final String eligibility;
  final List<String> skills;
  final String? image;

  Program({
    required this.title,
    required this.role,
    required this.description,
    required this.duration,
    required this.scholarship,
    required this.fee,
    required this.location,
    required this.lastDateToApply,
    required this.startdate,
    required this.enddate,
    required this.eligibility,
    required this.skills,
    this.image,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      title: json['title'] as String? ?? '',
      role: json['role'] as String? ?? '',
      description: json['description'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      scholarship: json['scholarship'] as String? ?? '',
      fee: json['fee'] as String? ?? '',
      location: json['location'] as String? ?? '',
      lastDateToApply: json['lastDateToApply'] as String? ?? '',
      startdate: json['startdate'] as String? ?? '',
      enddate: json['enddate'] as String? ?? '',
      eligibility: json['eligibility'] as String? ?? '',
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => e?.toString() ?? '')
              .where((s) => s.isNotEmpty)
              .toList() ??
          <String>[],
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'role': role,
      'description': description,
      'duration': duration,
      'scholarship': scholarship,
      'fee': fee,
      'location': location,
      'lastDateToApply': lastDateToApply,
      'startdate': startdate,
      'enddate': enddate,
      'eligibility': eligibility,
      'skills': skills,
      'image': image,
    };
  }
}