# MediFlow Onboarding & Authentication Flow (Production-Ready)

This document outlines the secure, scalable process for clinic registration, staff invitation, and role-based authentication.

---

## 1. Identified Design Principles (Security & UX)

### **Principle 1: Token-Based Invites (Security)**
- **Problem:** Static clinic codes (e.g., `MED-DELHI-123`) leak easily and attract spam.
- **Solution:** Use time-limited, configurable-use invite tokens.
- **Expiry:** 48 hours default.
- **Auditability:** Track not just usage count, but exactly *who* used it and *when*.

### **Principle 2: Pre-encoded Hierarchy (Scalability)**
- **Problem:** Dropdowns for selecting doctors are confusing and prone to error.
- **Solution:** The invite link itself encodes the `assigned_doctor_id`. The Agent simply signs in; the relationship is handled by the backend automatically.

### **Principle 3: Double-Validation Strategy (Reliability)**
- **Problem:** Tokens can expire mid-registration (e.g., user starts at hour 47, finishes at hour 49).
- **Solution:** 
    1.  **UX Check:** `GET /validate/{token}` on app open to show a friendly preview (Clinic Name, Role).
    2.  **Security Check:** Re-validate the token during `POST /register/staff`. If expired, return `410 GONE` with a clear message.

### **Principle 4: Operational Efficiency (Scale)**
- **Solution:** Implement **Bulk Invites** and an **Auto-approve** toggle in the Head Doctor's settings for high-trust environments.

---

## 2. Role-Based Registration Flows

### **A. Head Doctor (Clinic Owner)**
1. **Source:** Goes to `app.mediflow.in/register`.
2. **Endpoint:** `POST /api/v1/auth/register/head-doctor` (Public).
3. **Form:** Fills Clinic Name, Specialty, Full Name, Email, and Password.
4. **Backend:** Creates `Organization` + `User` (Role: `HEAD_DOCTOR`, Status: `ACTIVE`).
5. **Result:** Lands on Dashboard immediately.

### **B. Doctor (Joins via Head Doctor)**
1. **Invite:** Head Doctor generates "Invite Doctor" token and WhatsApps the link.
2. **Entry:** Doctor taps link on phone → opens MediFlow App.
3. **Pre-flow:** App calls `GET /api/v1/invites/validate/{token}` → identifies Organization.
4. **Auth:** Doctor signs in (Google/Email).
5. **Endpoint:** `POST /api/v1/auth/register/staff` (Requires valid token).
6. **Backend:** Creates User (Role: `DOCTOR`, Status: `PENDING`).
7. **Approval:** Head Doctor receives push notification → Approves.

### **C. Agent (Joins via Doctor)**
1. **Invite:** Doctor generates "Invite Agent" token (pre-linked to their `doctor_id`) and WhatsApps it.
2. **Entry:** Agent taps link on phone → opens MediFlow App.
3. **Pre-flow:** App validates token → identifies Organization and Assigned Doctor.
4. **Auth:** Agent signs in (one-tap Google OAuth).
5. **Endpoint:** `POST /api/v1/auth/register/staff` (Requires valid token).
6. **Backend:** Creates User (Role: `AGENT`, Status: `PENDING`, `assigned_doctor_id` set).
7. **Approval:** The specific **Doctor** (not Head Doctor) approves the Agent via push notification.

---

## 3. Universal Login Flow (All Roles)

1. **Identity:** User enters Email/Password OR taps "Sign in with Google" via Supabase Auth.
2. **Token:** Supabase issues a JWT.
3. **Validation:** Flutter sends JWT to Spring Boot `GET /users/me`.
4. **Status Branching:**
    - **`PENDING`**: Flutter shows "Waiting for your Head Doctor/Doctor to approve you."
    - **`DEACTIVATED`**: Flutter shows "Account suspended. Contact your administrator."
    - **`ACTIVE`**: Flutter reads the role from the response and routes to the correct Dashboard.

---

## 4. Implementation Requirements

### **Database Schema (Invitation Tokens)**
```sql
CREATE TABLE invitation_tokens (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    token           TEXT UNIQUE NOT NULL,
    org_id          UUID NOT NULL REFERENCES organizations(id),
    role            TEXT NOT NULL,              -- DOCTOR | AGENT
    generated_by    UUID NOT NULL REFERENCES users(id),
    assigned_doctor_id UUID REFERENCES users(id), -- set for AGENT invites
    expires_at      TIMESTAMPTZ NOT NULL,
    used_at         TIMESTAMPTZ,                -- for audit trail
    used_by         UUID REFERENCES users(id),  -- for audit trail
    max_uses        INT NOT NULL DEFAULT 1,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

### **Core API Endpoints**

| Method | Endpoint | Auth | Purpose |
|--------|----------|------|---------|
| `POST` | `/api/v1/auth/register/head-doctor` | Public | Initial clinic setup. |
| `POST` | `/api/v1/auth/register/staff` | Public* | Staff joining via token. |
| `POST` | `/api/v1/invites/generate` | Required | HD/Doctor creates an invite. |
| `GET` | `/api/v1/invites/validate/{token}` | Public | Pre-registration link check. |
| `GET` | `/api/v1/users/me` | Required | Identity/Status check on login. |
| `PATCH` | `/users/{id}/approve` | Required | Role-based approval. |
