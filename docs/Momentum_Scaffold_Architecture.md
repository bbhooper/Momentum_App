# Momentum Flutter Project Scaffold Specification

| Field | Value |
|---|---|
| Document status | Approved for scaffold generation |
| Purpose | Define the folder and file structure only |
| Application | Momentum |
| Target framework | Flutter |
| State management | Riverpod |
| Persistence | Drift |
| Navigation | go_router |
| Scope | Project scaffolding only |
| Implementation status | No feature implementation permitted |

---

# 1. Instruction to the AI Coding Agent

Create the Flutter project folder and file structure described in this document.

This task is **scaffolding only**.

Do not build the application.

Do not implement feature behaviour.

Do not invent data models, business rules, calculations, database schemas, workflows, or UI designs.

When information is not defined in this document, create a minimal placeholder or a TODO comment.

The purpose of the generated files is to establish a clean project structure that will be implemented feature by feature later.

---

# 2. Hard Scope Boundary

The AI coding agent must only:

- Create folders
- Create named Dart files
- Create minimal compilable placeholder classes where required
- Add basic imports only where necessary
- Add TODO comments describing future responsibility
- Update `pubspec.yaml` only with the approved foundational packages
- Create a minimal app shell that compiles
- Create placeholder routes and placeholder pages
- Create empty repository contracts
- Create empty domain entities only when explicitly listed
- Create placeholder Riverpod providers only when explicitly listed
- Create test folders and placeholder test files

The AI coding agent must not:

- Implement logging workflows
- Implement database tables
- Implement Drift DAOs
- Implement database migrations
- Implement save, update, or delete behaviour
- Implement XP or AP calculations
- Implement levels
- Implement streaks
- Implement quest generation
- Implement Physical Load
- Implement Recovery Readiness
- Implement insight calculations
- Implement correlations
- Implement backup or restore logic
- Implement diary generation
- Implement medication logic
- Implement cycle calculations
- Implement UC calculations
- Implement notifications
- Implement Health Connect
- Create mock user data
- Create seed data
- Create arbitrary enums or score ranges
- Create a `DailySnapshot` model
- Create a global model containing mood, sleep, hydration, training, or other unrelated feature data
- Use `ChangeNotifier`
- Use Provider package state management
- Use Bloc
- Use GetX
- Use a service locator
- Create feature logic in widgets
- Create a generic global `models` folder for feature models
- Create a generic global `repositories` folder for feature repositories
- Invent package choices beyond those approved here
- Add visual design beyond a plain placeholder screen
- Continue implementing after the scaffold compiles

If the AI coding agent believes additional implementation is necessary, it must add a TODO comment instead of implementing it.

---

# 3. Approved Foundational Dependencies

Add only these packages unless they already exist:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod:
  go_router:
  drift:
  sqlite3_flutter_libs:
  path_provider:
  path:
  intl:

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints:
  build_runner:
  drift_dev:
  riverpod_generator:
  riverpod_lint:
  custom_lint:
