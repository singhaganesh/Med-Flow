package com.mediflow.config;

import io.jsonwebtoken.Claims;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Collections;
import java.util.UUID;

@Getter
public class UserPrincipal implements UserDetails {

    private final UUID id;
    private final UUID orgId;
    private final String role;
    private final String email;

    public UserPrincipal(UUID id, UUID orgId, String role, String email) {
        this.id = id;
        this.orgId = orgId;
        this.role = role;
        this.email = email;
    }

    public static UserPrincipal fromClaims(Claims claims) {
        return new UserPrincipal(
                UUID.fromString(claims.getSubject()),
                UUID.fromString(claims.get("org_id", String.class)),
                claims.get("role", String.class),
                claims.get("email", String.class)
        );
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + role));
    }

    @Override
    public String getPassword() {
        return null;
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
