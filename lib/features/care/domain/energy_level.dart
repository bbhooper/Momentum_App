enum EnergyLevel {
  drained('Drained', 'Very little capacity', 'red'),
  flat('Flat', 'Running low', 'red'),
  okay('Okay', 'Some capacity', 'yellow'),
  good('Good', 'Good capacity', 'green'),
  energised('Energised', 'Plenty of capacity', 'green');

  const EnergyLevel(this.label, this.description, this.homeCareBand);

  final String label;
  final String description;
  final String homeCareBand;

  String get homeCareDemand {
    switch (this) {
      case EnergyLevel.drained:
      case EnergyLevel.flat:
        return 'low';
      case EnergyLevel.okay:
        return 'medium';
      case EnergyLevel.good:
      case EnergyLevel.energised:
        return 'high';
    }
  }

  static EnergyLevel? fromStorage(String? value) {
    for (final level in values) {
      if (level.name == value) return level;
    }
    return null;
  }
}
