# MediFlow SaaS — Full Platform Plan

> **Version:** 1.0.0
> **Last Updated:** May 2026
> **Author:** MediFlow Team
> **Status:** Planning & Architecture Phase

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Business Purpose & Problem Statement](#2-business-purpose--problem-statement)
3. [Target Market](#3-target-market)
4. [Business Model](#4-business-model)
5. [Product Vision & Goals](#5-product-vision--goals)
6. [How We Build This Business](#6-how-we-build-this-business)
7. [Platform Architecture Overview](#7-platform-architecture-overview)
8. [Technical Stack — Full Breakdown](#8-technical-stack--full-breakdown)
9. [Platform Fields (Web, Mobile, Backend)](#9-platform-fields-web-mobile-backend)
10. [Feature List — Complete](#10-feature-list--complete)
11. [Role-Based Access Control (RBAC)](#11-role-based-access-control-rbac)
12. [Database Schema](#12-database-schema)
13. [API Design](#13-api-design)
14. [Authentication & Security](#14-authentication--security)
15. [Notifications System](#15-notifications-system)
16. [AI Features](#16-ai-features)
17. [Hosting & Infrastructure](#17-hosting--infrastructure)
18. [Build Roadmap (Phase by Phase)](#18-build-roadmap-phase-by-phase)
19. [Project Folder Structure](#19-project-folder-structure)
20. [Future Roadmap](#20-future-roadmap)

---

## 1. Executive Summary

**MediFlow SaaS** is a multi-tenant, role-based healthcare management platform designed specifically for small to medium-sized clinics in India. It solves the fundamental operational problem that most Indian clinics face: patient data is managed on paper, in scattered spreadsheets, or in WhatsApp messages — leading to lost records, miscommunication between doctors and staff, and zero accountability.

MediFlow provides clinics with a structured, digital platform where:

- **Head Doctors** (clinic owners/admins) manage their team, approve new users, and maintain full oversight of all operations.
- **Doctors** review patient data, write clinical notes, and assign follow-up tasks to agents.
- **Agents** (front-desk/field staff) upload patient data, manage follow-up tasks assigned by doctors, and track their own patients.

The platform is delivered as a **Software-as-a-Service (SaaS)** — clinics subscribe monthly and get immediate access without any installation or IT setup.

---

## 2. Business Purpose & Problem Statement

### The Problem

India has over **1.5 million registered doctors** and millions of small clinics, nursing homes, and diagnostic centers. The overwhelming majority of these operate without any digital patient management system. The core problems are:

- **Paper records get lost.** Patient history is often unavailable during follow-up visits.
- **No accountability.** It is unclear which staff member handled which patient or task.
- **Miscommunication.** Doctors assign tasks verbally or via WhatsApp — there is no tracking, no status, no history.
- **No oversight.** Clinic owners (head doctors) have no visibility into what their team is actually doing.
- **Existing software is too expensive or too complex.** Enterprise healthcare software like Epic or Practo requires significant setup, training, and cost — completely out of reach for a 5-person clinic.

### The Opportunity

The Indian digital health market is growing rapidly. Small clinics need a simple, affordable, mobile-first platform that fits how they already work — on their smartphones, in Hindi or English, with minimal training required.

MediFlow is built from the ground up for this market:

- **Mobile-first** — doctors and agents work on phones, not laptops.
- **Affordable** — priced for small clinics, not hospital chains.
- **Simple to set up** — a clinic can be onboarded in under 10 minutes.
- **Reliable on low-end Android devices** — Flutter apps are performant even on ₹8,000 smartphones.

### The Solution

MediFlow provides a three-tier role system on a shared platform:

1. A **Flutter mobile app** for Doctors and Agents — used on Android and iOS smartphones.
2. A **Next.js web application** for Head Doctors — used for administrative oversight, approvals, and analytics.
3. A **Spring Boot REST API** backend that serves both — handles all business logic, authentication, data access, and security.

Each clinic (called a **tenant**) gets their own isolated data environment. A doctor in Clinic A can never see patients from Clinic B — this is enforced at the database level, not just the UI.

---

## 3. Target Market

### Primary Market

- Small private clinics in India (1–25 staff members)
- General practitioners, specialists, dental clinics, physiotherapy centers
- Tier 2 and Tier 3 Indian cities where digital adoption is growing but enterprise software is absent
- Clinics currently managing records on paper, WhatsApp, or basic Excel sheets

### Secondary Market

- Diagnostic centers with front-desk agents collecting patient data
- Nursing homes with multiple doctors and support staff
- Home healthcare agencies with field agents visiting patients

### Market Size

- India has approximately **6 lakh (600,000)** small private clinics
- Even 0.1% penetration = 600 paying clinics
- At ₹1,500/month average = **₹9,00,000/month (₹1.08 crore/year)** from a tiny fraction of the market

---

## 4. Business Model

### Subscription Pricing (SaaS)

MediFlow charges clinics a monthly subscription based on the number of users and features required.

| Plan | Price (Monthly) | Users | Patients | AI Features | Support |
|------|----------------|-------|----------|-------------|---------|
| **Starter** | ₹999/month | Up to 5 | 500 patients | No | Email |
| **Clinic** | ₹2,499/month | Up to 20 | Unlimited | Yes | Priority |
| **Enterprise** | Custom | Unlimited | Unlimited | Yes | Dedicated |

### Revenue Streams

1. **Monthly subscriptions** — primary revenue source.
2. **Annual plans** — 2 months free for annual commitment, improves cash flow and reduces churn.
3. **Onboarding service** — paid setup and data migration for larger clinics.
4. **White-label licensing** — sell the platform to hospital chains who want their own branded version.

### Unit Economics (Target)

- Customer Acquisition Cost (CAC): ₹2,000–₹5,000 per clinic
- Average Revenue Per User (ARPU): ₹1,500/month
- Payback period: 2–4 months
- Target Gross Margin: 70%+

---

## 5. Product Vision & Goals

### Vision

To become the most trusted and widely used patient management platform for small clinics in India — making digital healthcare management accessible to every clinic, regardless of size or technical expertise.

### Goals — Year 1

- Acquire 50 paying clinics
- Achieve ₹75,000/month in Monthly Recurring Revenue (MRR)
- Maintain less than 5% monthly churn
- Reach 4.0+ rating on Google Play Store
- Launch Android app on Google Play Store

### Goals — Year 2

- Reach 300 paying clinics
- Launch iOS app on App Store
- Expand to appointment scheduling and prescription features
- Integrate with government health ID (ABHA) system
- Explore Series A fundraising

### Core Product Principles

1. **Mobile-first.** Every critical workflow must be completable in under 3 taps on a phone.
2. **Offline-capable.** Poor network connectivity is common. The app must work offline and sync when connected.
3. **Secure.** Patient data is sensitive. Every design decision prioritizes data privacy and security.
4. **Simple.** Agents may have no tech background. The UI must be self-explanatory.
5. **Fast.** The app must feel instant, even on low-end devices and slow 4G connections.

---

## 6. How We Build This Business

### Phase 0 — Pre-launch (Months 1–2)

**Goal:** Build the core product and validate with 3–5 pilot clinics before charging.

- Identify 3–5 small clinics willing to try the platform for free
- Build the MVP (Phase 1 and 2 of the technical roadmap)
- Conduct weekly feedback calls with pilot clinic staff
- Refine onboarding flow based on real usage
- Document pain points to prioritize for next build sprint

### Phase 1 — Soft Launch (Months 3–4)

**Goal:** Convert pilot clinics to paid customers. Acquire 10–20 more.

- Publish Android app on Google Play Store
- Launch a simple landing page with pricing
- Use word-of-mouth in the medical community
- Partner with medical associations and doctor communities
- Offer 3-month free trial to early clinics

### Phase 2 — Growth (Months 5–12)

**Goal:** Reach 50 paying clinics and ₹75K MRR.

- Content marketing — blog posts on clinic management, WhatsApp forwards for doctors
- YouTube demo videos in Hindi and English
- Partner with medical equipment vendors (they already have relationships with clinics)
- Referral program — existing clinics get 1 month free for each referral
- Begin collecting testimonials and case studies

### Phase 3 — Scale (Year 2)

**Goal:** 300+ clinics, additional features, potential fundraising.

- Add appointment scheduling
- Add prescription generation with digital signatures
- Integrate with government ABHA health ID
- Launch iOS app
- Hire a sales representative for outbound clinic outreach

---

## 7. Platform Architecture Overview

MediFlow is built as a **multi-tenant SaaS** platform. This means many clinics share the same infrastructure, but their data is completely isolated from each other.

```
┌─────────────────────────────────────────────────────────────┐
│                     MEDIFLOW PLATFORM                       │
│                                                             │
│  ┌──────────────────┐    ┌──────────────────────────────┐  │
│  │  Flutter Mobile  │    │    Next.js Web App           │  │
│  │  (Doctors +      │    │    (Head Doctor admin panel) │  │
│  │   Agents)        │    │                              │  │
│  │  Android + iOS   │    │    Hosted on Vercel           │  │
│  └────────┬─────────┘    └──────────────┬───────────────┘  │
│           │                             │                   │
│           └──────────────┬──────────────┘                   │
│                          │ HTTPS / REST API                 │
│                          ▼                                  │
│           ┌──────────────────────────────┐                  │
│           │   Spring Boot REST API       │                  │
│           │   Hosted on AWS EC2          │                  │
│           │   Java 21 + Spring Boot 3.3  │                  │
│           └──────────────┬───────────────┘                  │
│                          │                                  │
│                          ▼                                  │
│           ┌──────────────────────────────┐                  │
│           │   PostgreSQL Database        │                  │
│           │   Hosted on Supabase         │                  │
│           │   Multi-tenant via org_id    │                  │
│           └──────────────────────────────┘                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Multi-Tenancy Model

Every table in the database has an `org_id` column. Every Spring Boot query includes `WHERE org_id = :currentOrgId`. The `org_id` is extracted from the user's JWT token on every API request — the client never sends it. This means:

- Clinic A's doctors cannot access Clinic B's patients — ever.
- A compromised client cannot override the tenant isolation by faking a request.
- Adding a new clinic is simply inserting a row in the `organizations` table.

---

## 8. Technical Stack — Full Breakdown

### Mobile App (Flutter)

| Technology | Purpose | Reason |
|-----------|---------|--------|
| Flutter 3.2+ | Cross-platform mobile framework | Single codebase for Android and iOS |
| Dart 3.0+ | Programming language | Fast, null-safe, works with Flutter |
| Riverpod 2.x | State management | Reactive, testable, provider-based |
| GoRouter | Navigation & deep linking | Role-based route guards built-in |
| Dio | HTTP client | JWT interceptors, retry logic, timeout handling |
| flutter_secure_storage | JWT token storage | Encrypted on-device key-value store |
| Firebase Messaging (FCM) | Push notifications | Task alerts, approval notifications |
| flutter_local_notifications | Local notification display | Show alerts when app is in foreground |
| image_picker | Camera + gallery access | Patient file uploads |
| connectivity_plus | Network status | Offline mode detection |
| cached_network_image | Image caching | Fast profile/file image loading |
| intl | Internationalisation | Date formatting, number formatting |

### Web App (Next.js — Head Doctor Only)

| Technology | Purpose | Reason |
|-----------|---------|--------|
| Next.js 15 (App Router) | React framework | Server components, fast rendering, SEO |
| TypeScript | Type safety | Fewer bugs, better IDE support |
| Tailwind CSS | Utility CSS | Fast UI development, consistent design |
| shadcn/ui | Component library | Accessible, pre-built components |
| TanStack Query | Server state management | Caching, refetching, loading states |
| Zustand | Client state | Lightweight auth/org context store |
| Recharts | Data charts | Analytics dashboard visualizations |
| Axios | HTTP client | REST API calls to Spring Boot |
| NextAuth.js | Auth session management | JWT session handling for web |

### Backend (Spring Boot)

| Technology | Purpose | Reason |
|-----------|---------|--------|
| Spring Boot 3.3 | REST API framework | Industry standard, mature ecosystem |
| Java 21 | Programming language | LTS, virtual threads, modern features |
| Spring Security | Authentication & authorization | JWT validation, role-based access control |
| Spring Data JPA | ORM layer | Database access with Hibernate |
| Hibernate | ORM implementation | SQL generation, entity mapping |
| JJWT (Java JWT) | JWT parsing & validation | Validates Supabase-issued tokens |
| Spring Web MVC | REST controllers | HTTP request handling |
| Spring Mail | Email sending | Approval notifications, welcome emails |
| Firebase Admin SDK | FCM push notifications | Send push notifications from backend |
| Lombok | Boilerplate reduction | Getters, setters, builders via annotations |
| MapStruct | DTO mapping | Entity ↔ DTO conversion |
| Flyway | Database migrations | Version-controlled schema changes |

### Database (Supabase / PostgreSQL)

| Technology | Purpose | Reason |
|-----------|---------|--------|
| PostgreSQL 15 | Primary database | Reliable, mature, powerful SQL features |
| Supabase | Hosting + Auth | Managed Postgres + Auth JWT issuance |
| Supabase Auth | User authentication | Issues JWT tokens, handles login/register |
| Supabase Storage | File storage | Patient document and image uploads |
| Supabase Realtime | Live subscriptions | Optional real-time features in web app |
| pgvector (future) | Vector embeddings | AI-powered semantic patient search |

### Infrastructure & DevOps

| Technology | Purpose | Reason |
|-----------|---------|--------|
| AWS EC2 | Backend hosting | Full control, cost-effective, scalable |
| AWS Application Load Balancer | Traffic routing | HTTPS termination, routing |
| AWS Route 53 | DNS management | Custom domain for API |
| AWS Certificate Manager | SSL certificates | Free HTTPS certificates |
| AWS S3 | Log storage, backups | DB backup storage |
| Docker | Containerization | Consistent deployment across environments |
| GitHub Actions | CI/CD pipeline | Automated build, test, deploy on push |
| Vercel | Next.js web hosting | Zero-config deployment, global CDN |
| Upstash Redis | Rate limiting, caching | API rate limiting on AI endpoints |

---

## 9. Platform Fields (Web, Mobile, Backend)

MediFlow consists of three distinct application fields, each targeting a different user and use case.

---

### Field 1 — Flutter Mobile App (Doctors & Agents)

**Who uses it:** Doctors, Agents, and Head Doctors who prefer mobile.

**Platform:** Android (primary), iOS (secondary).

**Why mobile:** In the Indian clinic environment, doctors move between consultation rooms and agents sit at front desks. Laptops are uncommon. Smartphones are universal. The app must work on mid-range Android devices (₹8,000–₹20,000 price range) running Android 8+.

**Key design principles:**
- Large touch targets (minimum 48px hit area)
- Bottom navigation bar for quick tab switching
- Floating Action Buttons (FAB) for primary actions
- Minimal steps to complete any task (max 3 taps)
- Works on slow 4G — no large asset downloads per screen
- Hindi language support planned for v2

**Navigation structure:**

```
Doctor App:
  └── Bottom Nav
        ├── Dashboard (home)
        ├── Patients (list + search)
        ├── Tasks (tasks I assigned)
        └── Profile (settings + logout)

Agent App:
  └── Bottom Nav
        ├── My Patients (own patients only)
        ├── Task Inbox (tasks assigned to me)
        └── Profile (settings + logout)

Head Doctor App:
  └── Bottom Nav
        ├── Dashboard
        ├── Approvals (pending user approvals)
        ├── Users (user management)
        └── More (audit log, settings)
```

---

### Field 2 — Next.js Web Application (Head Doctor Admin Panel)

**Who uses it:** Head Doctors (clinic owners/admins) who need oversight and analytics.

**Platform:** Desktop browser (Chrome, Firefox, Safari).

**Why web for Head Doctor:** Admin functions like reviewing audit logs, managing users, and viewing analytics benefit from a larger screen. Head Doctors are more likely to have a laptop or desktop for administrative work. The web app is a full dashboard experience — data tables, charts, filters — not suited to a 6-inch phone screen.

**URL structure:**

```
/                         → Landing page (marketing)
/pricing                  → Pricing plans
/auth/login               → Login page
/auth/register            → Clinic registration
/app/dashboard            → Admin dashboard (home)
/app/approvals            → Pending user approvals
/app/users                → All clinic users
/app/patients             → Patient list (full view)
/app/audit-log            → Audit log viewer
/app/analytics            → Charts and metrics
/app/settings/billing     → Subscription management
/app/settings/clinic      → Clinic profile settings
```

---

### Field 3 — Spring Boot REST API (Backend for All)

**Who uses it:** Both the Flutter app and the Next.js web app connect to the same Spring Boot API.

**Platform:** Deployed on AWS EC2.

**Base URL:** `https://api.mediflow.in/api/v1`

**Design principles:**
- Every endpoint validates the JWT before executing.
- Every query is scoped to `org_id` extracted from the JWT — never from the request body.
- Role checks are enforced with Spring Security's `@PreAuthorize` annotations.
- Responses are always JSON.
- Pagination is supported on all list endpoints.
- Error responses follow a consistent format: `{ "status": 400, "message": "...", "errors": [...] }`.

---

## 10. Feature List — Complete

### Head Doctor Features

#### Dashboard & Overview
- Clinic-wide statistics: total patients, active doctors, active agents, open tasks
- Recent activity feed showing the last 20 actions across the clinic
- Real-time alert banner for pending user approvals
- Quick-access shortcuts to most-used admin functions

#### User Approval System
- View all pending Doctor and Agent registration requests
- See full profile details before approving or rejecting
- Approve or reject with one click/tap
- Rejected users receive an email explaining they were not approved
- Approved users receive a welcome notification and gain immediate access

#### User Management
- View all clinic users with their role, status, and last active time
- Activate or deactivate any user account
- Search and filter users by name, role, or status
- Change a user's role (e.g., promote Agent to Doctor)
- View which patients each agent has uploaded

#### Audit Log
- Immutable log of every action performed in the clinic
- Captures: who did it, what they did, which record was affected, timestamp
- Filter by user, action type, or date range
- Export audit log to CSV for compliance reporting

#### Analytics (Clinic Plan+)
- Patients added over time (line chart)
- Task completion rate by agent (bar chart)
- Most active doctors by record creation
- Average time from task assignment to completion

#### Full Doctor Access
- Head Doctors inherit all Doctor portal features

---

### Doctor Features

#### Dashboard
- Personal stats: patients reviewed today, open tasks assigned, follow-ups pending
- Recently viewed patients (horizontal scroll cards)
- Notification feed: task completions by agents, new uploads by agents

#### Patient Management
- View all patients in the clinic (full access)
- Search patients by name, age, phone number, or condition
- Filter patients by agent, date range, finalization status
- Add new patients directly (not just agents can do this)
- View complete patient history and timeline

#### Patient Detail & Clinical Notes
- Full patient header: name, DOB, age, contact, uploaded by (agent name)
- Medical timeline showing all records sorted by date
- Filter timeline by record type: note, lab result, prescription
- Add clinical notes using a rich text editor
- Voice-to-text input for quick note dictation (uses device microphone)
- Attach files: lab PDFs, scan images, prescriptions
- Finalize patient record (marks it as reviewed, logs the action)

#### AI Summarization (Clinic Plan+)
- "Summarize Patient" button on the patient detail screen
- Sends full patient history to Claude AI via Spring Boot
- Receives a streamed summary highlighting key diagnoses, medications, and concerns
- Summary is saved to the patient record for future reference

#### Follow-Up Task Assignment
- Assign tasks to any active Agent in the clinic
- Set: linked patient, description, due date, priority (Low/Medium/High)
- View all tasks I created with live status updates
- Receive push notification when an agent updates a task status

---

### Agent Features

#### My Patients (Private View)
- View ONLY the patients this agent has uploaded — no access to others
- Patient cards: name, age, upload date, number of records, open task count
- Search within own patients by name
- Tap a patient to view their own-submitted records (not clinical notes added by doctors)

#### Upload Patient Data
- Step-by-step patient upload form
  - Step 1: Basic info — full name, DOB, gender, phone number
  - Step 2: Initial notes — chief complaint, known allergies
  - Step 3: Attach file — lab PDF or photo (optional)
- Submit creates the patient with this agent permanently set as the owner
- Confirmation screen with patient summary after successful upload

#### Task Inbox
- List of all follow-up tasks assigned to this agent
- Task cards: patient name, description, assigned by (doctor name), due date, priority badge
- Overdue tasks shown at the top with a red "Overdue" indicator
- Mark task as In Progress or Completed with a single tap
- Receive push notification on the phone when a new task is assigned (even when app is closed)

#### Notifications
- Push notification for every new task assignment
- In-app notification bell showing unread count
- Tapping a notification opens the relevant task directly

---

### Platform-Wide Features

#### Multi-Tenancy
- Every clinic is a completely isolated tenant
- Data isolation enforced at the database level via `org_id`
- One clinic can never access another clinic's data, even accidentally

#### Authentication
- Email + password login via Supabase Auth
- JWT token issued on login, stored securely on device
- Automatic token refresh before expiry
- Forced logout on account deactivation

#### Offline Mode (Mobile)
- Basic patient list cached locally using Riverpod's persistence layer
- Offline indicator banner shown when no network is detected
- Actions that require network show a clear error with retry option

#### Security
- All API communication over HTTPS
- JWT validated on every single request
- Role enforcement at the Spring Boot controller level
- No sensitive data stored in plain text on device
- Patient files accessed only via time-limited signed URLs

---

## 11. Role-Based Access Control (RBAC)

### Permission Matrix

| Feature | Head Doctor | Doctor | Agent |
|---------|:-----------:|:------:|:-----:|
| Approve user registrations | ✅ | ❌ | ❌ |
| Reject user registrations | ✅ | ❌ | ❌ |
| Deactivate users | ✅ | ❌ | ❌ |
| View all users in clinic | ✅ | ❌ | ❌ |
| View audit log | ✅ | ❌ | ❌ |
| View analytics dashboard | ✅ | ❌ | ❌ |
| View ALL patients in clinic | ✅ | ✅ | ❌ |
| View OWN patients only | ✅ | ✅ | ✅ |
| Add new patient | ✅ | ✅ | ✅ |
| Add clinical notes | ✅ | ✅ | ❌ |
| Attach files to patient | ✅ | ✅ | ✅ |
| Finalize patient record | ✅ | ✅ | ❌ |
| Assign follow-up tasks | ✅ | ✅ | ❌ |
| Receive follow-up tasks | ❌ | ❌ | ✅ |
| Mark task as complete | ❌ | ❌ | ✅ |
| View own task inbox | ❌ | ❌ | ✅ |
| Use AI summarization | ✅ | ✅ | ❌ |
| Register as new user | Public | Public | Public |

### How RBAC is Enforced

Role enforcement happens in three layers — never relying on the client alone:

1. **Flutter/Next.js UI layer** — buttons and tabs not permitted for a role are hidden. This improves UX but is NOT security.

2. **Spring Boot controller layer** — every endpoint uses `@PreAuthorize("hasRole('DOCTOR')")`. A request with the wrong role receives a `403 Forbidden` response before any business logic runs.

3. **Database query layer** — agent patient queries always include `WHERE uploaded_by = :userId` in addition to `org_id`. Even if an agent somehow bypassed the controller check, the query itself would return no unauthorized data.

---

## 12. Database Schema

All tables include `org_id UUID NOT NULL` which links every record to a specific clinic. All queries in Spring Boot automatically filter by the `org_id` from the authenticated user's JWT.

---

### Table: `organizations`

The root tenant table. Every other table has a foreign key to this.

```sql
CREATE TABLE organizations (
    id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                  TEXT NOT NULL,
    slug                  TEXT UNIQUE NOT NULL,       -- url-safe clinic identifier
    email                 TEXT NOT NULL,              -- clinic contact email
    phone                 TEXT,
    address               TEXT,
    specialty             TEXT,                       -- e.g. General, Dental, Physio
    stripe_customer_id    TEXT,                       -- Stripe customer ID
    stripe_subscription_id TEXT,                      -- Stripe subscription ID
    plan                  TEXT NOT NULL DEFAULT 'starter', -- starter | clinic | enterprise
    plan_config           JSONB,                      -- { max_users: 5, max_patients: 500, ai_enabled: false }
    subscription_status   TEXT NOT NULL DEFAULT 'active', -- active | past_due | canceled | trialing
    trial_ends_at         TIMESTAMPTZ,
    created_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

---

### Table: `users`

Extends Supabase Auth users. Every row corresponds to a real authenticated user.

```sql
CREATE TABLE users (
    id              UUID PRIMARY KEY,                 -- same as auth.users.id from Supabase
    org_id          UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    role            TEXT NOT NULL,                    -- HEAD_DOCTOR | DOCTOR | AGENT
    status          TEXT NOT NULL DEFAULT 'pending',  -- pending | active | deactivated
    full_name       TEXT NOT NULL,
    email           TEXT NOT NULL,
    phone           TEXT,
    avatar_url      TEXT,
    fcm_token       TEXT,                             -- Firebase Cloud Messaging token for push notifications
    last_active_at  TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_users_org_id ON users(org_id);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_status ON users(status);
```

---

### Table: `patients`

Core patient record. Every patient belongs to one clinic and is owned by one agent.

```sql
CREATE TABLE patients (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    org_id          UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    uploaded_by     UUID NOT NULL REFERENCES users(id),   -- agent who created this record
    full_name       TEXT NOT NULL,
    date_of_birth   DATE,
    gender          TEXT,                                  -- Male | Female | Other
    phone           TEXT,
    address         TEXT,
    blood_group     TEXT,
    known_allergies TEXT,
    chief_complaint TEXT,                                  -- initial complaint at time of upload
    is_finalized    BOOLEAN NOT NULL DEFAULT FALSE,        -- marked reviewed by a doctor
    finalized_by    UUID REFERENCES users(id),
    finalized_at    TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_patients_org_id ON patients(org_id);
CREATE INDEX idx_patients_uploaded_by ON patients(uploaded_by);
CREATE INDEX idx_patients_full_name ON patients USING GIN (to_tsvector('english', full_name));
```

---

### Table: `medical_records`

Clinical notes, lab results, and prescriptions attached to a patient.

```sql
CREATE TABLE medical_records (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    org_id          UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    patient_id      UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
    author_id       UUID NOT NULL REFERENCES users(id),   -- doctor or head_doctor who wrote this
    record_type     TEXT NOT NULL,                        -- note | lab_result | prescription | file
    title           TEXT,
    content         TEXT,                                 -- rich text content (plain text or JSON for rich text)
    file_url        TEXT,                                 -- Supabase Storage URL (if file attached)
    file_name       TEXT,
    file_size_bytes BIGINT,
    ai_summary      TEXT,                                 -- Claude-generated summary (nullable)
    is_ai_summary   BOOLEAN NOT NULL DEFAULT FALSE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_medical_records_patient_id ON medical_records(patient_id);
CREATE INDEX idx_medical_records_org_id ON medical_records(org_id);
CREATE INDEX idx_medical_records_author_id ON medical_records(author_id);
```

---

### Table: `follow_up_tasks`

Tasks created by doctors and assigned to agents.

```sql
CREATE TABLE follow_up_tasks (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    org_id          UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    patient_id      UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
    assigned_by     UUID NOT NULL REFERENCES users(id),   -- doctor who created the task
    assigned_to     UUID NOT NULL REFERENCES users(id),   -- agent who must complete it
    title           TEXT NOT NULL,
    description     TEXT,
    priority        TEXT NOT NULL DEFAULT 'medium',       -- low | medium | high
    status          TEXT NOT NULL DEFAULT 'pending',      -- pending | in_progress | completed | cancelled
    due_date        DATE,
    completed_at    TIMESTAMPTZ,
    cancelled_at    TIMESTAMPTZ,
    cancellation_reason TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_tasks_org_id ON follow_up_tasks(org_id);
CREATE INDEX idx_tasks_assigned_to ON follow_up_tasks(assigned_to);
CREATE INDEX idx_tasks_assigned_by ON follow_up_tasks(assigned_by);
CREATE INDEX idx_tasks_patient_id ON follow_up_tasks(patient_id);
CREATE INDEX idx_tasks_status ON follow_up_tasks(status);
```

---

### Table: `audit_logs`

Immutable record of every significant action taken in the system.

```sql
CREATE TABLE audit_logs (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    org_id          UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    actor_id        UUID REFERENCES users(id),            -- who performed the action
    actor_name      TEXT,                                 -- denormalized in case user is deleted
    action          TEXT NOT NULL,                        -- e.g. PATIENT_CREATED, TASK_COMPLETED, USER_APPROVED
    entity_type     TEXT,                                 -- e.g. patient | task | user
    entity_id       UUID,                                 -- ID of the affected record
    entity_name     TEXT,                                 -- denormalized name for display
    metadata        JSONB,                                -- additional context (e.g. old vs new status)
    ip_address      TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_audit_logs_org_id ON audit_logs(org_id);
CREATE INDEX idx_audit_logs_actor_id ON audit_logs(actor_id);
CREATE INDEX idx_audit_logs_created_at ON audit_logs(created_at DESC);
```

---

### Table: `notifications`

In-app notifications for users (separate from FCM push notifications).

```sql
CREATE TABLE notifications (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    org_id          UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    recipient_id    UUID NOT NULL REFERENCES users(id),
    title           TEXT NOT NULL,
    body            TEXT NOT NULL,
    type            TEXT NOT NULL,         -- task_assigned | task_completed | user_approved | patient_uploaded
    entity_type     TEXT,                  -- task | patient | user
    entity_id       UUID,
    is_read         BOOLEAN NOT NULL DEFAULT FALSE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_notifications_recipient_id ON notifications(recipient_id);
CREATE INDEX idx_notifications_is_read ON notifications(is_read);
```

---

### Table: `patient_attachments`

Tracks files uploaded to Supabase Storage for patients.

```sql
CREATE TABLE patient_attachments (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    org_id          UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    patient_id      UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
    medical_record_id UUID REFERENCES medical_records(id),
    uploaded_by     UUID NOT NULL REFERENCES users(id),
    file_name       TEXT NOT NULL,
    file_type       TEXT NOT NULL,         -- image/jpeg | application/pdf | etc.
    file_size_bytes BIGINT,
    storage_path    TEXT NOT NULL,         -- path in Supabase Storage bucket
    public_url      TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_attachments_patient_id ON patient_attachments(patient_id);
```

---

### Entity Relationship Diagram (Summary)

```
organizations
    │
    ├── users (many)
    │     └── role: HEAD_DOCTOR | DOCTOR | AGENT
    │
    ├── patients (many)
    │     ├── uploaded_by → users.id (agent)
    │     ├── medical_records (many)
    │     │     └── author_id → users.id (doctor)
    │     ├── follow_up_tasks (many)
    │     │     ├── assigned_by → users.id (doctor)
    │     │     └── assigned_to → users.id (agent)
    │     └── patient_attachments (many)
    │
    ├── audit_logs (many)
    └── notifications (many)
```

---

## 13. API Design

### Base URL

```
Production:  https://api.mediflow.in/api/v1
Development: http://localhost:8080/api/v1
```

### Standard Response Format

**Success:**
```json
{
  "status": 200,
  "message": "Success",
  "data": { ... }
}
```

**Paginated list:**
```json
{
  "status": 200,
  "data": [ ... ],
  "pagination": {
    "page": 0,
    "size": 20,
    "totalElements": 154,
    "totalPages": 8
  }
}
```

**Error:**
```json
{
  "status": 400,
  "message": "Validation failed",
  "errors": [
    { "field": "full_name", "message": "Full name is required" }
  ]
}
```

---

### Auth Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `POST` | `/auth/register` | Public | Register new user (creates pending account) |
| `POST` | `/auth/login` | Public | Login, returns JWT token |
| `POST` | `/auth/refresh` | Public | Refresh JWT token |
| `PUT` | `/auth/fcm-token` | Required | Update device FCM token after login |

---

### User Endpoints

| Method | Endpoint | Role | Description |
|--------|----------|------|-------------|
| `GET` | `/users` | HEAD_DOCTOR | Get all clinic users |
| `GET` | `/users/pending` | HEAD_DOCTOR | Get pending approval requests |
| `GET` | `/users/{id}` | HEAD_DOCTOR | Get specific user profile |
| `PATCH` | `/users/{id}/approve` | HEAD_DOCTOR | Approve a pending user |
| `PATCH` | `/users/{id}/reject` | HEAD_DOCTOR | Reject a pending user |
| `PATCH` | `/users/{id}/deactivate` | HEAD_DOCTOR | Deactivate an active user |
| `PATCH` | `/users/{id}/activate` | HEAD_DOCTOR | Re-activate a deactivated user |
| `GET` | `/users/me` | All | Get own profile |
| `PUT` | `/users/me` | All | Update own profile |

---

### Patient Endpoints

| Method | Endpoint | Role | Description |
|--------|----------|------|-------------|
| `GET` | `/patients` | HD, DOCTOR | All org patients. Params: `?search=&agentId=&page=&size=` |
| `GET` | `/patients/mine` | AGENT | Own patients only (uploaded_by = me) |
| `GET` | `/patients/{id}` | All | Patient detail. Agents: only own patients. |
| `POST` | `/patients` | All | Create new patient. `uploaded_by` auto-set from JWT. |
| `PUT` | `/patients/{id}` | HD, DOCTOR | Update patient basic info |
| `PATCH` | `/patients/{id}/finalize` | HD, DOCTOR | Mark patient as reviewed/finalized |
| `DELETE` | `/patients/{id}` | HD | Soft-delete a patient (sets deleted_at) |

---

### Medical Record Endpoints

| Method | Endpoint | Role | Description |
|--------|----------|------|-------------|
| `GET` | `/patients/{id}/records` | HD, DOCTOR | All medical records for a patient |
| `POST` | `/patients/{id}/records` | HD, DOCTOR | Add a clinical note, lab result, or prescription |
| `PUT` | `/patients/{id}/records/{recordId}` | HD, DOCTOR | Edit a record (own records only) |
| `DELETE` | `/patients/{id}/records/{recordId}` | HD | Soft-delete a record |
| `GET` | `/patients/{id}/upload-url` | All | Get signed Supabase Storage URL for file upload |
| `POST` | `/patients/{id}/summarize` | HD, DOCTOR | AI summarize patient history (Clinic plan only). Returns SSE stream. |

---

### Task Endpoints

| Method | Endpoint | Role | Description |
|--------|----------|------|-------------|
| `POST` | `/tasks` | HD, DOCTOR | Create follow-up task. Sends FCM push to agent. |
| `GET` | `/tasks/assigned-by-me` | HD, DOCTOR | Tasks I created. Params: `?status=&page=` |
| `GET` | `/tasks/my-inbox` | AGENT | Tasks assigned to me. Params: `?status=&page=` |
| `GET` | `/tasks/{id}` | All | Task detail (own tasks only) |
| `PATCH` | `/tasks/{id}/status` | AGENT | Update status: `in_progress` or `completed`. Sends FCM to doctor. |
| `PATCH` | `/tasks/{id}/cancel` | HD, DOCTOR | Cancel a task with optional reason |

---

### Audit Log & Notification Endpoints

| Method | Endpoint | Role | Description |
|--------|----------|------|-------------|
| `GET` | `/audit-logs` | HEAD_DOCTOR | Paginated audit log. Params: `?userId=&from=&to=&action=` |
| `GET` | `/notifications` | All | Own notifications. Params: `?isRead=&page=` |
| `PATCH` | `/notifications/{id}/read` | All | Mark notification as read |
| `PATCH` | `/notifications/read-all` | All | Mark all notifications as read |

---

### Analytics Endpoints (Head Doctor, Clinic Plan+)

| Method | Endpoint | Role | Description |
|--------|----------|------|-------------|
| `GET` | `/analytics/overview` | HEAD_DOCTOR | Totals: patients, doctors, agents, tasks |
| `GET` | `/analytics/patients-over-time` | HEAD_DOCTOR | Patient count grouped by week/month |
| `GET` | `/analytics/task-completion` | HEAD_DOCTOR | Task completion rate by agent |
| `GET` | `/analytics/agent-performance` | HEAD_DOCTOR | Upload and task counts per agent |

---

## 14. Authentication & Security

### Authentication Flow

```
1. User opens Flutter app
2. User enters email + password
3. Flutter calls POST /auth/login
4. Spring Boot delegates to Supabase Auth
5. Supabase Auth validates credentials, returns JWT
6. Spring Boot returns JWT to Flutter
7. Flutter stores JWT in flutter_secure_storage
8. Dio interceptor adds "Authorization: Bearer {JWT}" to every request
9. Spring Boot JwtFilter validates the JWT signature using Supabase JWKS endpoint
10. Spring Boot extracts userId, orgId, role from JWT claims
11. Spring Boot sets SecurityContext with these values
12. Controller processes request, query scoped to orgId
```

### JWT Validation in Spring Boot

```java
// JwtAuthenticationFilter.java
@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain chain) {

        String token = extractToken(request);
        if (token != null) {
            Claims claims = jwtService.validateAndParseClaims(token);
            String userId = claims.getSubject();
            String orgId = claims.get("org_id", String.class);
            String role = claims.get("role", String.class);

            // Set security context
            UserPrincipal principal = new UserPrincipal(userId, orgId, role);
            UsernamePasswordAuthenticationToken auth =
                new UsernamePasswordAuthenticationToken(principal, null, principal.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(auth);
        }
        chain.doFilter(request, response);
    }
}
```

### Multi-Tenant Query Scoping

Every Spring Data JPA repository uses a base repository that automatically includes `org_id` in all queries:

```java
// Base repository approach using @Query
@Repository
public interface PatientRepository extends JpaRepository<Patient, UUID> {

    @Query("SELECT p FROM Patient p WHERE p.orgId = :orgId")
    Page<Patient> findAllByOrgId(@Param("orgId") UUID orgId, Pageable pageable);

    @Query("SELECT p FROM Patient p WHERE p.orgId = :orgId AND p.uploadedBy = :userId")
    Page<Patient> findAllByOrgIdAndUploadedBy(@Param("orgId") UUID orgId,
                                               @Param("userId") UUID userId,
                                               Pageable pageable);
}
```

### Security Checklist

- [x] All endpoints require valid JWT (except `/auth/login` and `/auth/register`)
- [x] Role checks enforced with `@PreAuthorize` at controller level
- [x] All queries include `org_id` filter
- [x] Agent patient queries also include `uploaded_by` filter
- [x] Signed URLs for file access (time-limited, expire in 1 hour)
- [x] No sensitive data in JWT claims (no passwords, no medical data)
- [x] HTTPS enforced in production (AWS Certificate Manager)
- [x] SQL injection prevented by JPA parameterized queries
- [x] Input validation on all request bodies with Spring Validation
- [x] Rate limiting on AI endpoints via Upstash Redis
- [x] Audit log written for every sensitive action

---

## 15. Notifications System

MediFlow uses two types of notifications working together:

### 1. FCM Push Notifications (Spring Boot → Firebase → Device)

Used for high-priority real-time alerts that must reach the user even when the app is closed.

**Events that trigger FCM:**

| Event | Who Receives | Message |
|-------|-------------|---------|
| New task assigned | The assigned Agent | "Dr. Sharma assigned you a follow-up for Ramesh Kumar" |
| Task marked complete | The assigning Doctor | "Priya marked your task for Ramesh Kumar as complete" |
| User account approved | The approved User | "Your account has been approved. Welcome to MediFlow!" |
| New pending approval | Head Doctor | "A new Doctor registration is waiting for your approval" |

**Spring Boot sends FCM:**
```java
// NotificationService.java
public void sendPush(String fcmToken, String title, String body) {
    Message message = Message.builder()
        .setToken(fcmToken)
        .setNotification(Notification.builder()
            .setTitle(title)
            .setBody(body)
            .build())
        .build();
    FirebaseMessaging.getInstance().send(message);
}
```

### 2. In-App Notifications (Database)

Stored in the `notifications` table. Shown in the notification bell in the app. Read status tracked per user.

The Flutter app fetches unread notifications on app open and shows a badge count on the bell icon. Users can mark all as read with one tap.

---

## 16. AI Features

AI features are available on the **Clinic plan and above** only. They are gated in Spring Boot by checking `organization.plan_config.ai_enabled` before executing.

### Feature 1 — AI Patient Summary

**What it does:** Takes the full medical history of a patient (all clinical notes, lab results, diagnoses) and generates a concise clinical summary.

**How it works:**

```
Flutter taps "Summarize" button
         ↓
POST /api/v1/patients/{id}/summarize
         ↓
Spring Boot fetches all medical records for this patient
         ↓
Spring Boot checks: organization.plan_config.ai_enabled = true
         ↓
Spring Boot constructs prompt:
  "You are a clinical assistant. Summarize the following patient
   history for a doctor in 200-300 words. Highlight key diagnoses,
   current medications, and concerning trends.
   Patient: {name}, Age: {age}
   Records: {all records joined}"
         ↓
Claude API call (claude-sonnet-4-6 model)
         ↓
Spring Boot streams SSE response back to Flutter
         ↓
Flutter displays text progressively as it arrives
         ↓
Final summary saved to medical_records with is_ai_summary = true
```

### Feature 2 — Smart Task Suggestions

**What it does:** After reviewing a patient's history, Claude suggests follow-up actions a doctor might want to assign to agents.

**Example output:**
- "Schedule a blood pressure check in 2 weeks"
- "Follow up with patient regarding medication compliance"
- "Arrange home visit to verify wound healing"

The doctor sees these as suggestion chips and can tap to create the task instantly.

### Feature 3 — Voice-to-Text Notes

**What it does:** Agent or Doctor holds the mic button and speaks — their speech is transcribed into the clinical notes text field.

**Implementation:** Uses the device's built-in speech-to-text (`speech_to_text` Flutter package). No external API needed for this — the device handles it locally. No additional cost.

---

## 17. Hosting & Infrastructure

### AWS EC2 (Spring Boot Backend)

**Instance type:** `t3.small` to start (2 vCPU, 2GB RAM). Upgrade to `t3.medium` at 50+ clinics.

**Setup:**
- Ubuntu 22.04 LTS
- Docker installed, Spring Boot runs as a Docker container
- Nginx as reverse proxy for HTTPS termination
- AWS Certificate Manager for SSL certificate
- AWS Route 53 DNS pointing `api.mediflow.in` to EC2 IP

**Deployment pipeline (GitHub Actions):**
```yaml
# .github/workflows/deploy.yml
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Build Docker image
        run: docker build -t mediflow-api .
      - name: Push to ECR
        run: docker push {aws-ecr-repo}/mediflow-api
      - name: SSH to EC2 and restart container
        run: ssh ec2-user@{ip} "docker pull && docker-compose up -d"
```

**EC2 estimated cost at launch:**
- `t3.small`: ~$15/month
- Scales to `t3.medium` (~$35/month) or Auto Scaling Group at growth

### Supabase (PostgreSQL Database)

- Free tier: up to 500MB, 2 projects — sufficient for MVP
- Pro tier ($25/month): unlimited projects, 8GB, daily backups, point-in-time recovery
- Connection pooling via PgBouncer (built into Supabase) — required for Spring Boot's connection pool

**Spring Boot datasource config:**
```properties
spring.datasource.url=jdbc:postgresql://db.{supabase-id}.supabase.co:5432/postgres
spring.datasource.username=postgres
spring.datasource.password={your-db-password}
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=validate
spring.flyway.enabled=true
```

### Vercel (Next.js Web App)

- Zero-config deployment — push to `main` branch, Vercel auto-deploys
- Global CDN — fast load times across India
- Free tier sufficient for MVP (100GB bandwidth, unlimited deployments)
- Custom domain: `app.mediflow.in`

### Supabase Storage (File Storage)

- Patient documents and images stored in Supabase Storage buckets
- Spring Boot generates signed URLs (1-hour expiry) for secure access
- Flutter uploads directly to Storage using the signed URL (Spring Boot never handles file bytes)
- Bucket naming: `mediflow-{org_id}` — one bucket per clinic for isolation

### Cost Summary (Monthly at Launch)

| Service | Cost |
|---------|------|
| AWS EC2 t3.small | ~$15 |
| Supabase Pro | $25 |
| Vercel (Hobby) | $0 |
| Firebase (FCM) | $0 |
| Claude API (pay-per-use) | ~$10–30 |
| Domain + Route 53 | ~$5 |
| **Total** | **~$55–75/month** |

Break-even at just **2 Starter plan clinics (₹999 × 2 = ₹2,000/month ≈ $24)** or **1 Clinic plan subscriber**.

---

## 18. Build Roadmap (Phase by Phase)

### Phase 1 — Foundation (Weeks 1–2)

**Goal:** Backend skeleton + auth working end-to-end.

- [ ] Initialize Spring Boot project with correct dependencies
- [ ] Set up Docker and docker-compose for local development
- [ ] Create Supabase project, run initial schema migrations with Flyway
- [ ] Implement JWT filter to validate Supabase tokens
- [ ] Build `/auth/register` and `/auth/login` endpoints
- [ ] Build `/users/me` endpoint to verify auth works
- [ ] Set up multi-tenant base repositories with `org_id` scoping
- [ ] Implement audit log service (write a log entry on every mutation)
- [ ] Set up GitHub Actions CI pipeline (build + test on push)

**Deliverable:** A Spring Boot API that authenticates requests, scopes data to the correct clinic, and writes audit logs.

---

### Phase 2 — Agent Portal Mobile App (Weeks 3–4)

**Goal:** Flutter app where an agent can log in, upload a patient, and manage tasks.

- [ ] Initialize Flutter project with Riverpod, GoRouter, Dio
- [ ] Build login screen with Supabase Auth integration
- [ ] Store JWT in flutter_secure_storage, add Dio interceptor
- [ ] Build role-based navigation (agent sees 3 tabs)
- [ ] Build "My Patients" screen — list + search
- [ ] Build "Upload Patient" multi-step form
- [ ] Build "Task Inbox" screen with status update buttons
- [ ] Integrate FCM — store token on login, receive push notifications
- [ ] Build Spring Boot patient and task endpoints (AGENT role)
- [ ] Build FCM push notification sending in Spring Boot (Firebase Admin SDK)

**Deliverable:** A fully working agent mobile app. An agent can register, wait for approval, log in, upload patients, and manage tasks.

---

### Phase 3 — Doctor Portal Mobile App (Weeks 5–6)

**Goal:** Flutter screens for Doctors to manage patients and assign tasks.

- [ ] Build Doctor navigation (4 tabs: Dashboard, Patients, Tasks, Profile)
- [ ] Build Patient List screen with full search and filters
- [ ] Build Patient Detail screen with medical timeline
- [ ] Build Add Clinical Note screen (text field + voice input)
- [ ] Build file attachment flow (pick file → get signed URL → upload)
- [ ] Build Assign Task bottom sheet (agent picker + form)
- [ ] Build Task Tracker screen (tasks I created)
- [ ] Build Spring Boot doctor endpoints (patient list all, records CRUD, task assign)
- [ ] Add real-time task status push notifications to Doctor

**Deliverable:** Doctors can view all patients, write clinical notes, attach files, and assign tasks to agents with real-time status tracking.

---

### Phase 4 — Head Doctor Web App (Weeks 7–8)

**Goal:** Next.js web dashboard for clinic admins.

- [ ] Initialize Next.js project with TypeScript, Tailwind, shadcn/ui
- [ ] Build login page and JWT session management
- [ ] Build Admin Dashboard page with stat cards
- [ ] Build Approval Queue page (table + approve/reject actions)
- [ ] Build User Management page (list + deactivate/activate)
- [ ] Build Audit Log page (filterable table + CSV export)
- [ ] Build Spring Boot endpoints for all Head Doctor admin actions
- [ ] Add Head Doctor navigation to Flutter app (inherit Doctor tabs + admin tab)

**Deliverable:** Head Doctors have a full web admin panel to manage their clinic.

---

### Phase 5 — AI Features (Weeks 9–10)

**Goal:** Add Claude AI summarization and smart task suggestions.

- [ ] Build Spring Boot AI service (Claude API client + streaming)
- [ ] Build `POST /patients/{id}/summarize` endpoint (SSE streaming)
- [ ] Add plan gate check (only Clinic plan+ gets AI)
- [ ] Build Flutter SSE client to stream and display AI summary progressively
- [ ] Add "Summarize" button on Patient Detail screen (hidden for Starter plan)
- [ ] Build smart task suggestion feature (Claude suggests tasks from notes)
- [ ] Add AI token usage tracking per organization
- [ ] Add upgrade prompt when a Starter plan user tries to access AI

**Deliverable:** Clinic plan doctors can get AI summaries of patient history with one tap.

---

### Phase 6 — Polish, Testing & Launch (Weeks 11–13)

**Goal:** Production-ready, tested, and launched on Google Play Store.

- [ ] Set up AWS EC2 production server with Docker + Nginx
- [ ] Configure Route 53 and SSL certificate for `api.mediflow.in`
- [ ] Set up Supabase Pro with daily backups
- [ ] Write Flyway migration scripts for all schema changes
- [ ] Write unit tests for Spring Boot service layer (JUnit 5 + Mockito)
- [ ] Write integration tests for all API endpoints
- [ ] Write Flutter widget tests for all screens
- [ ] Performance test: ensure patient list loads in < 1 second with 1,000 patients
- [ ] Security audit: verify org isolation with cross-tenant request tests
- [ ] Build Flutter Android release APK + submit to Google Play Store
- [ ] Deploy Next.js web app to Vercel with production environment variables
- [ ] Set up error monitoring (Sentry for both Flutter and Spring Boot)
- [ ] Set up uptime monitoring (UptimeRobot for API health checks)
- [ ] Write user documentation and in-app onboarding tooltips
- [ ] Conduct UAT with 3 pilot clinics
- [ ] Fix all critical bugs from UAT feedback
- [ ] Official launch

---

## 19. Project Folder Structure

### Spring Boot Backend

```
mediflow-backend/
├── src/
│   ├── main/
│   │   ├── java/com/mediflow/
│   │   │   ├── MediFlowApplication.java
│   │   │   ├── config/
│   │   │   │   ├── SecurityConfig.java
│   │   │   │   ├── JwtAuthFilter.java
│   │   │   │   ├── FirebaseConfig.java
│   │   │   │   └── CorsConfig.java
│   │   │   ├── controller/
│   │   │   │   ├── AuthController.java
│   │   │   │   ├── UserController.java
│   │   │   │   ├── PatientController.java
│   │   │   │   ├── MedicalRecordController.java
│   │   │   │   ├── TaskController.java
│   │   │   │   ├── AuditLogController.java
│   │   │   │   ├── NotificationController.java
│   │   │   │   └── AnalyticsController.java
│   │   │   ├── service/
│   │   │   │   ├── AuthService.java
│   │   │   │   ├── UserService.java
│   │   │   │   ├── PatientService.java
│   │   │   │   ├── MedicalRecordService.java
│   │   │   │   ├── TaskService.java
│   │   │   │   ├── AuditLogService.java
│   │   │   │   ├── NotificationService.java
│   │   │   │   ├── FirebaseMessagingService.java
│   │   │   │   ├── StorageService.java
│   │   │   │   └── AiSummaryService.java
│   │   │   ├── repository/
│   │   │   │   ├── OrganizationRepository.java
│   │   │   │   ├── UserRepository.java
│   │   │   │   ├── PatientRepository.java
│   │   │   │   ├── MedicalRecordRepository.java
│   │   │   │   ├── TaskRepository.java
│   │   │   │   ├── AuditLogRepository.java
│   │   │   │   └── NotificationRepository.java
│   │   │   ├── entity/
│   │   │   │   ├── Organization.java
│   │   │   │   ├── User.java
│   │   │   │   ├── Patient.java
│   │   │   │   ├── MedicalRecord.java
│   │   │   │   ├── FollowUpTask.java
│   │   │   │   ├── AuditLog.java
│   │   │   │   └── Notification.java
│   │   │   ├── dto/
│   │   │   │   ├── request/
│   │   │   │   └── response/
│   │   │   ├── exception/
│   │   │   │   ├── GlobalExceptionHandler.java
│   │   │   │   ├── UnauthorizedException.java
│   │   │   │   ├── ForbiddenException.java
│   │   │   │   └── NotFoundException.java
│   │   │   └── util/
│   │   │       ├── SecurityUtils.java
│   │   │       └── PaginationUtils.java
│   │   └── resources/
│   │       ├── application.yml
│   │       ├── application-dev.yml
│   │       ├── application-prod.yml
│   │       └── db/migration/
│   │           ├── V1__create_organizations.sql
│   │           ├── V2__create_users.sql
│   │           ├── V3__create_patients.sql
│   │           ├── V4__create_medical_records.sql
│   │           ├── V5__create_follow_up_tasks.sql
│   │           ├── V6__create_audit_logs.sql
│   │           └── V7__create_notifications.sql
│   └── test/
│       └── java/com/mediflow/
├── Dockerfile
├── docker-compose.yml
└── pom.xml
```

### Flutter Mobile App

```
mediflow-mobile/
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── router.dart
│   │   ├── theme.dart
│   │   ├── constants.dart
│   │   └── di.dart                        # Dependency injection setup
│   ├── services/
│   │   ├── api_service.dart               # Dio HTTP client + interceptors
│   │   ├── auth_service.dart
│   │   ├── storage_service.dart           # flutter_secure_storage
│   │   └── fcm_service.dart
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   ├── patient_provider.dart
│   │   ├── task_provider.dart
│   │   └── notification_provider.dart
│   ├── models/
│   │   ├── user.dart
│   │   ├── patient.dart
│   │   ├── medical_record.dart
│   │   ├── task.dart
│   │   └── notification.dart
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   ├── head_doctor/
│   │   │   ├── hd_dashboard_screen.dart
│   │   │   ├── approval_queue_screen.dart
│   │   │   ├── user_management_screen.dart
│   │   │   └── audit_log_screen.dart
│   │   ├── doctor/
│   │   │   ├── doctor_dashboard_screen.dart
│   │   │   ├── patient_list_screen.dart
│   │   │   ├── patient_detail_screen.dart
│   │   │   ├── add_note_screen.dart
│   │   │   └── task_tracker_screen.dart
│   │   ├── agent/
│   │   │   ├── my_patients_screen.dart
│   │   │   ├── upload_patient_screen.dart
│   │   │   └── task_inbox_screen.dart
│   │   └── shared/
│   │       ├── profile_screen.dart
│   │       └── notification_screen.dart
│   └── widgets/
│       ├── patient_card.dart
│       ├── task_card.dart
│       ├── stat_card.dart
│       ├── medical_timeline.dart
│       └── ai_summary_panel.dart
├── android/
├── ios/
├── pubspec.yaml
└── README.md
```

### Next.js Web App

```
mediflow-web/
├── app/
│   ├── (marketing)/
│   │   ├── page.tsx                       # Landing page
│   │   └── pricing/page.tsx
│   ├── auth/
│   │   ├── login/page.tsx
│   │   └── register/page.tsx
│   └── app/
│       ├── layout.tsx                     # Authenticated shell
│       ├── dashboard/page.tsx
│       ├── approvals/page.tsx
│       ├── users/page.tsx
│       ├── patients/page.tsx
│       ├── audit-log/page.tsx
│       ├── analytics/page.tsx
│       └── settings/
│           ├── billing/page.tsx
│           └── clinic/page.tsx
├── components/
│   ├── ui/                                # shadcn/ui components
│   ├── tables/
│   ├── charts/
│   └── layout/
├── lib/
│   ├── api.ts                             # Axios client
│   └── auth.ts
├── types/
└── package.json
```

---

## 20. Future Roadmap

### Version 1.1 — Appointment Scheduling
- Allow patients to book appointments via a shared clinic link
- Doctor calendar view with available slots
- SMS reminder to patient 24 hours before appointment

### Version 1.2 — Prescription Generation
- Doctor creates a digital prescription from the patient detail screen
- Auto-fills doctor name, registration number, clinic details
- Generates a shareable PDF prescription
- WhatsApp share button for sending to patient

### Version 1.3 — Multi-language Support
- Hindi interface for agents and doctors who prefer Hindi
- Language selector in profile settings
- All error messages and notifications in selected language

### Version 1.4 — ABHA Integration
- Integration with Ayushman Bharat Health Account (ABHA) system
- Auto-fill patient details using ABHA ID
- Share records to national health record system

### Version 2.0 — iOS App
- Full iOS app on App Store
- Same codebase (Flutter already supports iOS)
- Apple Health integration for vitals data

### Version 2.1 — Analytics & Reporting
- Monthly clinic performance reports (auto-generated PDF)
- Patient trend analysis
- Agent productivity benchmarks
- Revenue and visit volume tracking

### Version 3.0 — Telemedicine
- In-app video consultation between doctor and patient
- WebRTC-based video call with no third-party dependency
- Consultation notes linked directly to patient record

---

## Summary

MediFlow SaaS is a focused, mobile-first healthcare platform built for the Indian clinic market. It solves a real, widespread problem with a technically sound and commercially viable approach:

- **Flutter mobile app** — fast, cross-platform, works on affordable Android devices
- **Next.js web app** — rich admin dashboard for clinic owners
- **Spring Boot backend** — secure, scalable REST API with strong multi-tenancy
- **Supabase PostgreSQL** — managed database with built-in Auth and Storage
- **AWS EC2** — full-control backend hosting, cost-effective at scale

The architecture is designed to start small (one developer, ~$75/month infrastructure) and scale gracefully as the clinic base grows. By starting with the Agent and Doctor mobile portals and validating with real clinics before building every feature, MediFlow follows a lean product development approach — build what users need, ship it fast, and iterate based on real feedback.

---

*This document is the single source of truth for the MediFlow SaaS platform. Update it as decisions are made and the product evolves.*