```

Do not add:

- `provider`
- `bloc`
- `flutter_bloc`
- `get`
- `get_it`
- `hive`
- `isar`
- chart packages
- notification packages
- export packages
- Health Connect packages
- code-generation packages other than those listed

Package versions may be selected based on the current compatible stable Flutter environment.

Do not run feature code generation unless required for the minimal scaffold to compile.

---

# 4. Architectural Rules

## 4.1 Feature-First Structure

All feature-specific files must live inside their feature folder.

Example:

```text
lib/features/sleep/
```

Sleep files must not be placed in:

```text
lib/models/
lib/repositories/
lib/controllers/
lib/screens/
```

Those global feature-type folders must not be created.

## 4.2 Layer Direction

The intended dependency direction is:

```text
Presentation → Domain
Data → Domain
```

The domain layer must not import:

- Flutter widgets
- Riverpod
- Drift
- go_router

The presentation layer must not directly access Drift.

The data layer must not import presentation files.

During scaffolding, no cross-layer implementation is required.

## 4.3 Home Is Read-Only Aggregation

The Home feature will eventually display data from other features.

For this scaffold:

- Do not create `DailySnapshot`
- Do not create `DailySnapshotRepository`
- Do not create `saveToday`
- Do not make Home own mood, sleep, hydration, training, medication, cycle, or UC data
- Do not implement a Home aggregation service
- Create only a placeholder `HomePage`
- Create only a placeholder `HomeSummary` domain entity
- Create only a placeholder `HomeController` using Riverpod

## 4.4 Riverpod Only

Do not use:

```dart
extends ChangeNotifier
```

Do not import:

```dart
package:flutter/foundation.dart
```

for state management.

Placeholder controllers must use Riverpod.

Where code generation would create unnecessary scaffold complexity, use plain `Provider`, `FutureProvider`, `NotifierProvider`, or `AsyncNotifierProvider` placeholders.

Controllers must not contain feature behaviour.

## 4.5 Date Handling

Do not pass dates as arbitrary strings in public domain APIs.

Create a shared `LocalDate` value object placeholder under:

```text
lib/core/time/local_date.dart
```

For scaffolding, this type may wrap year, month, and day only.

Do not implement timezone conversion or rollover logic yet.

## 4.6 Repository Contracts

Repository contracts belong in each feature’s domain layer.

Example:

```text
lib/features/sleep/domain/repositories/sleep_repository.dart
```

For scaffolding, repository interfaces must contain no methods unless a method is explicitly listed in this document.

Prefer an empty abstract interface with a TODO comment over invented CRUD methods.

## 4.7 Data Layer

Create data-layer folders and placeholder files only.

Do not define Drift tables or DAOs yet.

Each feature data layer may contain:

```text
data/
├── repositories/
└── README.md
```

Do not create empty `models`, `tables`, `daos`, or `mappers` folders unless a file is explicitly required.

## 4.8 Minimal Files

Do not create dozens of speculative files.

Create only the files listed in this document.

Do not create files for concepts not listed.

Do not add implementation simply to make a file appear useful.

---

# 5. Required Top-Level Project Structure

Create or retain this structure:

```text
momentum/
├── android/
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
├── assets/
│   ├── animations/
│   ├── icons/
│   ├── illustrations/
│   └── images/
├── docs/
├── integration_test/
├── lib/
├── test/
├── pubspec.yaml
├── analysis_options.yaml
├── README.md
└── CHANGELOG.md
```

Do not add application content to asset folders.

Add `.gitkeep` files where required to retain empty asset directories.

---

# 6. Required `lib/` Structure

Create exactly this first-level structure:

```text
lib/
├── main.dart
├── bootstrap.dart
├── app/
├── core/
├── shared/
└── features/
```

---

# 7. Required App Files

Create:

```text
lib/app/
├── momentum_app.dart
├── app_shell.dart
└── providers/
    ├── app_initialisation_provider.dart
    ├── current_day_provider.dart
    └── enabled_features_provider.dart
