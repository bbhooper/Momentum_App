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

  static EnergyLevel? fromStorage(String? value) {
    for (final level in values) {
      if (level.name == value) return level;
    }
    return null;
  }
}
