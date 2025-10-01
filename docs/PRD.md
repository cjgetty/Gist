# Gist — Product Requirements Document

## Core Mission
Create a clean, Apple-quality space where people can **find their niche** and belong. Gist helps people **discover communities** and participate on their terms — fully identified, pseudonymous, or anonymous.

---

## Goals
- **Discovery first**: Trending, topics, and tailored feeds.
- **Identity flexibility**: Post as yourself, under a pseudonym, or anonymously.
- **Clean design**: Swiss-inspired hierarchy, Apple HIG compliance.
- **Accessibility built-in**: Dynamic Type, VoiceOver, haptics.
- **Safety**: Reporting, blocking, keyword filters, mod tools.
- **Privacy**: Minimal data collection, EXIF stripping, one-tap deletion.

Non-Goals (MVP):
- DMs, live audio/video, advanced monetization.

Success metrics:
- D7 retention ≥ 25%
- Time to first community join ≤ 2m
- 70% of sessions include a meaningful action (vote, reply, save, post)

---

## Personas
- **Explorers**: want to find their community quickly.
- **Contributors**: want fast, lightweight posting.
- **Lurkers**: want to browse/comment without revealing identity.
- **Moderators**: need quick, transparent controls.

---

## Features (MVP)
- **Accounts & Profiles** (Auth, Apple Sign-In, passkeys; basic profile + privacy toggles)
- **Communities** (create, join, trending, rules, tags)
- **Feeds & Discovery** (Home, Trending, Topics, Search)
- **Posts & Comments** (text, link, image, video, Markdown, threaded comments, voting, ALT text)
- **Moderation & Safety** (report, block, filter, automod basics, mod queue)
- **Notifications** (replies, mentions, trending)
- **Offline cache** (read, queued posting)

---

## Experience Principles
- **Clarity > cleverness** (grid, SF Pro variable, strict vertical rhythm)
- **Deference to content** (chrome quiet, content is the hero)
- **Depth & motion** (blur/materials, fluid transitions)
- **Privacy by default** (identity mode toggle at post time)

---

## Accessibility
- Dynamic Type AX5/6 coverage
- VoiceOver labels and rotor navigation
- ALT text required for images
- Color contrast meets WCAG 2.1 AA
- Haptics + motion respect system toggles

---

## Privacy
- Minimal data collection
- EXIF stripping on uploads
- One-tap account & data deletion
- No dark patterns, transparent consent

---

## Architecture
- **iOS app**: SwiftUI, async/await, MVVM modules
- **Backend**: NestJS + PostgreSQL + Prisma, Meilisearch, S3/R2 for media
- **Infra**: Docker, Render/Fly.io/AWS
- **Web App (Phase 2)**: Next.js + React + Tailwind, same API

---

## Risks
- **UGC abuse** → mitigated with reporting, blocking, automod
- **App Store 1.2 rejection** → mitigated with reporting, filtering, contact page
- **Performance bottlenecks** → solved with lazy loading, caches, job queues