```

## 7.1 `main.dart`

Responsibilities:

- Call `bootstrap`
- Contain no feature logic

## 7.2 `bootstrap.dart`

Responsibilities:

- Wrap the app in `ProviderScope`
- Run the app
- Contain a TODO for future startup initialisation
- Contain no database initialisation logic yet

## 7.3 `momentum_app.dart`

Responsibilities:

- Return `MaterialApp.router`
- Use the app router
- Use placeholder theme configuration
- Contain no feature logic

## 7.4 `app_shell.dart`

Responsibilities:

- Provide the bottom-navigation shell
- Render the current child route
- Include the seven required bottom destinations:
  - Home
  - Sleep
  - Fuel
  - Care
  - Move
  - Rewards
  - Diary

Use plain labels and standard Flutter icons.

Do not design custom navigation visuals.

## 7.5 App Providers

Create minimal providers only.

### `app_initialisation_provider.dart`

Create a placeholder provider that completes successfully.

Do not initialise the database.

### `current_day_provider.dart`

Expose the current `LocalDate`.

Do not implement rollover detection.

### `enabled_features_provider.dart`

Expose a placeholder immutable configuration indicating that:

- Cycle is disabled
- Medication is disabled
- UC is disabled

Do not persist these settings.

---

# 8. Required Core Structure

Create:

```text
lib/core/
├── config/
│   └── app_config.dart
├── constants/
│   └── app_constants.dart
├── database/
│   ├── app_database.dart
│   └── README.md
├── errors/
│   └── app_failure.dart
├── navigation/
│   ├── app_router.dart
│   └── route_names.dart
├── services/
│   ├── backup_service.dart
│   ├── export_service.dart
│   ├── notification_service.dart
│   └── rollover_service.dart
├── theme/
│   ├── app_theme.dart
│   └── app_theme_data.dart
├── time/
│   ├── app_clock.dart
│   └── local_date.dart
├── types/
│   └── feature_flags.dart
├── utils/
│   └── result.dart
└── validation/
    └── validation_result.dart
```

## 8.1 Core File Requirements

### `app_database.dart`

Create only a placeholder class.

Do not annotate it as a Drift database.

Do not define tables.

Add a TODO explaining that Drift schema will be added after database design approval.

### Service Files

Each service file must contain an abstract interface only.

Do not add methods.

Example shape:

```dart
abstract interface class BackupService {
  // TODO: Define after backup format is approved.
}
```

### `app_failure.dart`

Create a sealed or abstract base failure type and empty named subclasses:

- ValidationFailure
- DatabaseFailure
- MigrationFailure
- BackupFailure
- RestoreFailure
- ExportFailure
- NotificationFailure
- PermissionFailure

Do not add error-mapping logic.

### `local_date.dart`

Create a minimal immutable type with:

- `year`
- `month`
- `day`
- Equality
- A factory from `DateTime`

Do not implement formatting rules beyond an optional ISO-style `toString`.

### `app_clock.dart`

Create:

```dart
abstract interface class AppClock {
  DateTime now();
}
```

Also create a minimal system implementation in the same file.

### `feature_flags.dart`

Create an immutable type containing:

- `cycleEnabled`
- `medicationEnabled`
- `ucEnabled`

No persistence logic.

### `result.dart`

Create a minimal generic success/failure result type only if required to compile future interfaces.

Do not use it elsewhere yet.

---

# 9. Required Shared Structure

Create:

```text
lib/shared/
├── dialogs/
│   └── placeholder_dialog.dart
├── forms/
│   └── placeholder_form_field.dart
├── widgets/
│   ├── momentum_scaffold.dart
│   ├── page_header.dart
│   ├── placeholder_page.dart
│   └── section_card.dart
└── charts/
    └── README.md
```

These widgets must be visually minimal.

Do not implement final colours, animations, gradients, metallic borders, charts, or gamification visuals.

`PlaceholderPage` may accept:

- Title
- Optional description

This widget may be used by unimplemented feature pages.

---

# 10. Required Feature Structure

Create these feature folders:

```text
lib/features/
├── home/
├── sleep/
├── fuel/
├── care/
├── move/
├── rewards/
├── diary/
├── quests/
├── gamification/
├── insights/
├── settings/
├── cycle/
├── medication/
└── uc/
```

Each feature must follow only the explicitly listed structure below.

Do not create additional feature files.

---

# 11. Home Feature

Create:

```text
lib/features/home/
├── domain/
│   └── entities/
│       └── home_summary.dart
└── presentation/
    ├── controllers/
    │   └── home_controller.dart
    ├── pages/
    │   └── home_page.dart
    └── providers/
        └── home_providers.dart
