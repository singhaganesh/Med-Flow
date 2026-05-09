CREATE TABLE follow_up_tasks (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    org_id          UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    patient_id      UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
    assigned_by     UUID NOT NULL REFERENCES users(id),
    assigned_to     UUID NOT NULL REFERENCES users(id),
    title           TEXT NOT NULL,
    description     TEXT,
    priority        TEXT NOT NULL DEFAULT 'medium',
    status          TEXT NOT NULL DEFAULT 'pending',
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
