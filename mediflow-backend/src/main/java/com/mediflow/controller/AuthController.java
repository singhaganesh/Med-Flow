package com.mediflow.controller;

import com.mediflow.dto.request.LoginRequest;
import com.mediflow.dto.request.RegisterRequest;
import com.mediflow.dto.request.RegisterStaffRequest;
import com.mediflow.dto.response.ApiResponse;
import com.mediflow.dto.response.LoginResponse;
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
    public ResponseEntity<ApiResponse<UserResponse>> registerHeadDoctor(@Valid @RequestBody RegisterRequest request) {
        return ResponseEntity.ok(ApiResponse.success("Clinic registered successfully", authService.registerHeadDoctor(request)));
    }

    @PostMapping("/register/staff")
    public ResponseEntity<ApiResponse<UserResponse>> registerStaff(@Valid @RequestBody RegisterStaffRequest request) {
        return ResponseEntity.ok(ApiResponse.success("Staff registered successfully", authService.registerStaff(request)));
    }

    @PostMapping("/login")
    public ResponseEntity<ApiResponse<LoginResponse>> login(@Valid @RequestBody LoginRequest request) {
        return ResponseEntity.ok(ApiResponse.success("Login successful", authService.login(request)));
    }
}
