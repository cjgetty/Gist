# .windsurf/rules.md — Windsurf Rules for Gist

## 1. General Philosophy
- **Consistency first**: Follow Apple’s Human Interface Guidelines (iOS 26), Swiss grid principles, and PRD/ROADMAP as the single source of truth.  
- **Modularity**: Always create feature-based modules (`Feed`, `Discover`, `Composer`, `Thread`, `Community`, `Profile`, `Moderation`).  
- **Clarity > cleverness**: Simple, readable code over “smart” tricks.  
- **Privacy & safety by design**: No shortcuts — anonymity, reporting, and data deletion must always be preserved.

---

## 2. SwiftUI Rules
- Use **SwiftUI + MVVM**. Each feature module = `View`, `ViewModel`, `Model`.  
- **No UIKit unless strictly required**. If UIKit must be used, wrap in SwiftUI.  
- **Async/await** only for networking; avoid legacy `completion` closures.  
- Use `NavigationStack` for navigation, `TabView` for global nav, `Sheet` for composer.  
- **Dynamic Type required**: test all views with `.environment(\.\sizeCategory, .accessibilityExtraExtraExtraLarge)`.  
- **Accessibility**: every `Button`, `Image`, `Text` has an `accessibilityLabel`.  
- **Haptics**: wrap with a `HapticFeedbackService` that respects system “Reduce Haptics”.  
- **Preview culture**: Every View must include a `#Preview` with sample data.  

---

## 3. Code Style & Structure
- **Naming**: `CamelCase` for types, `lowerCamelCase` for vars/functions. No abbreviations unless Apple-standard (`URL`, `ID`).  
- **Files**: one main type per file; folder by feature.  
- **No massive ViewModels** → break logic into services (`AuthService`, `FeedService`, etc.).  
- **Dependency injection**: Use singletons (`@MainActor class FooService: ObservableObject`) sparingly; prefer environment objects.  
- **Error handling**: Use `Result` or `throws`, no silent failures.  

---

## 4. Networking
- Use a **`NetworkClient`** with:  
  - async/await `get/post/put/delete`.  
  - Generic decoding into `Decodable` models.  
  - Automatic token refresh on 401.  
- **Mock mode**: always implement sample JSON for previews/tests.  
- **Security**: No plain-text secrets; use `@AppStorage` for tokens; refresh tokens stored in Keychain.  

---

## 5. Backend Expectations
- **API Spec**: REST (OpenAPI 3.1) or GraphQL; must match Prisma schema.  
- **NestJS + Prisma**:  
  - Modules for `Auth`, `Users`, `Communities`, `Posts`, `Comments`, `Votes`, `Reports`, `Moderation`.  
  - Strong typing (`zod` or `class-validator`).  
  - JWT access/refresh with rotation.  
- **Infra**: must build with Docker, deploy with minimal config to Render/Fly.io.  
- **Privacy**: all uploads strip EXIF; PII separated from public content.  

---

## 6. Testing & Quality
- **Unit tests**: Every service must have coverage.  
- **Snapshot tests**: UI cards in SwiftUI.  
- **Performance budgets**: feeds load < 200ms from cache, < 1s from network.  
- **Accessibility tests**: run VoiceOver with previews.  
- **CI**: Lint + test required before merging.  

---

## 7. Documentation
- Every feature folder has a `README.md` with: purpose, flows, API endpoints.  
- PRD & ROADMAP must be kept in sync with features delivered.  
- Add inline `///` doc comments for all public types.  

---

## 8. Windsurf-Specific Instructions
- **When scaffolding**: always start from the PRD + ROADMAP.  
- **When adding features**: confirm they belong to the correct roadmap phase. If not, add a note `// TODO: Phase X`.  
- **When generating SwiftUI**: create separate files for each `View`, `ViewModel`, `Service`.  
- **When updating**: do not overwrite unrelated modules; only modify what’s explicitly requested.  
- **Commit hygiene**:  
  - Small, focused commits.  
  - Conventional commit style: `feat:`, `fix:`, `chore:`, `docs:`.  

---

## 9. Golden Rules
1. Accessibility and privacy are never optional.  
2. No “magic” or hidden dependencies. Everything documented.  
3. Always generate previews/tests alongside new code.  
4. Every feature ties back to “helping users find their community.”  
5. If in doubt → default to Apple’s design language and the PRD.  
