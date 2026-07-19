# Momentum Flutter App — Requirements Checklist

## 0. Project Setup

- [ ] Create a real Flutter project using `flutter create momentum`
- [ ] Open the project root in VS Code
- [ ] Confirm the root contains:
  - [ ] `android/`
  - [ ] `ios/`
  - [ ] `lib/`
  - [ ] `test/`
  - [ ] `pubspec.yaml`
- [ ] Install Flutter and Dart VS Code extensions
- [ ] Run `flutter doctor`
- [ ] Run `flutter pub get`
- [ ] Connect an Android phone or emulator
- [ ] Run the default app successfully
- [ ] Confirm hot reload works
- [ ] Create GitHub repository
- [ ] Add `.gitignore`
- [ ] Establish versioning and release notes

---

# 1. Product Principles

- [ ] Support fluctuating energy and chronic-condition management
- [ ] Reward effort, not only perfect completion
- [ ] Avoid guilt-based or punitive language
- [ ] Separate structured training from demanding everyday activity
- [ ] Keep the interface calm, mature, elegant, and minimal
- [ ] Keep all core features usable offline
- [ ] Store user health data locally by default
- [ ] Make insights descriptive and transparent
- [ ] Do not present correlations as medical or causal conclusions
- [ ] Make advanced analytics optional and progressively unlocked by data volume

---

# 2. Core Navigation

Bottom navigation should include:

- [ ] Home
- [ ] Sleep
- [ ] Fuel
- [ ] Care
- [ ] Move
- [ ] Rewards
- [ ] Diary

Settings should be accessible from the app header.

---

# 3. Home Dashboard

## 3.1 Header

- [ ] Current date
- [ ] Level
- [ ] Total XP
- [ ] Spendable AP
- [ ] Current training phase
- [ ] Streak count
- [ ] Remaining quest rerolls
- [ ] Settings button
- [ ] End Day button

## 3.2 Today Summary

Display today's:

- [ ] Mood
- [ ] Sleep duration
- [ ] Sleep quality
- [ ] Energy
- [ ] Hydration
- [ ] Food log status
- [ ] Sugar level
- [ ] Nap count
- [ ] Physical Load
- [ ] Recovery Readiness
- [ ] Home-care task count
- [ ] Structured training progress
- [ ] Cycle phase when enabled
- [ ] Medications due today (when enabled)
- [ ] UC symptom summary today (when UC module is enabled)

## 3.3 Daily Quests

- [ ] Generate quests once per day
- [ ] Quests remain stable until the next day
- [ ] Diary generation must not reset the dashboard
- [ ] Generate quests based on energy:
  - [ ] Red
  - [ ] Yellow
  - [ ] Green
- [ ] Account for day type:
  - [ ] Office day
  - [ ] Work-from-home day
  - [ ] Weekend
- [ ] Office-day quests must remain low effort regardless of energy
- [ ] WFH quests should be easier than weekend quests
- [ ] Boxing quests only appear on configured boxing days
- [ ] Boxing quests never appear on office days
- [ ] Hydration quests always target the full daily hydration goal — not a reduced amount
- [ ] Allow individual quests to be checked and claimed
- [ ] Award XP and AP for each quest
- [ ] Award bonus XP and AP for completing all daily quests
- [ ] Show a completion celebration
- [ ] Support one free reroll per week
- [ ] Additional rerolls require a banked reroll item
- [ ] Rerolls can be purchased in the Reward Shop
- [ ] Track quest completion in the analytics dataset
- [ ] Cycle-aware quests when cycle tracking is enabled:
  - [ ] Menstruation: favour rest, gentle movement, hydration, iron-rich food nudges
  - [ ] Follicular: allow increasing effort, building quests
  - [ ] Ovulation: allow peak effort quests, boxing quests eligible
  - [ ] Luteal: reduce intensity expectations, add craving/protein nudges

## 3.4 Daily Recommendation

- [ ] Generate a rule-based daily recommendation
- [ ] Consider:
  - [ ] Energy
  - [ ] Sleep
  - [ ] Physical Load
  - [ ] Recovery Readiness
  - [ ] Workday type
  - [ ] Cycle phase when enabled
  - [ ] Medication status when enabled
- [ ] Recommend lighter activity after high Life Activity
- [ ] Avoid recommending hard training on low-readiness days
- [ ] Keep language supportive rather than prescriptive

---

# 4. Sleep

## 4.1 Sleep Log

- [ ] Bedtime
- [ ] Wake time
- [ ] Auto-calculate sleep duration
- [ ] Configurable or estimated sleep-onset adjustment
- [ ] Manual duration override
- [ ] Sleep quality score 1–5
- [ ] Energy score 1–5
- [ ] Notes
- [ ] Save sleep log
- [ ] Award XP and AP
- [ ] Prevent accidental duplicate rewards for repeated saves
- [ ] Store historical sleep entries

## 4.2 Naps

- [ ] Nap type:
  - [ ] Planned
  - [ ] Recovery
  - [ ] Unplanned
  - [ ] Multiple naps
- [ ] Duration
- [ ] Whether the user slept:
  - [ ] Yes
  - [ ] No, rested only
  - [ ] Unsure
- [ ] Notes
- [ ] Award XP and AP
- [ ] Show today's naps
- [ ] Show nap history
- [ ] Include naps in diary and insights
- [ ] Compare slept naps with rest-only naps

---

# 5. Fuel

## 5.1 Hydration

