class TeamSummary {
  TeamSummary({
    required this.id,
    required this.name,
    required this.assignmentsTotal,
    required this.assignmentsCompleted,
    required this.assignmentsOverdue,
    required this.resources,
    required this.activities,
  });

  final String id;
  final String name;
  final int assignmentsTotal;
  final int assignmentsCompleted;
  final int assignmentsOverdue;
  final List<Resource> resources;
  final List<ActivityFeedItem> activities;
}

class Resource {
  Resource({
    required this.name,
    required this.allocated,
    required this.used,
  });

  final String name;
  int allocated;
  int used;
}


class ActivityFeedItem {
  ActivityFeedItem({
    required this.title,
    required this.timestamp,
  });

  final String title;
  final String timestamp;
}
