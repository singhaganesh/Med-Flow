package com.mediflow.dto.response;

import lombok.Builder;
import lombok.Data;

import java.util.UUID;

@Data
@Builder
public class InviteValidationResponse {
    private String clinicName;
    private String role;
    private UUID orgId;
    private UUID assignedDoctorId;
}
