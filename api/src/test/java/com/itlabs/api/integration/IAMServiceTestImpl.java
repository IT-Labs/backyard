package com.itlabs.api.integration;

import com.itlabs.api.iam.IAMService;
import java.util.Map;
import java.util.UUID;
import org.keycloak.adapters.springsecurity.token.KeycloakAuthenticationToken;
import org.keycloak.representations.AccessToken;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Profile;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
@Profile("test")
@Primary
public class IAMServiceTestImpl implements IAMService {

	public String getIAMUserId() {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication authentication = context.getAuthentication();
		if (authentication == null) {
			return "123ab7e1-4e26-4fc7-8c7a-cb1105d04813";// default user when loading
															// test data in db
		}
		final AccessToken token = ((KeycloakAuthenticationToken) authentication).getAccount()
				.getKeycloakSecurityContext().getToken();
		final Map<String, Object> otherClaims = token.getOtherClaims();
		var userId = otherClaims.containsKey("user_id") ? otherClaims.get("user_id").toString() : token.getSubject();
		return userId;
	}

	public UUID getIAMUserIdUUID() {
		return UUID.fromString(getIAMUserId());
	}

}
