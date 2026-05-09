CREATE TABLE organizations (
    id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                  TEXT NOT NULL,
    slug                  TEXT UNIQUE NOT NULL,
    email                 TEXT NOT NULL,
    phone                 TEXT,
    address               TEXT,
    specialty             TEXT,
    stripe_customer_id    TEXT,
    stripe_subscription_id TEXT,
    plan                  TEXT NOT NULL DEFAULT 'starter',
    plan_config           JSONB,
    subscription_status   TEXT NOT NULL DEFAULT 'active',
    trial_ends_at         TIMESTAMPTZ,
    created_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE users (
    id              UUID PRIMARY KEY,
    org_id          UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    role            TEXT NOT NULL,
    status          TEXT NOT NULL DEFAULT 'pending',
    full_name       TEXT NOT NULL,
    email           TEXT NOT NULL,
    phone           TEXT,
    avatar_url      TEXT,
    fcm_token       TEXT,
    last_active_at  TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_users_org_id ON users(org_id);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_status ON users(status);
