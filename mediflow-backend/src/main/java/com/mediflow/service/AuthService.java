package com.mediflow.service;

import com.mediflow.config.JwtService;
import com.mediflow.dto.request.LoginRequest;
import com.mediflow.dto.request.RegisterRequest;
import com.mediflow.dto.request.RegisterStaffRequest;
import com.mediflow.dto.response.LoginResponse;
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
import java.util.Map;
import java.util.UUID;

@Service
public class AuthService {

    private final OrganizationRepository organizationRepository;
    private final UserRepository userRepository;
    private final InvitationService invitationService;
    private final InvitationTokenRepository tokenRepository;
    private final JwtService jwtService;

    public AuthService(OrganizationRepository organizationRepository, 
                       UserRepository userRepository, 
                       InvitationService invitationService,
                       InvitationTokenRepository tokenRepository,
                       JwtService jwtService) {
        this.organizationRepository = organizationRepository;
        this.userRepository = userRepository;
        this.invitationService = invitationService;
        this.tokenRepository = tokenRepository;
        this.jwtService = jwtService;
    }

    @Transactional(readOnly = true)
    public LoginResponse login(LoginRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new RuntimeException("Invalid credentials"));

        String token = jwtService.generateToken(user.getId().toString(), Map.of(
                "org_id", user.getOrganization().getId().toString(),
                "role", user.getRole(),
                "email", user.getEmail()
        ));

        return LoginResponse.builder()
                .token(token)
                .user(mapToResponse(user))
                .build();
    }

    @Transactional
    public UserResponse registerHeadDoctor(RegisterRequest request) {
        Organization organization = Organization.builder()
                .name(request.getClinicName())
                .slug(request.getClinicName().toLowerCase().replaceAll("\\s+", "-") + "-" + UUID.randomUUID().toString().substring(0, 4))
                .email(request.getEmail())
                .phone(request.getPhone())
                .specialty(request.getSpecialty())
                .build();

        organization = organizationRepository.save(organization);

        User user = User.builder()
                .id(UUID.randomUUID())
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
        InvitationToken invitation = invitationService.validateToken(request.getInviteToken());

        User user = User.builder()
                .id(UUID.randomUUID())
                .organization(invitation.getOrganization())
                .role(invitation.getRole())
                .status("pending")
                .fullName(request.getFullName())
                .email(request.getEmail())
                .assignedDoctorId(invitation.getAssignedDoctorId())
                .build();

        user = userRepository.save(user);

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
