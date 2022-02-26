package com.itlabs.api.iam;

import java.util.Map;
import java.util.UUID;
import org.keycloak.adapters.springsecurity.token.KeycloakAuthenticationToken;
import org.keycloak.representations.AccessToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class IAMServiceImpl implements IAMService {

  public String getIAMUserId() {
    SecurityContext context = SecurityContextHolder.getContext();
    Authentication authentication = context.getAuthentication();

    final AccessToken token =
        ((KeycloakAuthenticationToken) authentication)
            .getAccount()
            .getKeycloakSecurityContext()
            .getToken();
    final Map<String, Object> otherClaims = token.getOtherClaims();
    var userId =
        otherClaims.containsKey("user_id")
            ? otherClaims.get("user_id").toString()
            : token.getSubject();
    return userId;
  }

  public UUID getIAMUserIdUUID() {
    return UUID.fromString(getIAMUserId());
  }
}
