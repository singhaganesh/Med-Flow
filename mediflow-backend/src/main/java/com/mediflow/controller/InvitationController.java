package com.mediflow.controller;

import com.mediflow.dto.response.InviteValidationResponse;
import com.mediflow.entity.InvitationToken;
import com.mediflow.service.InvitationService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/invites")
public class InvitationController {

    private final InvitationService invitationService;

    public InvitationController(InvitationService invitationService) {
        this.invitationService = invitationService;
    }

    @PostMapping("/generate")
    public ResponseEntity<Map<String, String>> generate(@RequestBody Map<String, String> request) {
        String role = request.get("role");
        String doctorIdStr = request.get("assignedDoctorId");
        UUID doctorId = (doctorIdStr != null) ? UUID.fromString(doctorIdStr) : null;
        
        String token = invitationService.generateInvite(role, doctorId);
        return ResponseEntity.ok(Map.of("token", token));
    }

    @GetMapping("/validate/{token}")
    public ResponseEntity<InviteValidationResponse> validate(@PathVariable String token) {
        InvitationToken invitation = invitationService.validateToken(token);
        
        return ResponseEntity.ok(InviteValidationResponse.builder()
                .clinicName(invitation.getOrganization().getName())
                .role(invitation.getRole())
                .orgId(invitation.getOrganization().getId())
                .assignedDoctorId(invitation.getAssignedDoctorId())
                .build());
    }
}
