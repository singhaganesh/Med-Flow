CREATE TABLE patients (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    org_id          UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    uploaded_by     UUID NOT NULL REFERENCES users(id),
    full_name       TEXT NOT NULL,
    date_of_birth   DATE,
    gender          TEXT,
    phone           TEXT,
    address         TEXT,
    blood_group     TEXT,
    known_allergies TEXT,
    chief_complaint TEXT,
    is_finalized    BOOLEAN NOT NULL DEFAULT FALSE,
    finalized_by    UUID REFERENCES users(id),
    finalized_at    TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_patients_org_id ON patients(org_id);
CREATE INDEX idx_patients_uploaded_by ON patients(uploaded_by);
CREATE INDEX idx_patients_full_name ON patients USING GIN (to_tsvector('english', full_name));
