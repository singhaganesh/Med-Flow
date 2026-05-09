package com.mediflow.service;

import com.mediflow.dto.request.RegisterRequest;
import com.mediflow.dto.response.UserResponse;
import com.mediflow.entity.Organization;
import com.mediflow.entity.User;
import com.mediflow.repository.OrganizationRepository;
import com.mediflow.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
public class AuthService {

    private final OrganizationRepository organizationRepository;
    private final UserRepository userRepository;

    public AuthService(OrganizationRepository organizationRepository, UserRepository userRepository) {
        this.organizationRepository = organizationRepository;
        this.userRepository = userRepository;
    }

    @Transactional
    public UserResponse register(RegisterRequest request) {
        // 1. Create Organization
        Organization organization = Organization.builder()
                .name(request.getClinicName())
                .slug(request.getClinicName().toLowerCase().replaceAll("\\s+", "-"))
                .email(request.getEmail())
                .phone(request.getPhone())
                .specialty(request.getSpecialty())
                .plan("starter")
                .subscriptionStatus("active")
                .build();

        organization = organizationRepository.save(organization);

        // 2. Create User (Head Doctor)
        // Note: In a real flow, we would call Supabase Auth here to create the user and get the ID.
        // For now, we simulate with a random UUID if not provided by the auth provider.
        User user = User.builder()
                .id(UUID.randomUUID()) // This should come from Supabase Auth
                .organization(organization)
                .role("HEAD_DOCTOR")
                .status("active") // Head doctor is active by default
                .fullName(request.getFullName())
                .email(request.getEmail())
                .phone(request.getPhone())
                .build();

        user = userRepository.save(user);

        return UserResponse.builder()
                .id(user.getId())
                .orgId(organization.getId())
                .orgName(organization.getName())
                .fullName(user.getFullName())
                .email(user.getEmail())
                .role(user.getRole())
                .status(user.getStatus())
                .build();
    }
}
