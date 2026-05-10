-- Add hierarchy support to users
ALTER TABLE users ADD COLUMN assigned_doctor_id UUID REFERENCES users(id);

-- Create secure invitation tokens table
CREATE TABLE invitation_tokens (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    token           TEXT UNIQUE NOT NULL,
    org_id          UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    role            TEXT NOT NULL,              -- DOCTOR | AGENT
    generated_by    UUID NOT NULL REFERENCES users(id),
    assigned_doctor_id UUID REFERENCES users(id), -- only set for AGENT invites
    expires_at      TIMESTAMPTZ NOT NULL,
    used_at         TIMESTAMPTZ,                -- for audit trail
    used_by         UUID REFERENCES users(id),  -- for audit trail
    max_uses        INT NOT NULL DEFAULT 1,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_invites_token ON invitation_tokens(token);
CREATE INDEX idx_invites_org_id ON invitation_tokens(org_id);