```

Requirements:

- `HomeSummary` must be an empty immutable placeholder or contain only a TODO.
- `HomeController` must use Riverpod.
- `HomeController` must not save data.
- `HomeController` must not import repositories from Sleep, Fuel, Care, Move, Medication, Cycle, or UC.
- `HomeController` must not create a snapshot.
- `HomePage` must display placeholder content only.
- `home_providers.dart` may expose a placeholder `HomeSummary`.

Forbidden Home files:

```text
daily_snapshot.dart
daily_snapshot_repository.dart
home_repository.dart
home_service.dart
```

---

# 12. Sleep Feature

Create:

```text
lib/features/sleep/
├── data/
│   ├── repositories/
│   │   └── drift_sleep_repository.dart
│   └── README.md
├── domain/
│   ├── entities/
│   │   ├── sleep_entry.dart
│   │   └── nap_entry.dart
│   └── repositories/
│       └── sleep_repository.dart
└── presentation/
    ├── controllers/
    │   └── sleep_controller.dart
    ├── pages/
    │   ├── sleep_page.dart
    │   ├── sleep_log_page.dart
    │   ├── sleep_history_page.dart
    │   └── naps_page.dart
    └── providers/
        └── sleep_providers.dart
```

Requirements:

- Domain entities are empty immutable placeholders.
- Repository interface contains no methods.
- Drift repository contains no database logic.
- Controller contains no logging logic.
- Pages display placeholders only.

---

# 13. Fuel Feature

Create:

```text
lib/features/fuel/
├── hydration/
│   ├── domain/
│   │   ├── entities/
│   │   │   └── hydration_entry.dart
│   │   └── repositories/
│   │       └── hydration_repository.dart
│   └── presentation/
│       ├── controllers/
│       │   └── hydration_controller.dart
│       └── pages/
│           └── hydration_page.dart
├── food/
│   ├── domain/
│   │   ├── entities/
│   │   │   └── food_entry.dart
│   │   └── repositories/
│   │       └── food_repository.dart
│   └── presentation/
│       ├── controllers/
│       │   └── food_controller.dart
│       └── pages/
│           └── food_page.dart
├── sugar/
│   ├── domain/
│   │   ├── entities/
│   │   │   └── sugar_entry.dart
│   │   └── repositories/
│   │       └── sugar_repository.dart
│   └── presentation/
│       ├── controllers/
│       │   └── sugar_controller.dart
│       └── pages/
│           └── sugar_page.dart
└── presentation/
    └── pages/
        └── fuel_page.dart
```

Do not implement hydration targets, rewards, food scoring, or sugar rules.

---

# 14. Care Feature

Create:

```text
lib/features/care/
├── mood/
│   ├── domain/
│   │   ├── entities/
│   │   │   └── mood_entry.dart
│   │   └── repositories/
│   │       └── mood_repository.dart
│   └── presentation/
│       ├── controllers/
│       │   └── mood_controller.dart
│       └── pages/
│           └── mood_page.dart
├── home_care/
│   ├── domain/
│   │   ├── entities/
│   │   │   └── home_care_entry.dart
│   │   └── repositories/
│   │       └── home_care_repository.dart
│   └── presentation/
│       ├── controllers/
│       │   └── home_care_controller.dart
│       └── pages/
│           └── home_care_page.dart
└── presentation/
    └── pages/
        └── care_page.dart
```

The Care page may link to placeholder pages for Mood, Home Care, Cycle, Medication, and UC.

Do not implement feature-toggle behaviour beyond hiding or showing placeholder links.

---

# 15. Move Feature

Create:

```text
lib/features/move/
├── training/
│   ├── domain/
│   │   ├── entities/
│   │   │   └── training_entry.dart
│   │   └── repositories/
│   │       └── training_repository.dart
│   └── presentation/
│       ├── controllers/
│       │   └── training_controller.dart
│       └── pages/
│           └── training_page.dart
├── life_activity/
│   ├── domain/
│   │   ├── entities/
│   │   │   └── life_activity_entry.dart
│   │   └── repositories/
│   │       └── life_activity_repository.dart
│   └── presentation/
│       ├── controllers/
│       │   └── life_activity_controller.dart
│       └── pages/
│           └── life_activity_page.dart
├── physical_load/
│   └── domain/
│       ├── entities/
│       │   └── physical_load_result.dart
│       └── services/
│           └── physical_load_calculator.dart
└── presentation/
    └── pages/
        └── move_page.dart
