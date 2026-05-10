package com.mediflow.service;

import com.mediflow.dto.request.RegisterRequest;
import com.mediflow.dto.request.RegisterStaffRequest;
import com.mediflow.dto.response.UserResponse;
import com.mediflow.entity.InvitationToken;
import com.mediflow.entity.Organization;
import com.mediflow.entity.User;
import com.mediflow.repository.InvitationTokenRepository;
import com.mediflow.repository.OrganizationRepository;
import com.mediflow.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.OffsetDateTime;
import java.util.UUID;

@Service
public class AuthService {

    private final OrganizationRepository organizationRepository;
    private final UserRepository userRepository;
    private final InvitationService invitationService;
    private final InvitationTokenRepository tokenRepository;

    public AuthService(OrganizationRepository organizationRepository, 
                       UserRepository userRepository, 
                       InvitationService invitationService,
                       InvitationTokenRepository tokenRepository) {
        this.organizationRepository = organizationRepository;
        this.userRepository = userRepository;
        this.invitationService = invitationService;
        this.tokenRepository = tokenRepository;
    }

    @Transactional
    public UserResponse registerHeadDoctor(RegisterRequest request) {
        // 1. Create Organization
        Organization organization = Organization.builder()
                .name(request.getClinicName())
                .slug(request.getClinicName().toLowerCase().replaceAll("\\s+", "-") + "-" + UUID.randomUUID().toString().substring(0, 4))
                .email(request.getEmail())
                .phone(request.getPhone())
                .specialty(request.getSpecialty())
                .plan("starter")
                .subscriptionStatus("active")
                .build();

        organization = organizationRepository.save(organization);

        // 2. Create User (Head Doctor)
        User user = User.builder()
                .id(UUID.randomUUID()) // Simulation: In real app, this is the Supabase UID
                .organization(organization)
                .role("HEAD_DOCTOR")
                .status("active")
                .fullName(request.getFullName())
                .email(request.getEmail())
                .phone(request.getPhone())
                .build();

        user = userRepository.save(user);

        return mapToResponse(user);
    }

    @Transactional
    public UserResponse registerStaff(RegisterStaffRequest request) {
        // 1. Validate Token
        InvitationToken invitation = invitationService.validateToken(request.getInviteToken());

        // 2. Create User
        User user = User.builder()
                .id(UUID.randomUUID()) // Simulation
                .organization(invitation.getOrganization())
                .role(invitation.getRole())
                .status("pending") // Staff always starts as pending
                .fullName(request.getFullName())
                .email(request.getEmail())
                .assignedDoctorId(invitation.getAssignedDoctorId())
                .build();

        user = userRepository.save(user);

        // 3. Mark Token as Used
        invitation.setUsedAt(OffsetDateTime.now());
        invitation.setUsedBy(user.getId());
        tokenRepository.save(invitation);

        return mapToResponse(user);
    }

    private UserResponse mapToResponse(User user) {
        return UserResponse.builder()
                .id(user.getId())
                .orgId(user.getOrganization().getId())
                .orgName(user.getOrganization().getName())
                .fullName(user.getFullName())
                .email(user.getEmail())
                .role(user.getRole())
                .status(user.getStatus())
                .build();
    }
}
