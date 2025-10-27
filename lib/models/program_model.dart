class Program {
  final String id;
  final String title;
  final String description;
  final String? image;
  final String? role;
  final String duration;
  final String level;
  final String instructor;
  final List<String>? skills;
  final String? scholarship;
  final String? fee;
  final String? location;
  final String? lastDateToApply;
  final String? startdate;
  final String? enddate;
  final String? eligibility;

  Program({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    this.role,
    required this.duration,
    required this.level,
    required this.instructor,
    this.skills,
    this.scholarship,
    this.fee,
    this.location,
    this.lastDateToApply,
    this.startdate,
    this.enddate,
    this.eligibility,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'] ?? '0',
      title: json['title'] ?? 'Unknown Course',
      description: json['description'] ?? 'N/A',
      image: json['image'],
      role: json['role'] ?? 'N/A',
      duration: json['duration'] ?? 'N/A',
      level: json['level'] ?? 'N/A',
      instructor: json['instructor'] ?? 'N/A',
      skills: json['skills'] != null ? List<String>.from(json['skills']) : [],
      scholarship: json['scholarship'] ?? 'N/A',
      fee: json['fee'] ?? 'N/A',
      location: json['location'] ?? 'N/A',
      lastDateToApply: json['lastDateToApply'] ?? 'N/A',
      startdate: json['startdate'] ?? 'N/A',
      enddate: json['enddate'] ?? 'N/A',
      eligibility: json['eligibility'] ?? 'N/A',
    );
  }
}