```

`PhysicalLoadCalculator` must be an empty interface or class with a TODO.

Do not implement scoring.

---

# 16. Rewards Feature

Create:

```text
lib/features/rewards/
├── domain/
│   ├── entities/
│   │   ├── reward_item.dart
│   │   └── reward_purchase.dart
│   └── repositories/
│       └── rewards_repository.dart
└── presentation/
    ├── controllers/
    │   └── rewards_controller.dart
    ├── pages/
    │   └── rewards_page.dart
    └── providers/
        └── rewards_providers.dart
```

Do not implement AP deduction, purchasing, inventory, or reward values.

---

# 17. Diary Feature

Create:

```text
lib/features/diary/
├── domain/
│   ├── entities/
│   │   └── diary_entry.dart
│   ├── repositories/
│   │   └── diary_repository.dart
│   └── services/
│       └── diary_generator.dart
└── presentation/
    ├── controllers/
    │   └── diary_controller.dart
    ├── pages/
    │   ├── diary_page.dart
    │   ├── diary_preview_page.dart
    │   └── diary_history_page.dart
    └── providers/
        └── diary_providers.dart
```

Do not generate diary text.

Do not read other feature repositories.

---

# 18. Quests Feature

Create:

```text
lib/features/quests/
├── domain/
│   ├── entities/
│   │   ├── quest.dart
│   │   └── quest_generation_context.dart
│   ├── repositories/
│   │   └── quest_repository.dart
│   └── services/
│       └── quest_generator.dart
└── presentation/
    ├── controllers/
    │   └── quest_controller.dart
    └── providers/
        └── quest_providers.dart
```

Do not create quest rules, categories, XP values, rerolls, or generation behaviour.

---

# 19. Gamification Feature

Create:

```text
lib/features/gamification/
├── domain/
│   ├── entities/
│   │   ├── progression_state.dart
│   │   ├── award_request.dart
│   │   ├── award_transaction.dart
│   │   └── streak_state.dart
│   ├── repositories/
│   │   └── gamification_repository.dart
│   └── services/
│       ├── award_service.dart
│       ├── level_calculator.dart
│       └── streak_service.dart
└── presentation/
    └── providers/
        └── gamification_providers.dart
```

All entities must remain placeholders.

Do not define XP, AP, levels, curves, streak rules, or award values.

---

# 20. Insights Feature

Create:

```text
lib/features/insights/
├── domain/
│   ├── engine/
│   │   └── analytics_engine.dart
│   ├── entities/
│   │   ├── insight_result.dart
│   │   └── data_maturity_state.dart
│   └── services/
│       └── daily_analytics_dataset_builder.dart
└── presentation/
    ├── pages/
    │   ├── insights_page.dart
    │   ├── weekly_insights_page.dart
    │   ├── monthly_insights_page.dart
    │   ├── patterns_page.dart
    │   └── compare_page.dart
    └── providers/
        └── insights_providers.dart
```

Do not implement:

- Trends
- Correlations
- Lagged analysis
- Chart data
- Thresholds
- Sample-size rules
- Confidence labels
- Health conclusions

---

# 21. Settings Feature

Create:

```text
lib/features/settings/
├── domain/
│   ├── entities/
│   │   └── app_settings.dart
│   └── repositories/
│       └── settings_repository.dart
└── presentation/
    ├── controllers/
    │   └── settings_controller.dart
    ├── pages/
    │   └── settings_page.dart
    └── providers/
        └── settings_providers.dart
