package com.mediflow.service;

import com.mediflow.entity.InvitationToken;
import com.mediflow.entity.Organization;
import com.mediflow.repository.InvitationTokenRepository;
import com.mediflow.repository.OrganizationRepository;
import com.mediflow.util.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.time.OffsetDateTime;
import java.util.Base64;
import java.util.UUID;

@Service
public class InvitationService {

    private final InvitationTokenRepository tokenRepository;
    private final OrganizationRepository organizationRepository;
    private final SecureRandom secureRandom = new SecureRandom();

    public InvitationService(InvitationTokenRepository tokenRepository, OrganizationRepository organizationRepository) {
        this.tokenRepository = tokenRepository;
        this.organizationRepository = organizationRepository;
    }

    @Transactional
    public String generateInvite(String role, UUID assignedDoctorId) {
        UUID orgId = SecurityUtils.getCurrentOrgId();
        UUID generatedBy = SecurityUtils.getCurrentUserId();

        Organization organization = organizationRepository.findById(orgId)
                .orElseThrow(() -> new RuntimeException("Organization not found"));

        String tokenString = generateRandomToken();
        
        InvitationToken invitationToken = InvitationToken.builder()
                .token(tokenString)
                .organization(organization)
                .role(role)
                .generatedBy(generatedBy)
                .assignedDoctorId(assignedDoctorId)
                .expiresAt(OffsetDateTime.now().plusHours(48))
                .maxUses(1)
                .build();

        tokenRepository.save(invitationToken);
        return tokenString;
    }

    public InvitationToken validateToken(String token) {
        InvitationToken invitation = tokenRepository.findByToken(token)
                .orElseThrow(() -> new RuntimeException("Invalid invitation link"));

        if (invitation.isExpired()) {
            throw new RuntimeException("Invitation link has expired");
        }

        if (invitation.isFullyUsed()) {
            throw new RuntimeException("Invitation link has already been used");
        }

        return invitation;
    }

    private String generateRandomToken() {
        byte[] randomBytes = new byte[24];
        secureRandom.nextBytes(randomBytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes);
    }
}
