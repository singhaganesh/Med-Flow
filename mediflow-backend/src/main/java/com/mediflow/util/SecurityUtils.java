package com.mediflow.util;

import com.mediflow.config.UserPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
public class SecurityUtils {

    public static UUID getCurrentUserId() {
        return getUserPrincipal().getId();
    }

    public static UUID getCurrentOrgId() {
        return getUserPrincipal().getOrgId();
    }

    public static String getCurrentUserRole() {
        return getUserPrincipal().getRole();
    }

    private static UserPrincipal getUserPrincipal() {
        return (UserPrincipal) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    }
}
