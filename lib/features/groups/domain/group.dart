class Group {
  final String id;
  final String name;
  final String imageUrl;
  final int members;
  final bool isMember;

  Group({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.members,
    this.isMember = false,
  });
}

class GroupCategory {
  final String id;
  final String name;
  final String icon;
  final String description;

  GroupCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
} 