CREATE TABLE medical_records (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    org_id          UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    patient_id      UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
    author_id       UUID NOT NULL REFERENCES users(id),
    record_type     TEXT NOT NULL,
    title           TEXT,
    content         TEXT,
    file_url        TEXT,
    file_name       TEXT,
    file_size_bytes BIGINT,
    ai_summary      TEXT,
    is_ai_summary   BOOLEAN NOT NULL DEFAULT FALSE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_medical_records_patient_id ON medical_records(patient_id);
CREATE INDEX idx_medical_records_org_id ON medical_records(org_id);
CREATE INDEX idx_medical_records_author_id ON medical_records(author_id);
