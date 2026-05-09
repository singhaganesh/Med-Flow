package com.mediflow.dto.response;

import lombok.Builder;
import lombok.Data;

import java.util.UUID;

@Data
@Builder
public class UserResponse {
    private UUID id;
    private UUID orgId;
    private String orgName;
    private String fullName;
    private String email;
    private String role;
    private String status;
}
