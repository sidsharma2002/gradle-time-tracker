# bt - Build Time Tracker

Lightweight CLI for tracking Gradle build times. Works with any Gradle project - Android, Java, Kotlin, and more.

Zero memory when idle. Hooks directly into Gradle's build lifecycle - no daemon, no polling, no background process.

## Install

```bash
git clone https://github.com/sidsharma2002/gradle-time-tracker.git
cd gradle-time-tracker
./install.sh
```

`install.sh` copies two files to their correct locations and checks your PATH.

### Manual install

| Source | Destination |
|--------|-------------|
| `build-tracker.gradle` | `~/.gradle/init.d/build-tracker.gradle` |
| `bt` | `~/.local/bin/bt` (must be executable) |

Ensure `~/.local/bin` is in PATH:

```bash
export PATH="$HOME/.local/bin:$PATH"   # add to ~/.zshrc or ~/.bashrc
```

## Prerequisites

- Gradle installed and available (any version 6.x+)
- Gradle init scripts enabled (default - no config needed)

## How It Works

Gradle auto-loads every script in `~/.gradle/init.d/` at build start. The tracker fires on `buildFinished` and appends one row to a daily CSV:

```
~/.build-tracker/YYYY-MM-DD.csv
```

## Commands

```bash
bt                   # today's builds + summary
bt today             # same as above
bt week              # last 7 days daily totals
bt month             # last 30 days daily totals
bt <N>               # last N days  (e.g. bt 14)
bt <YYYY-MM>         # specific month  (e.g. bt 2026-04)
bt log               # raw CSV for today
bt help              # usage
```

## Example Output

`bt today`:
```
14:23:01    45.2s  SUCCESS   myapp
14:45:12    12.4s  FAILED    myapp
15:10:44    38.7s  SUCCESS   myapp

3 builds | 96s total | 2 success  1 fail
```

`bt week`:
```
2026-04-24    5 builds    312s  (0 fail)
2026-04-25    8 builds    541s  (1 fail)
2026-04-28    3 builds    198s  (0 fail)
2026-04-30    3 builds     96s  (1 fail)

Total: 19 builds | 18m 47s | 2 fail
```

`bt help`:
```
bt - build time tracker

Usage:
  bt               today's builds + summary
  bt today         same as above
  bt week          last 7 days
  bt month         last 30 days
  bt <N>           last N days  (e.g. bt 14)
  bt <YYYY-MM>     specific month  (e.g. bt 2026-04)
  bt log           raw CSV for today
```

## CSV Format

```
time,duration_ms,status,project
14:23:01,45231,SUCCESS,myapp
14:45:12,12445,FAILED,myapp
```

## Data Location

```bash
ls ~/.build-tracker/                          # all daily files
cat ~/.build-tracker/$(date +%Y-%m-%d).csv   # today's raw data
```

## Triggering Builds

Any Gradle build records automatically - IDE builds, terminal builds, or:

```bash
cd ~/YourProject
./gradlew assembleDebug     # full build
./gradlew tasks             # fast test - just lists tasks
```

## Installed Files

| File | Purpose |
|------|---------|
| `~/.gradle/init.d/build-tracker.gradle` | Gradle hook - fires on every build finish |
| `~/.local/bin/bt` | CLI viewer |
| `~/.build-tracker/YYYY-MM-DD.csv` | Daily data files (auto-created) |

## Compatibility

Gradle 6.x, 7.x, 8.x, 9.x. Uses `gradle.buildFinished` - deprecated since Gradle 7.1 but functional across all current versions.

macOS and Linux supported (`bt` handles both BSD and GNU `date`).

## License

MIT