- [ ] Configurable daily hydration goal
- [ ] Quick-add amounts:
  - [ ] 250 ml
  - [ ] 500 ml
  - [ ] 750 ml
- [ ] Progress bar
- [ ] Milestone rewards
- [ ] Prevent duplicate milestone rewards
- [ ] Reset option
- [ ] Store daily hydration totals
- [ ] Include hydration in readiness and insights

## 5.2 Food

- [ ] Energy category:
  - [ ] Red
  - [ ] Yellow
  - [ ] Green
- [ ] Food details and notes
- [ ] Protein breakfast
- [ ] Protein at two meals
- [ ] Fruit or vegetables
- [ ] Avoided or reduced sugar spiral
- [ ] Ate before becoming ravenous
- [ ] Award XP and AP per positive behaviour
- [ ] Provide low-effort food ideas based on energy
- [ ] Food ideas adapt to cycle phase when enabled:
  - [ ] Menstruation: iron-rich, anti-inflammatory, magnesium nudges
  - [ ] Follicular: lighter meals, good protein, vegetables
  - [ ] Ovulation: hydration emphasis, protein and complex carbs
  - [ ] Luteal: protein-first framing, magnesium, complex carbs, craving context without shame
- [ ] Store historical food logs

## 5.3 Sugar Tracking

- [ ] Sugar level:
  - [ ] None
  - [ ] Low
  - [ ] Moderate
  - [ ] High
- [ ] Optional sugar notes
- [ ] Include sugar in:
  - [ ] Diary
  - [ ] Export
  - [ ] Correlations
  - [ ] Recovery Readiness
  - [ ] Pattern discovery

---

# 6. Care

## 6.1 Mood

- [ ] Mood score 1–5
- [ ] Emoji or visual scale
- [ ] Mood notes
- [ ] Award XP and AP
- [ ] Show mood history
- [ ] Include mood in insights and diary

## 6.2 Home Care

- [ ] Scale available tasks to current energy
- [ ] Red-day task list
- [ ] Yellow-day task list
- [ ] Green-day task list
- [ ] Allow custom task lists in Settings
- [ ] Reorder tasks
- [ ] Add tasks
- [ ] Remove tasks
- [ ] Reset to defaults
- [ ] Award XP and AP per completed task
- [ ] Save daily home-care summary
- [ ] Include home care in insights

## 6.3 Menstrual Cycle Tracking

Optional feature. Hidden unless enabled in Settings.

- [ ] Enable or disable in Settings → Features
- [ ] All UI is completely hidden when disabled
- [ ] Use correct clinical terms throughout:
  - [ ] Menstruation
  - [ ] Follicular
  - [ ] Ovulation
  - [ ] Luteal
- [ ] Log period start date
- [ ] Log period end date
- [ ] Flow:
  - [ ] Light
  - [ ] Medium
  - [ ] Heavy
- [ ] Pain:
  - [ ] None
  - [ ] Mild
  - [ ] Moderate
  - [ ] Severe
- [ ] Notes
- [ ] Estimate cycle from first logged period using standard 28-day default
- [ ] Improve estimated cycle length as more periods are logged
- [ ] Filter out biologically implausible cycle gaps (< 18 days or > 60 days)
- [ ] Display confidence level based on number of periods logged
- [ ] Allow manual adjustment for:
  - [ ] Cycle length
  - [ ] Menstruation length
  - [ ] Luteal length
- [ ] Display estimated cycle phase with day-in-phase count
- [ ] Display days remaining in current phase
- [ ] Clearly label all phase estimates as estimates
- [ ] Include cycle phase in:
  - [ ] Recommendations
  - [ ] Quest generation
  - [ ] Food ideas
  - [ ] Recovery Readiness
  - [ ] Insights
  - [ ] Diary
  - [ ] Export
- [ ] Show cycle phase guidance card per phase:
  - [ ] Menstruation: training, food, mood context
  - [ ] Follicular: training, food, mood context
  - [ ] Ovulation: training, food, mood context
  - [ ] Luteal: training, food, mood context — including craving acknowledgement without shame
- [ ] Show period history
- [ ] Avoid all medical claims
- [ ] Never present cycle estimates as medical information

## 6.4 Medication Tracker

Optional feature. Hidden unless enabled in Settings → Features.

- [ ] Enable or disable in Settings → Features
- [ ] Add medications:
  - [ ] Name
  - [ ] Dose
  - [ ] Unit (mg, ml, tablet, puff, etc.)
  - [ ] Frequency (once daily, twice daily, as needed, etc.)
  - [ ] Scheduled time(s)
  - [ ] Current quantity in stock
  - [ ] Low stock threshold (configurable per medication)
  - [ ] Notes
- [ ] Edit existing medications
- [ ] Archive or remove medications
- [ ] Log each dose taken:
  - [ ] Date and time
  - [ ] Medication taken
  - [ ] Dose taken (may differ from scheduled dose)
  - [ ] Notes (missed, delayed, side effect, etc.)
- [ ] Mark dose as taken with one tap
- [ ] Mark dose as skipped with reason
- [ ] Show today's medication schedule
- [ ] Show which doses are taken, skipped, or pending
- [ ] Show stock level per medication
- [ ] Low stock warning when stock falls below threshold
- [ ] Include medication log in diary
- [ ] Include medication adherence in export
- [ ] Notifications (when notifications are enabled):
  - [ ] Reminder at scheduled dose time
  - [ ] Low stock warning: "You are running low on [medication] — consider restocking soon"
  - [ ] Allow each medication notification to be individually enabled or disabled
