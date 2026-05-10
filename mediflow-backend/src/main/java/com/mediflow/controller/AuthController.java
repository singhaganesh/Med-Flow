package com.mediflow.controller;

import com.mediflow.dto.request.RegisterRequest;
import com.mediflow.dto.response.UserResponse;
import com.mediflow.service.AuthService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/register/head-doctor")
    public ResponseEntity<UserResponse> registerHeadDoctor(@Valid @RequestBody RegisterRequest request) {
        return ResponseEntity.ok(authService.registerHeadDoctor(request));
    }

    @PostMapping("/register/staff")
    public ResponseEntity<UserResponse> registerStaff(@Valid @RequestBody RegisterStaffRequest request) {
        return ResponseEntity.ok(authService.registerStaff(request));
    }
}
