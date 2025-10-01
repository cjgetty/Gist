# Gist (iOS)

Gist is a SwiftUI app helping people find their niche and belong through community discovery and lightweight contribution.

## Tech Stack
- SwiftUI + MVVM
- Modular by feature: Feed, Discover, Composer, Thread, Community, Profile, Moderation, Inbox
- Async/await networking via `NetworkClient` with mock mode for previews/tests
- Accessibility: Dynamic Type (AX6), VoiceOver labels

## Project Structure
- `Gist/App/` — App entry, app-wide enums
- `Gist/Core/` — Models, Networking, Services, Utilities, Mocks
- `Gist/Components/` — Reusable UI components (e.g., `PostCardView`)
- `Gist/Features/` — Feature folders (`View`, `ViewModel`, `Model` per module)
- `GistTests/` — Unit tests (to be wired as a test target)
- `docs/` — PRD, ROADMAP, Windsurf rules, bootstraps

## App Entry
`Gist/App/GistApp.swift` defines a `TabView` with tabs: Home, Discover, Create, Inbox, Profile.

## Services
- `AuthService`, `FeedService`, `PostService`, `CommunityService`, `ModerationService`.
- Default and mock implementations to enable previews and tests.

## Accessibility
- Previews include Dynamic Type examples and VoiceOver labels for interactive elements.

## Next Steps
- Wire `GistTests` test target in the Xcode project and add CI (lint + tests).
- Implement backend integration (NestJS + Prisma) when API stabilizes.
- Add snapshot tests for post/comment cards.

## CI
- GitHub Actions workflow at `.github/workflows/ci.yml` runs:
  - Lint/format check (`swiftlint --strict`, `swiftformat --lint`).
  - Parallel test jobs:
    - `Gist` scheme (UI + app tests).
    - `GistCore` scheme (core unit tests).

## Lint & Format
- Configs at repo root:
  - `.swiftlint.yml` (common rules: naming, force unwraps/try/cast disabled, line length 100).
  - `.swiftformat` (2-space indent, wrap args/collections, max line width 100).

## Git Hooks
- Pre-commit hook script at `.githooks/pre-commit` runs `swiftformat` then `swiftlint --fix`.
- Enable it once per repo:
  ```bash
  chmod +x .githooks/pre-commit
  git config core.hooksPath .githooks
  ```

## Schemes
- `Gist`: builds app and runs all tests (including UI snapshot/accessibility).
- `GistCore`: builds framework and runs core-only tests. Snapshot tests are skipped in this scheme.

## Networking
- `Gist/Core/Utilities/EnvironmentConfig.swift` holds `apiBaseURL` and feature flags.
- `NetworkClient` adds:
  - Structured `NetworkError` (invalidURL, http(code), unauthorized, timeout, decoding, maxRetriesReached, other).
  - Retry policy with exponential backoff for transient errors and timeouts.
  - 401 handling via `AuthServiceProtocol.refreshAuthTokenIfNeeded()` stub.

## Testing
- Failure-path tests for `NetworkClient` using a custom `URLProtocol` to simulate HTTP and timeout scenarios.
- Snapshot-ish tests render `PostCardView` and `FeedView` via `UIHostingController` and verify accessibility labels.

## Docs
- See `docs/PRD.md`, `docs/ROADMAP.md`, and `docs/windsurf-rules.md` for the source of truth.
