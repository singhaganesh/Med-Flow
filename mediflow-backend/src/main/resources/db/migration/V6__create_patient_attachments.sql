CREATE TABLE patient_attachments (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    org_id          UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    patient_id      UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
    medical_record_id UUID REFERENCES medical_records(id),
    uploaded_by     UUID NOT NULL REFERENCES users(id),
    file_name       TEXT NOT NULL,
    file_type       TEXT NOT NULL,
    file_size_bytes BIGINT,
    storage_path    TEXT NOT NULL,
    public_url      TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_attachments_patient_id ON patient_attachments(patient_id);
