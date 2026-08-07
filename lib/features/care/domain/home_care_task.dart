class HomeCareTask {
  const HomeCareTask({
    required this.id,
    required this.key,
    required this.title,
    required this.userDemandLevel,
    required this.sortOrder,
    required this.isDefault,
  });

  final int id;

  /// Stable identity independent of title.
  final String key;

  final String title;

  /// User-assigned expected demand: low, medium, or high.
  final String userDemandLevel;

  final int sortOrder;
  final bool isDefault;

  /// Retained while the v7 completion band's historical field still exists.
  String get legacyBand {
    switch (userDemandLevel) {
      case 'low':
        return 'red';
      case 'medium':
        return 'yellow';
      case 'high':
        return 'green';
      default:
        return 'yellow';
    }
  }
}

class HomeCareTaskSeed {
  const HomeCareTaskSeed({
    required this.key,
    required this.title,
    required this.userDemandLevel,
    required this.sortOrder,
  });

  final String key;
  final String title;
  final String userDemandLevel;
  final int sortOrder;
}

const defaultHomeCareTaskSeeds = <HomeCareTaskSeed>[
  HomeCareTaskSeed(
    key: 'red_water',
    title: 'Refill your water',
    userDemandLevel: 'low',
    sortOrder: 10,
  ),
  HomeCareTaskSeed(
    key: 'red_dishes',
    title: 'Take dishes to the kitchen',
    userDemandLevel: 'low',
    sortOrder: 20,
  ),
  HomeCareTaskSeed(
    key: 'red_surface',
    title: 'Clear one small surface',
    userDemandLevel: 'low',
    sortOrder: 30,
  ),
  HomeCareTaskSeed(
    key: 'yellow_dishes',
    title: 'Wash or load the dishes',
    userDemandLevel: 'medium',
    sortOrder: 40,
  ),
  HomeCareTaskSeed(
    key: 'yellow_laundry',
    title: 'Start or fold one load of laundry',
    userDemandLevel: 'medium',
    sortOrder: 50,
  ),
  HomeCareTaskSeed(
    key: 'yellow_reset',
    title: 'Do a 10-minute room reset',
    userDemandLevel: 'medium',
    sortOrder: 60,
  ),
  HomeCareTaskSeed(
    key: 'green_kitchen',
    title: 'Reset the kitchen',
    userDemandLevel: 'high',
    sortOrder: 70,
  ),
  HomeCareTaskSeed(
    key: 'green_laundry',
    title: 'Complete one load of laundry',
    userDemandLevel: 'high',
    sortOrder: 80,
  ),
  HomeCareTaskSeed(
    key: 'green_clean',
    title: 'Clean one room or zone',
    userDemandLevel: 'high',
    sortOrder: 90,
  ),
];