- [ ] Do not store prescription details or medical advice
- [ ] Framing must be neutral — not clinical, not dismissive

## 6.5 UC Module (Ulcerative Colitis)

Optional feature. Controlled by a single toggle in Settings → Features.
One toggle enables the entire module. Disabling it hides all UC-related UI immediately.
All data logged while enabled is preserved and reappears if the module is re-enabled.
All framing is plain, clinical, and shame-free. No humour. No medical advice.

### 6.5.1 Bowel Movement Log

- [ ] Log a bowel movement with one tap
- [ ] Date and time (auto-filled, editable)
- [ ] Frequency count for the day (auto-increments, shown as today's total)
- [ ] Urgency:
  - [ ] No urgency
  - [ ] Some urgency
  - [ ] High urgency
  - [ ] Unable to hold
- [ ] Bristol Stool Scale (1–7):
  - [ ] 1 — Separate hard lumps
  - [ ] 2 — Lumpy sausage
  - [ ] 3 — Cracked sausage
  - [ ] 4 — Smooth sausage (typical)
  - [ ] 5 — Soft blobs
  - [ ] 6 — Mushy
  - [ ] 7 — Watery
- [ ] Blood present:
  - [ ] None
  - [ ] Trace
  - [ ] Moderate
  - [ ] Significant
- [ ] Pain during:
  - [ ] None
  - [ ] Mild
  - [ ] Moderate
  - [ ] Severe
- [ ] Notes
- [ ] Show today's count and summary
- [ ] Show recent history (last 30 days)

### 6.5.2 Daily Symptom Log

One entry per day. Captures the overall picture beyond individual bowel events.

- [ ] Abdominal pain / cramping:
  - [ ] Score 0–5
  - [ ] Location (optional free text: e.g. lower left, generalised)
- [ ] Bloating:
  - [ ] None / Mild / Moderate / Severe
- [ ] Nausea:
  - [ ] None / Mild / Moderate / Severe
- [ ] Joint pain:
  - [ ] None / Mild / Moderate / Severe
  - [ ] Location (optional free text)
- [ ] UC fatigue score 1–5 (separate from the general energy score)
  - [ ] Label clearly: "UC fatigue is distinct from general tiredness — it can be present even after good sleep"
- [ ] Stress score 1–5 (separate from mood)
  - [ ] Label clearly: "Stress is a known UC flare contributor. This is tracked separately from mood."
- [ ] Notes

### 6.5.3 Disease Activity Status

One tap per day to set today's status.

- [ ] In remission
- [ ] Mild activity
- [ ] Moderate activity
- [ ] Significant activity
- [ ] Label clearly as self-reported — not a clinical assessment
- [ ] Show status on today's summary card when UC module is enabled
- [ ] Show history as a calendar or timeline view
- [ ] Include in export and diary

### 6.5.4 Flare Tracking

- [ ] Log flare start
- [ ] Log flare end
- [ ] Severity at start:
  - [ ] Mild
  - [ ] Moderate
  - [ ] Severe
- [ ] Notes
- [ ] Show active flare indicator when a flare is open
- [ ] Show flare history with duration and severity
- [ ] Show average flare duration across history
- [ ] Include flares in insights and export

### 6.5.5 Trigger Food Notes

Lightweight — not a full food diary. Meant to flag suspected trigger foods for pattern review.

- [ ] Free text field alongside the food log: "Flagged foods today (suspected triggers)"
- [ ] Also available as a standalone quick-entry within the UC module
- [ ] Store per day
- [ ] Include in export
- [ ] Surface in insights as a tag frequency list

### 6.5.6 UC Home Summary Card

When the UC module is enabled, a summary card appears on the Home tab showing:

- [ ] Today's bowel movement count
- [ ] Today's worst Bristol score
- [ ] Today's disease activity status
- [ ] Active flare indicator (if a flare is currently open)
- [ ] UC fatigue score
- [ ] Stress score

### 6.5.7 UC Insights (within the Insights tab)

Only visible when UC module is enabled. Requires minimum data before showing.

- [ ] Bowel frequency trend (daily count over time)
- [ ] Bristol score trend
- [ ] Blood presence trend
- [ ] Urgency trend
- [ ] Disease activity timeline (calendar heatmap)
- [ ] Flare frequency and duration summary
- [ ] Correlations (all labelled as observations, not medical conclusions):
  - [ ] Bowel frequency ↔ food sugar level
  - [ ] Bowel frequency ↔ hydration
  - [ ] Bowel frequency ↔ stress score
  - [ ] Bowel frequency ↔ sleep quality
  - [ ] Bowel frequency ↔ cycle phase (when cycle tracking also enabled)
  - [ ] Bristol score ↔ hydration
  - [ ] Bristol score ↔ trigger foods (tag frequency)
  - [ ] UC fatigue ↔ disease activity status
  - [ ] UC fatigue ↔ bowel frequency
  - [ ] Stress score ↔ bowel frequency (next day)
  - [ ] Stress score ↔ flare start proximity
  - [ ] Medication adherence ↔ disease activity (when medication tracker also enabled)
- [ ] Plain-English pattern summary updated as data accumulates
- [ ] All UC insights clearly labelled: "This is a personal pattern observation, not medical advice."
- [ ] Minimum thresholds before each insight appears (suppress with under 7 days of data)

### 6.5.8 UC in Diary

When the UC module is enabled, the generated diary includes:

- [ ] Bowel movement count and worst Bristol score for the day
- [ ] Blood presence if anything above None was logged
- [ ] Disease activity status
- [ ] Active flare note if applicable
- [ ] UC fatigue score
- [ ] Stress score
- [ ] Abdominal pain score
- [ ] Flagged trigger foods if any
- [ ] All UC diary content uses plain, neutral language

### 6.5.9 UC in Export

- [ ] Separate sheet in Excel export: UC Daily Summary
- [ ] Columns: date, bowel count, worst Bristol, blood, worst urgency, abdominal pain, bloating, nausea, joint pain, UC fatigue, stress, disease activity, flare active, flagged foods, notes
- [ ] Separate sheet: Flare History (start date, end date, duration, severity, notes)
- [ ] Include in CSV export as additional columns

### 6.5.10 UC Notifications (when notifications and UC module both enabled)

- [ ] Optional daily symptom log reminder
  - [ ] Off by default
  - [ ] Configurable time
  - [ ] Message: "Have you logged your symptoms today?"
- [ ] No automatic bowel movement reminders — this is user-initiated
- [ ] All UC notifications respect quiet hours
- [ ] UC notification category can be toggled independently

### 6.5.11 Technical and Design Requirements

- [ ] Single toggle in Settings → Features enables or disables the entire UC module
- [ ] All UC tables in the database are created on first use, not on install
- [ ] Data is never deleted when the module is disabled
- [ ] UC module does not affect Recovery Readiness calculation in a way that punishes the user
- [ ] UC fatigue and stress scores are stored as separate fields — never merged with mood or energy
- [ ] Bristol Stool Scale shown with simple visual icons or descriptions — not clinical photographs
- [ ] Blood presence field uses plain language — not alarming, not dismissive
- [ ] The word "flare" is used throughout as it is the standard, understood term for UC

---

# 7. Move

The Move tab contains two distinct systems.

## 7.1 Structured Training

- [ ] Training phases:
  - [ ] Phase 1 — Recondition and Restore
  - [ ] Phase 2 — Base Strength
  - [ ] Phase 3 — Build and Progress
- [ ] Science-based exercise progression
- [ ] Customisable exercise schedule for each phase
- [ ] Settings tab to:
  - [ ] Add exercises
  - [ ] Remove exercises
  - [ ] Reorder exercises
  - [ ] Reset defaults
- [ ] Each completed exercise awards XP and AP
- [ ] Partial workouts remain rewarded
- [ ] A Save Training Session button is required
- [ ] Save:
  - [ ] Date
  - [ ] Phase
  - [ ] Exercises completed
  - [ ] Duration
  - [ ] Intensity or RPE
  - [ ] Notes
  - [ ] Partial or full status
- [ ] Only full sessions count toward phase progression
- [ ] Full-session definition must be explicit and configurable
- [ ] Full-session progression should require consistent sessions
- [ ] Boxing alone does not accidentally unlock strength phases unless configured
- [ ] Partial sessions:
  - [ ] Earn XP and AP
  - [ ] Affect analytics
  - [ ] Affect Physical Load
  - [ ] Do not count toward phase unlock
- [ ] Full sessions:
  - [ ] Earn XP and AP
  - [ ] Affect analytics
  - [ ] Affect Physical Load
  - [ ] Count toward phase unlock
- [ ] Show phase progress
- [ ] Show phase unlock celebration
- [ ] Track workout consistency over 7, 30, and 90 days
- [ ] Cycle-aware training guidance when cycle tracking is enabled:
  - [ ] Menstruation: recommend gentle movement, flag heavy session risk
  - [ ] Follicular: allow progressive load increase
  - [ ] Ovulation: peak training window note
  - [ ] Luteal: reduce intensity expectation, note slower recovery

## 7.2 Life Activity

For physically demanding everyday activity that is not intentional training.

- [ ] Activity type:
  - [ ] Gardening / yard work
  - [ ] DIY / home project
  - [ ] Moving / carrying
  - [ ] Long walk
  - [ ] Hiking
  - [ ] Manual labour
  - [ ] Heavy housework
  - [ ] Other
- [ ] Duration
- [ ] Intensity:
  - [ ] Light
  - [ ] Moderate
  - [ ] Hard
  - [ ] Very hard
- [ ] Notes
- [ ] Award XP and AP
- [ ] Show today's entries
- [ ] Show history
- [ ] Add to Physical Load
- [ ] Add to Recovery Readiness
- [ ] Add to diary and exports
- [ ] Add to correlations and pattern discovery
- [ ] Never count toward structured training phase progression

## 7.3 Steps

Future native Android feature.

- [ ] Manual steps entry initially, only if useful
- [ ] Later integrate with Android Health Connect
- [ ] User permission flow
- [ ] Import daily steps automatically
- [ ] Do not treat steps as equivalent to Life Activity
- [ ] Include steps as one Physical Load contributor
- [ ] Handle missing permissions gracefully

---

# 8. Physical Load

Physical Load is neutral and reflects physical demand, not "stress".

- [ ] Calculate Physical Load from:
  - [ ] Structured training
  - [ ] Life Activity
  - [ ] Steps when available
  - [ ] Sleep debt
- [ ] Keep components visible and explainable
- [ ] Categorise:
  - [ ] Low
  - [ ] Moderate
  - [ ] High
  - [ ] Very high
- [ ] Show contributor breakdown
- [ ] Store daily Physical Load score
- [ ] Include in diary
- [ ] Include in export
- [ ] Include in correlations
- [ ] Use for next-day recommendations
- [ ] Avoid negative or judgemental framing

---

# 9. Recovery Readiness

Recovery Readiness is the result, distinct from Physical Load.

- [ ] Calculate from:
  - [ ] Sleep duration
  - [ ] Sleep quality
  - [ ] Energy
  - [ ] Hydration
  - [ ] Recent Physical Load
  - [ ] Sugar
  - [ ] Cycle phase when enabled
- [ ] Keep calculation transparent
- [ ] Show score and category
- [ ] Categories:
  - [ ] Low
  - [ ] Moderate
  - [ ] Good
  - [ ] Excellent
- [ ] Show factor breakdown
- [ ] Explain what reduced or supported readiness
- [ ] Store daily score
- [ ] Include in insights and exports
- [ ] Use to guide recommendations
- [ ] Do not present as medical advice

---

# 10. XP, AP, Levels and Progression

## 10.1 XP

- [ ] Award XP for useful actions
- [ ] Exercises award XP individually
- [ ] Partial effort is rewarded
- [ ] Daily quest completion bonus
- [ ] Full workout bonus
- [ ] Consistency bonuses
- [ ] Level system
- [ ] Visually meaningful level-up animation

## 10.2 AP

- [ ] AP is spendable
- [ ] Award AP for useful actions
- [ ] Double AP on milestone days
- [ ] Show current balance
- [ ] Record purchases
- [ ] Prevent negative balance

## 10.3 Level Curve

- [ ] Use a deliberate progression curve
- [ ] Early levels should arrive quickly
- [ ] Higher levels require gradually more XP
- [ ] Level-ups should feel impactful
- [ ] Store total XP independently from level display

---

# 11. Streaks and Milestones

## 11.1 Streak Logic

- [ ] Streak based on completed daily diary or defined day completion
- [ ] Do not reset home summaries immediately after saving diary
- [ ] New day reset occurs on the next calendar day
- [ ] Handle today and yesterday correctly
- [ ] Avoid timezone-related streak errors

## 11.2 Streak Saver

- [ ] Purchasable in Reward Shop
- [ ] Bankable
- [ ] If a streak breaks and a saver exists:
  - [ ] Show popup
  - [ ] Ask whether to use it
  - [ ] Use saver only after confirmation
- [ ] If no saver exists:
  - [ ] Do not show the option
- [ ] Record saver usage
- [ ] Prevent repeated prompts

## 11.3 Milestone Visual Design

- [ ] Remove abrasive orange/gold full-app recolouring
- [ ] Keep the normal Momentum palette
- [ ] Elegant metallic card borders
- [ ] Animated highlight rotating around the border
- [ ] Slow, subtle animation
- [ ] One-time milestone overlay
- [ ] No confetti or aggressive flashing
- [ ] Use metal tiers:
  - [ ] Bronze
  - [ ] Silver
  - [ ] Gold
  - [ ] Platinum
- [ ] Milestone cards should feel prestigious and minimal
- [ ] Respect reduced-motion accessibility setting
- [ ] Achievement history / collectibles view

---

# 12. Reward Shop

- [ ] Show AP balance
- [ ] Add custom rewards
- [ ] Reward name
- [ ] AP cost
- [ ] Category
- [ ] Purchase reward
- [ ] Record purchase history
- [ ] Disable purchase when AP is insufficient
- [ ] Remove generic suggested rewards
- [ ] Keep utility items:
  - [ ] Quest reroll
  - [ ] Streak Saver
- [ ] Show banked utility item counts
- [ ] Include purchases in diary and export

---

# 13. Diary and End Day

- [ ] Generate a structured daily diary
- [ ] Include:
  - [ ] Mood
  - [ ] Sleep
  - [ ] Hydration
  - [ ] Food
  - [ ] Sugar
  - [ ] Naps
  - [ ] Home care
  - [ ] Structured training
  - [ ] Life Activity
  - [ ] Physical Load
  - [ ] Recovery Readiness
  - [ ] Cycle phase when enabled
  - [ ] Medications taken when enabled
  - [ ] Bowel summary when enabled (discreetly worded)
  - [ ] Rewards redeemed
- [ ] Allow editing before save
- [ ] Save diary entry
- [ ] Do not wipe the current dashboard until the next day
- [ ] Prevent duplicate daily diary entries or support intentional overwrite
- [ ] Edit historical entries
- [ ] Delete entries with confirmation
- [ ] Show past entries
- [ ] Diary save archives all daily tracker data

---

# 14. Insights and Analytics

No ML required initially. All initial insights are deterministic and dataset-driven.

## 14.1 Architecture

- [ ] Separate analytics engine from UI
- [ ] Separate renderers/screens for:
  - [ ] Overview
  - [ ] Weekly
  - [ ] Monthly
  - [ ] Patterns
- [ ] One failed chart must not blank the entire Insights section
- [ ] Graceful "not enough data" states
- [ ] Error boundaries and visible diagnostic logging in development
- [ ] Analytics functions must handle null and missing data safely

## 14.2 Overview

- [ ] Today's Story
- [ ] Recovery Readiness hero
- [ ] Physical Load hero
- [ ] Sleep summary
- [ ] Mood summary
- [ ] Training consistency
- [ ] Hydration goal days
- [ ] Key discoveries
- [ ] Plain-English weekly summary

## 14.3 Weekly

- [ ] Sleep, mood, and energy timeline
- [ ] Clear in-chart legend
- [ ] Axes and units
- [ ] Press/hold information tooltip
- [ ] Daily quest completion heatmap
- [ ] Training and Life Activity timeline
- [ ] Weekly Physical Load
- [ ] Weekly Recovery Readiness
- [ ] Week-over-week comparison
- [ ] Biggest win
- [ ] Watch point

## 14.4 Monthly

- [ ] Monthly Recovery Readiness calendar heatmap
- [ ] Rolling trends
- [ ] Weekly averages
- [ ] Monthly achievements
- [ ] Longest streak
- [ ] Most active day
- [ ] Best mood day
- [ ] Average sleep
- [ ] Training consistency
- [ ] Hydration goal count
- [ ] Cycle phase summaries when enabled

## 14.5 Patterns and Relationships

- [ ] Correlations calculated from actual data
- [ ] Minimum sample thresholds
- [ ] Confidence / strength labels
- [ ] Clearly state correlation is not causation
- [ ] Include:
  - [ ] Sleep hours ↔ mood
  - [ ] Sleep quality ↔ mood
  - [ ] Sleep ↔ energy
  - [ ] Sugar ↔ sleep
  - [ ] Sugar ↔ energy
  - [ ] Hydration ↔ mood
  - [ ] Hydration ↔ energy
  - [ ] Training ↔ mood
  - [ ] Training ↔ energy
  - [ ] Life Activity ↔ next-day energy
  - [ ] Life Activity ↔ sleep
  - [ ] Physical Load ↔ readiness
  - [ ] Nap ↔ mood
  - [ ] Nap ↔ energy
  - [ ] Quest completion ↔ mood
  - [ ] Quest completion ↔ sleep
  - [ ] Office vs WFH
  - [ ] Weekday vs weekend
  - [ ] Cycle phase ↔ mood
  - [ ] Cycle phase ↔ energy
  - [ ] Cycle phase ↔ readiness
  - [ ] Bowel frequency ↔ food and sugar (when UC module enabled)
  - [ ] Bowel frequency ↔ hydration (when UC module enabled)
  - [ ] Bowel frequency ↔ stress score (when UC module enabled)
  - [ ] Bowel frequency ↔ cycle phase (when UC module and cycle tracking enabled)
  - [ ] Bristol score ↔ hydration (when UC module enabled)
  - [ ] UC fatigue ↔ disease activity (when UC module enabled)
  - [ ] Stress score ↔ flare proximity (when UC module enabled)
  - [ ] Medication adherence ↔ disease activity (when UC module and medication tracker enabled)
  - [ ] Medication adherence ↔ energy (when enabled)
  - [ ] Medication adherence ↔ mood (when enabled)
- [ ] Support lagged relationships:
  - [ ] Same-day
  - [ ] Next-day
  - [ ] Multi-day recovery
- [ ] Do not show unstable correlations with tiny sample sizes

## 14.6 Compare Mode

- [ ] Office vs WFH
- [ ] Weekday vs weekend
- [ ] Training vs no training
- [ ] Boxing vs no boxing
- [ ] Nap vs no nap
- [ ] High vs low sugar
- [ ] High vs low Physical Load
- [ ] Menstruation vs follicular vs ovulation vs luteal
- [ ] Medication taken vs skipped (when medication tracker enabled)
- [ ] Flare days vs remission days (when UC module enabled)
- [ ] High stress vs low stress days (when UC module enabled)
- [ ] Compare:
  - [ ] Sleep
  - [ ] Mood
  - [ ] Energy
  - [ ] Hydration
  - [ ] Recovery Readiness
  - [ ] Quest completion
  - [ ] Training
  - [ ] Life Activity

## 14.7 Data Maturity

- [ ] Under 7 days: summaries only
- [ ] 7–14 days: simple weekly trends
- [ ] 14–30 days: early correlations
- [ ] 30–90 days: comparisons and pattern cards
- [ ] 90+ days: long-term and cycle trends
- [ ] UI should explain why a section is locked or unavailable

## 14.8 Visualisation Quality

- [ ] Integrated legends
- [ ] Clear units
- [ ] Accessible colours
- [ ] Avoid using colour alone
- [ ] Information tooltip on complex charts
- [ ] Press-and-hold interaction on mobile
- [ ] Tap or keyboard focus alternative
- [ ] Responsive chart sizing
- [ ] No fragile web canvas dependency
- [ ] Premium but restrained animation
- [ ] Respect reduced-motion setting

---

# 15. Settings

Settings tabs:

- [ ] Work
- [ ] Features
- [ ] Training
- [ ] Home Tasks
- [ ] Data
- [ ] Appearance

## 15.1 Work

- [ ] Monday–Friday assumed as workdays by default
- [ ] Select WFH days
- [ ] Remaining workdays treated as office days
- [ ] Use work pattern for quest generation and insights

## 15.2 Features

- [ ] Enable cycle tracking (hidden by default)
- [ ] Enable medication tracker (hidden by default)
- [ ] Enable UC module — single toggle enables all UC features (hidden by default)
- [ ] Hydration goal
- [ ] Boxing days
- [ ] Notifications
- [ ] Step integration permission
- [ ] Each optional feature has an independent toggle
- [ ] Disabling a feature hides all UI for it immediately
- [ ] Data logged for a disabled feature is preserved and reappears if re-enabled

## 15.3 Appearance

- [ ] Light mode
- [ ] Dark mode
- [ ] System mode
- [ ] Preserve Momentum colour palette
- [ ] Consistent metallic milestone treatment in both modes
- [ ] Reduced motion option

---

# 16. Data Storage

## 16.1 Database

- [ ] Use SQLite through Drift or another reliable Flutter database layer
- [ ] Do not use localStorage
- [ ] Separate tables for:
  - [ ] Daily summary
  - [ ] Sleep
  - [ ] Naps
  - [ ] Mood
  - [ ] Food
  - [ ] Sugar
  - [ ] Hydration
  - [ ] Home care
  - [ ] Training sessions
  - [ ] Training exercises
  - [ ] Life Activity
  - [ ] Steps
  - [ ] Physical Load
  - [ ] Recovery Readiness
  - [ ] Periods
  - [ ] Cycle estimates
  - [ ] Medications (definitions)
  - [ ] Medication logs (doses taken/skipped)
  - [ ] UC bowel movements
  - [ ] UC daily symptoms
  - [ ] UC disease activity
  - [ ] UC flares
  - [ ] UC trigger food notes
  - [ ] Quests
  - [ ] Rewards
  - [ ] Purchases
  - [ ] Diary
  - [ ] Settings
  - [ ] Achievements

## 16.2 Migrations

- [ ] Version the database schema
- [ ] Write migration scripts for every schema change
- [ ] Test migrations automatically
- [ ] Never silently discard incompatible records
- [ ] Create a backup before migration
- [ ] Provide migration error recovery

## 16.3 Backup and Restore

- [ ] Full JSON backup
- [ ] Import backup
- [ ] Automatic local backup
- [ ] Restore last automatic backup
- [ ] Export CSV
- [ ] Export multi-sheet Excel
- [ ] Include schema version in backup
- [ ] Validate imported backup before replacing data
- [ ] Never overwrite current data until validation succeeds
- [ ] Allow periodic backup reminders

---

# 17. Native Android Features

- [ ] Android package identifier
- [ ] App icon
- [ ] Splash screen
- [ ] Notification permission
- [ ] Local reminders
- [ ] Health Connect integration
- [ ] Background sync where appropriate
- [ ] Android backup behaviour decision
- [ ] Share/export files through native share sheet
- [ ] Installable APK for testing
- [ ] Signed Android App Bundle for eventual release

---

# 18. Notifications

Optional and configurable. Each type can be individually enabled or disabled.
Quiet hours must be respected for all notifications.

## 18.1 Sleep

- [ ] Morning sleep log reminder
  - [ ] Default time: configurable (e.g. 8:00 AM)
  - [ ] Message: "Have you logged your sleep this morning?"
  - [ ] Only fires if sleep has not been logged for today
  - [ ] Configurable time

## 18.2 Hydration

- [ ] Midday hydration check-in
  - [ ] Message: "How is your hydration going? Tap to log."
  - [ ] Configurable time
  - [ ] Suppressible once goal is met

## 18.3 End of Day / Diary

- [ ] Evening diary reminder
  - [ ] Default time: configurable (e.g. 8:30 PM)
  - [ ] Message: "It is almost the end of the day — have you generated your daily diary?"
  - [ ] Only fires if diary has not been saved today
  - [ ] Configurable time

## 18.4 Training

- [ ] Training day reminder
  - [ ] Only fires on configured training days
  - [ ] Message: "Your training session is scheduled for today."
  - [ ] Configurable time

## 18.5 Nap

- [ ] Planned nap reminder
  - [ ] Fires only if user has logged a planned nap for today
  - [ ] Message: "Your planned nap is scheduled — rest up."
  - [ ] Time set when logging the nap

## 18.6 Medication

- [ ] Dose reminder per medication (when medication tracker is enabled)
  - [ ] Fires at scheduled dose time(s) per medication
  - [ ] Message: "Time to take [medication name]."
  - [ ] Clears automatically if dose is marked as taken
  - [ ] Low stock warning:
    - [ ] Fires when stock falls below configured threshold
    - [ ] Message: "You are running low on [medication name] — consider restocking soon."
    - [ ] Fires once per day until stock is updated
  - [ ] Each medication's reminders can be individually toggled

## 18.7 Backup

- [ ] Periodic backup reminder
  - [ ] Default: weekly
  - [ ] Message: "It has been a week since your last backup — tap to back up your Momentum data."
  - [ ] Configurable frequency or disableable

## 18.8 UC Module

- [ ] Optional daily symptom log reminder (when UC module is enabled)
  - [ ] Off by default
  - [ ] Configurable time
  - [ ] Message: "Have you logged your symptoms today?"
  - [ ] Only fires if symptom log has not been completed today
- [ ] No automatic bowel movement reminders — this is always user-initiated
- [ ] UC notifications respect quiet hours
- [ ] UC notification category can be toggled independently of other categories

## 18.9 Notification Settings

- [ ] Master on/off switch for all notifications
- [ ] Quiet hours start and end time
- [ ] Per-category toggles
- [ ] Per-medication toggles (when medication tracker is enabled)
- [ ] UC symptom reminder toggle (when UC module is enabled)
- [ ] Do not fire any notification during quiet hours
- [ ] Avoid excessive or repeated notifications
- [ ] All notification text must be calm and non-pressuring

---

# 19. Future On-Device ML

Not part of the initial release.

## 19.1 Python Development

- [ ] Export anonymised personal dataset
- [ ] Explore features in Python
- [ ] Train and validate models
- [ ] Use time-aware validation
- [ ] Avoid data leakage
- [ ] Compare model against deterministic baseline
- [ ] Document feature definitions
- [ ] Assess whether the dataset is large enough

## 19.2 Candidate Features

- [ ] Sleep hours
- [ ] Sleep quality
- [ ] Sleep debt
- [ ] Rolling sleep averages
- [ ] Mood history
- [ ] Energy history
- [ ] Hydration
- [ ] Sugar
- [ ] Training volume
- [ ] Training intensity
- [ ] Training consistency
- [ ] Life Activity score
- [ ] Physical Load
- [ ] Recovery Readiness history
- [ ] Cycle day and phase
- [ ] Workday type
- [ ] Naps
- [ ] Quest completion
- [ ] Medication adherence (when medication tracker enabled)
- [ ] UC bowel frequency (when UC module enabled)
- [ ] UC Bristol score (when UC module enabled)
- [ ] UC disease activity status (when UC module enabled)
- [ ] UC fatigue score (when UC module enabled)
- [ ] UC stress score (when UC module enabled)
- [ ] Flare proximity (when UC module enabled)

## 19.3 Mobile Delivery

- [ ] Convert model to a supported mobile format
- [ ] Bundle model with Flutter app
- [ ] Run inference on-device
- [ ] No cloud health-data upload required
- [ ] Show prediction confidence
- [ ] Explain model output
- [ ] Let user disable ML
- [ ] Never replace user judgement or medical care

---

# 20. Quality, Testing and Reliability

- [ ] Unit tests for XP/AP
- [ ] Unit tests for streaks
- [ ] Unit tests for quest generation
- [ ] Unit tests for phase progression
- [ ] Unit tests for Physical Load
- [ ] Unit tests for Recovery Readiness
- [ ] Unit tests for cycle estimation
- [ ] Unit tests for correlations
- [ ] Unit tests for next-day joins
- [ ] Unit tests for medication stock logic
- [ ] Unit tests for UC bowel log aggregation
- [ ] Unit tests for UC flare duration calculation
- [ ] Unit tests for UC correlations with minimum data thresholds
- [ ] Unit tests for UC module toggle — data preserved when disabled and restored when re-enabled
- [ ] Database migration tests
- [ ] Backup/import tests
- [ ] Widget tests for core screens
- [ ] Integration test for full day workflow
- [ ] Test on actual Android phone
- [ ] Test different phone sizes
- [ ] Test dark and light mode
- [ ] Test with no data
- [ ] Test with partial data
- [ ] Test with 365+ days
- [ ] Test timezone and midnight rollover
- [ ] Test app update without data loss
- [ ] Test optional features disabled then re-enabled without data loss
- [ ] Release checklist required before every build

---

# 21. Accessibility

- [ ] Adequate contrast
- [ ] Scalable text
- [ ] Screen-reader labels
- [ ] Large touch targets
- [ ] Do not rely only on colour
- [ ] Reduced-motion support
- [ ] Keyboard navigation for desktop/web builds
- [ ] Plain-language chart explanations
- [ ] Accessible error messages

---

# 22. Suggested Build Phases

## Phase A — Foundation

- [ ] Flutter project
- [ ] App theme
- [ ] Navigation
- [ ] Database
- [ ] Settings structure
- [ ] Backup framework
- [ ] Core models

## Phase B — Daily Logging

- [ ] Sleep
- [ ] Naps
- [ ] Mood
- [ ] Hydration
- [ ] Food
- [ ] Sugar
- [ ] Home care
- [ ] Diary

## Phase C — Movement and Recovery

- [ ] Structured training
- [ ] Exercise rewards
- [ ] Full-session progression
- [ ] Life Activity
- [ ] Physical Load
- [ ] Recovery Readiness

## Phase D — Gamification

- [ ] XP
- [ ] AP
- [ ] Levels
- [ ] Daily quests (including cycle-aware and hydration-always-full)
- [ ] Rerolls
- [ ] Reward Shop
- [ ] Streak Saver
- [ ] Milestones
- [ ] Achievements

## Phase E — Optional Health Trackers

- [ ] Menstrual cycle tracking
- [ ] Medication tracker
- [ ] UC module (single toggle):
  - [ ] Bowel movement log
  - [ ] Daily symptom log (fatigue, stress, pain, nausea, joint pain, bloating)
  - [ ] Disease activity status
  - [ ] Flare tracking
  - [ ] Trigger food notes
  - [ ] UC home summary card
  - [ ] UC diary section
  - [ ] UC export sheets
- [ ] Feature toggles in Settings → Features
- [ ] Cycle-aware quests, recommendations, food ideas, training guidance

## Phase F — Insights

- [ ] Overview
- [ ] Weekly
- [ ] Monthly
- [ ] Patterns
- [ ] Correlations (including medication and UC module when enabled)
- [ ] UC insights section (bowel trends, disease activity calendar, flare summary, stress correlations)
- [ ] Compare mode
- [ ] Tooltips
- [ ] Premium animations

## Phase G — Native Android

- [ ] Notifications (all types from section 18)
- [ ] Health Connect
- [ ] Steps
- [ ] APK/AAB release process

## Phase H — Future ML

- [ ] Python modelling
- [ ] Model validation
- [ ] On-device inference
- [ ] Prediction UI

---

# 23. Definition of MVP

The first usable Flutter version should include:

- [ ] Local database
- [ ] Home dashboard
- [ ] Sleep and naps
- [ ] Mood
- [ ] Hydration
- [ ] Food and sugar
- [ ] Structured training
- [ ] Life Activity
- [ ] Physical Load
- [ ] Recovery Readiness
- [ ] Diary
- [ ] XP and AP
- [ ] Daily quests
- [ ] Backup and restore
- [ ] Basic weekly insights
- [ ] No data loss during updates

Optional trackers (medication, UC module, cycle tracking) and notifications follow after the foundation is stable.
