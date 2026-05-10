package com.mediflow.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "invitation_tokens")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class InvitationToken {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false, unique = true)
    private String token;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "org_id", nullable = false)
    private Organization organization;

    @Column(nullable = false)
    private String role;

    @Column(name = "generated_by", nullable = false)
    private UUID generatedBy;

    @Column(name = "assigned_doctor_id")
    private UUID assignedDoctorId;

    @Column(name = "expires_at", nullable = false)
    private OffsetDateTime expiresAt;

    @Column(name = "used_at")
    private OffsetDateTime usedAt;

    @Column(name = "used_by")
    private UUID usedBy;

    @Builder.Default
    @Column(name = "max_uses", nullable = false)
    private Integer maxUses = 1;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    public boolean isExpired() {
        return OffsetDateTime.now().isAfter(expiresAt);
    }

    public boolean isFullyUsed() {
        // For single-use, we can just check usedAt. 
        // For multi-use, we'd count occurrences in the user table, but for now we'll handle simple logic.
        return usedAt != null && maxUses == 1;
    }
}