```

`AppSettings` may contain only the three optional feature flags.

Do not implement persistence, notifications, work schedules, hydration goals, boxing days, themes, or quiet hours.

---

# 22. Cycle Feature

Create:

```text
lib/features/cycle/
├── domain/
│   ├── entities/
│   │   ├── period_entry.dart
│   │   └── cycle_context.dart
│   ├── repositories/
│   │   └── cycle_repository.dart
│   └── services/
│       └── cycle_estimator.dart
└── presentation/
    ├── controllers/
    │   └── cycle_controller.dart
    ├── pages/
    │   └── cycle_page.dart
    └── providers/
        └── cycle_providers.dart
```

Do not implement phase estimates or cycle calculations.

---

# 23. Medication Feature

Create:

```text
lib/features/medication/
├── domain/
│   ├── entities/
│   │   ├── medication.dart
│   │   ├── medication_schedule.dart
│   │   └── medication_dose.dart
│   ├── repositories/
│   │   └── medication_repository.dart
│   └── services/
│       └── medication_stock_service.dart
└── presentation/
    ├── controllers/
    │   └── medication_controller.dart
    ├── pages/
    │   └── medication_page.dart
    └── providers/
        └── medication_providers.dart
```

Do not implement schedules, reminders, stock reduction, adherence, or low-stock rules.

---

# 24. UC Feature

Create:

```text
lib/features/uc/
├── domain/
│   ├── entities/
│   │   ├── bowel_movement_entry.dart
│   │   ├── uc_daily_entry.dart
│   │   └── uc_flare.dart
│   ├── repositories/
│   │   └── uc_repository.dart
│   └── services/
│       └── uc_summary_service.dart
└── presentation/
    ├── controllers/
    │   └── uc_controller.dart
    ├── pages/
    │   └── uc_page.dart
    └── providers/
        └── uc_providers.dart
```

Do not implement symptom scoring, flare detection, medical thresholds, Bristol values, blood levels, trigger detection, or recommendations.

---

# 25. Router Requirements

Create routes for:

```text
/home
/sleep
/sleep/log
/sleep/history
/sleep/naps
/fuel
/fuel/hydration
/fuel/food
/fuel/sugar
/care
/care/mood
/care/home-care
/care/cycle
/care/medication
/care/uc
/move
/move/training
/move/life-activity
/rewards
/diary
/diary/preview
/diary/history
/insights
/insights/weekly
/insights/monthly
/insights/patterns
/insights/compare
/settings
```

Requirements:

- Bottom navigation uses a go_router shell route.
- All routes render placeholder pages.
- No route loads data.
- No route performs feature-toggle redirects yet.
- Route names belong in `route_names.dart`.
- Do not add deep-link handling.
- Do not add notification handling.

---

# 26. Required Test Structure

Create:

```text
test/
├── app/
│   └── momentum_app_test.dart
├── core/
│   ├── navigation/
│   │   └── app_router_test.dart
│   └── time/
│       └── local_date_test.dart
└── features/
    ├── home/
    │   └── home_page_test.dart
    ├── sleep/
    │   └── sleep_page_test.dart
    ├── fuel/
    │   └── fuel_page_test.dart
    ├── care/
    │   └── care_page_test.dart
    ├── move/
    │   └── move_page_test.dart
    ├── rewards/
    │   └── rewards_page_test.dart
    └── diary/
        └── diary_page_test.dart
```

Tests may only verify that:

- The app starts
- Routes resolve
- Placeholder pages render
- `LocalDate` stores the expected date

Do not test feature behaviour because none should exist.

Create:

```text
integration_test/
└── app_launch_test.dart
```

The integration test may only verify that the app launches.

---

# 27. Placeholder Controller Pattern

Use Riverpod.

A permitted placeholder controller pattern is:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExampleController extends Notifier<void> {
  @override
  void build() {
    // TODO: Implement feature behaviour after design approval.
  }
}

final exampleControllerProvider =
    NotifierProvider<ExampleController, void>(
  ExampleController.new,
);
```

