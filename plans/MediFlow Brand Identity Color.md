# MediFlow Brand Identity & Style Guide

This document defines the visual standards for the MediFlow SaaS platform to ensure a consistent experience across the mobile app, web dashboard, and marketing materials.

## 1. Core Color Palette

| Usage | Color Name | Hex Code | Visual Intent |
| :--- | :--- | :--- | :--- |
| **Primary** | **MediBlue** | `#0077B6` | Trust, authority, and core branding. Used for buttons, primary headers, and active states. |
| **Secondary** | **HealthTeal** | `#06B6D4` | Freshness and innovation. Used for highlights, active icons, and progress indicators. |
| **Background** | **CleanSlate** | `#F8FAFC` | Professionalism and cleanliness. Used for app backgrounds to reduce eye strain. |
| **Text (Main)** | **DeepCharcoal** | `#1E293B` | High readability. Used for clinical notes, patient names, and body text. |
| **Accent/Action** | **VitalOrange** | `#FB923C` | High visibility. Used for notifications, urgent task alerts, and important CTA variants. |

---

## 2. Semantic Colors (Functional)

These colors are mapped to specific application logic and states to provide immediate visual feedback to users.

*   **Success:** `#10B981` (Task completed, Account approved, Data saved)
*   **Error:** `#EF4444` (Overdue tasks, Critical allergies, System errors)
*   **Warning:** `#F59E0B` (Pending approvals, Incomplete patient profiles)
*   **Info:** `#3B82F6` (General tips, system updates)

---

## 3. Typography Strategy

*   **Font Choice:** Inter or Roboto (Modern, highly legible on mobile and web).
*   **Scale:**
    *   **H1 (Headers):** Bold, DeepCharcoal.
    *   **Body:** Medium, DeepCharcoal (80% opacity for secondary info).
    *   **Captions:** Small, SlateGrey.

---

## 4. Platform Implementation

### Flutter (Mobile)
Defined in `lib/core/theme.dart`:
```dart
const Color kPrimaryColor = Color(0xFF0077B6);
const Color kSecondaryColor = Color(0xFF06B6D4);
const Color kBackgroundColor = Color(0xFFF8FAFC);
```

### Next.js (Web)
Defined in `tailwind.config.js`:
```javascript
theme: {
  extend: {
    colors: {
      mediblue: '#0077B6',
      healthteal: '#06B6D4',
      cleanslate: '#F8FAFC',
    }
  }
}
```
