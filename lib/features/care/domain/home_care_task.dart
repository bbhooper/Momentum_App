class HomeCareTask {
  const HomeCareTask({
    required this.key,
    required this.title,
    required this.energyLevel,
  });

  final String key;
  final String title;
  final String energyLevel;
}

const defaultHomeCareTasks = <HomeCareTask>[
  HomeCareTask(
    key: 'red_water',
    title: 'Refill your water',
    energyLevel: 'red',
  ),
  HomeCareTask(
    key: 'red_dishes',
    title: 'Take dishes to the kitchen',
    energyLevel: 'red',
  ),
  HomeCareTask(
    key: 'red_surface',
    title: 'Clear one small surface',
    energyLevel: 'red',
  ),
  HomeCareTask(
    key: 'yellow_dishes',
    title: 'Wash or load the dishes',
    energyLevel: 'yellow',
  ),
  HomeCareTask(
    key: 'yellow_laundry',
    title: 'Start or fold one load of laundry',
    energyLevel: 'yellow',
  ),
  HomeCareTask(
    key: 'yellow_reset',
    title: 'Do a 10-minute room reset',
    energyLevel: 'yellow',
  ),
  HomeCareTask(
    key: 'green_kitchen',
    title: 'Reset the kitchen',
    energyLevel: 'green',
  ),
  HomeCareTask(
    key: 'green_laundry',
    title: 'Complete one load of laundry',
    energyLevel: 'green',
  ),
  HomeCareTask(
    key: 'green_clean',
    title: 'Clean one room or zone',
    energyLevel: 'green',
  ),
];
