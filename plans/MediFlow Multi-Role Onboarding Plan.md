# MediFlow Multi-Role Onboarding Plan

This document formalizes the refined strategy for user registration and role-locked invitations, ensuring high security and a friction-free user experience.

---

## 1. User Journey: The Role Selector
Instead of a single registration form, users will land on a **Role Selection Screen** after tapping "Register" on the Login page.

### **Entry Screen Options:**
1.  **"Register Your Clinic"** (For Head Doctors/Owners)
    *   Leads to a full clinic creation form.
    *   No invite token required.
2.  **"Join as a Doctor"** (For invited medical staff)
    *   Leads to a staff registration form.
    *   **Requires** a token generated for the `DOCTOR` role.
3.  **"Join as an Agent"** (For field/front-desk staff)
    *   Leads to a staff registration form.
    *   **Requires** a token generated for the `AGENT` role.

---

## 2. Secure Invitation System (Refined)

### **Token Lifecycle & Security:**
*   **Reduced Expiry:** Tokens will now expire in **12 hours** (down from 48h) to minimize the window of risk if a link is shared in insecure channels like WhatsApp groups.
*   **Single-Use Enforcement:** Once a registration is successful, the token is immediately marked as `used_at` and cannot be used for any subsequent registrations.
*   **Role Locking:** 
    *   Tokens are tagged with a specific role (`DOCTOR` or `AGENT`).
    *   The backend will **reject** any registration where the user's chosen role does not match the token's encoded role.

### **Token Validation UX:**
*   As the user types or pastes the token, the app will call `GET /api/v1/invites/validate/{token}`.
*   **Success state:** Shows a "Clinic Preview Card" confirming the Clinic Name and the inviter.
*   **Failure state:** Shows clear errors: "Token Expired", "Token Already Used", or "Role Mismatch".

---

## 3. Implementation Checklist

### **Phase 1: Backend Updates**
- [ ] Update `InvitationService` to set `expiresAt` to `now + 12 hours`.
- [ ] Refine `AuthService.registerStaff` to perform a strict `invitation.role == requestedRole` check.
- [ ] Add logic to prevent reuse of tokens even if `max_uses > 1` was previously allowed (strictly 1 use for this flow).

### **Phase 2: Mobile UI Refinement**
- [ ] **Create `RoleSelectorScreen`:** Three bold cards for Owner, Doctor, and Agent.
- [ ] **Enhance `RegisterScreen`:**
    - Add a "Verification Card" that appears when a token is valid.
    - Add real-time token validation as the user types.
- [ ] **Update Navigation:** Link the Login screen to the Role Selector.

### **Phase 3: Deep Linking (Future)**
- [ ] Configure Android Intent Filters to automatically route `https://app.mediflow.in/join?token=XYZ` directly to the `RegisterScreen` with the token pre-filled.

---

## 4. Expected Behavior Table

| Action | Token Role | Chosen Role | Result |
| :--- | :--- | :--- | :--- |
| Register Clinic | N/A | HEAD_DOCTOR | **Success** (New Org Created) |
| Use Doctor Link | DOCTOR | DOCTOR | **Success** (Pending Approval) |
| Use Doctor Link | DOCTOR | AGENT | **Blocked** (Role Mismatch Error) |
| Use Agent Link | AGENT | AGENT | **Success** (Pending Approval) |
| Reuse Token | Any | Any | **Blocked** (Already Used Error) |