An `AsyncNotifier` may be used only when necessary for a placeholder loading state.

Controllers must not:

- Instantiate repositories directly
- Call constructors such as `Repository()`
- Save feature data
- Load fake data
- Combine unrelated features
- Accept a date string
- Call `notifyListeners`

---

# 28. Placeholder Repository Pattern

Use:

```dart
abstract interface class ExampleRepository {
  // TODO: Define repository operations after data design approval.
}
```

A permitted placeholder implementation is:

```dart
final class DriftExampleRepository implements ExampleRepository {
  // TODO: Implement after Drift schema approval.
}
```

Do not add CRUD methods.

Do not instantiate the implementation inside controllers.

---

# 29. Placeholder Entity Pattern

Use an immutable, minimal class.

Example:

```dart
final class ExampleEntry {
  const ExampleEntry();
}
```

Or:

```dart
final class ExampleEntry {
  // TODO: Define fields after feature data design approval.
  const ExampleEntry();
}
```

Do not invent fields.

Exceptions:

- `LocalDate`
- `FeatureFlags`
- `AppSettings`, limited to approved feature flags

---

# 30. Placeholder Page Pattern

A feature page may be:

```dart
import 'package:flutter/material.dart';

import '../../../../shared/widgets/placeholder_page.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPage(
      title: 'Example',
      description: 'This feature will be implemented in a later phase.',
    );
  }
}
```

Do not create forms.

Do not create save buttons.

Do not create health score selectors.

Do not create charts.

Do not create sample records.

---

# 31. File Naming Rules

Use:

- `snake_case.dart` for files
- `UpperCamelCase` for classes
- `lowerCamelCaseProvider` for providers
- One primary public class per file
- Feature name prefixes only where they improve clarity

Do not use vague names such as:

```text
helper.dart
manager.dart
common.dart
misc.dart
data.dart
utils.dart
base.dart
```

unless the file is explicitly listed in this document.

---

# 32. Import Rules

Prefer package imports for cross-feature and core imports:

```dart
import 'package:momentum/core/time/local_date.dart';
```

Relative imports may be used within the same small feature subtree.

Do not import one feature’s `data` layer into another feature.

Do not import feature pages into domain code.

Do not create barrel files during scaffolding.

---

# 33. README Requirements

Update the root `README.md` to state:

- Momentum is under active development
- The current codebase contains architecture scaffolding only
- Features are intentionally unimplemented
- `docs/Requirements.md` defines product behaviour
- `docs/Architecture.md` defines full architecture
- This scaffold specification defines generated folders and files

Create a short `README.md` inside placeholder data or chart folders only where this document specifies one.

---

# 34. Completion Checks

Before stopping, the AI coding agent must verify:

- The project compiles
- `flutter analyze` passes, excluding generated-environment warnings outside the scaffold
- Scaffold tests pass
- Bottom navigation loads the seven placeholder pages
- No `ChangeNotifier` exists
- No `DailySnapshot` exists
- No repository is directly instantiated inside a controller
- No Drift tables exist
- No business formulas exist
- No feature save method exists
- No sample health data exists
- No feature model combines unrelated modules
- Only approved packages were added
- All required files exist
- No unrequested files were added

---

# 35. Required Final Response from the AI Coding Agent

After creating the scaffold, respond with only:

1. A concise summary of folders created
2. A list of foundational packages added
3. Confirmation that the project compiles
4. Confirmation that no feature logic was implemented
5. Any scaffold-only issues that prevented compilation

Do not continue implementing features.

Do not propose or begin the next phase automatically.

---

# 36. Stop Condition

The task is complete when:

- The exact folder structure is present
- The listed placeholder files exist
- The app launches to placeholder navigation
- The scaffold compiles
- Scaffold tests pass
- No business or persistence implementation has been added

At that point, stop.

The next implementation task will be provided separately and will cover one vertical feature slice at a time.
