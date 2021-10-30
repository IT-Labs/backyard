--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 14.0

-- Started on 2021-10-30 08:46:00

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 81953)
-- Name: keycloak; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA keycloak;


--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 3907 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 249 (class 1259 OID 82613)
-- Name: admin_event_entity; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


--
-- TOC entry 278 (class 1259 OID 83076)
-- Name: associated_policy; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


--
-- TOC entry 252 (class 1259 OID 82631)
-- Name: authentication_execution; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


--
-- TOC entry 251 (class 1259 OID 82625)
-- Name: authentication_flow; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


--
-- TOC entry 250 (class 1259 OID 82619)
-- Name: authenticator_config; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


--
-- TOC entry 253 (class 1259 OID 82636)
-- Name: authenticator_config_entry; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 279 (class 1259 OID 83091)
-- Name: broker_link; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


--
-- TOC entry 209 (class 1259 OID 81968)
-- Name: client; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


--
-- TOC entry 233 (class 1259 OID 82342)
-- Name: client_attributes; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


--
-- TOC entry 290 (class 1259 OID 83350)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


--
-- TOC entry 208 (class 1259 OID 81965)
-- Name: client_default_roles; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- TOC entry 289 (class 1259 OID 83225)
-- Name: client_initial_access; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


--
-- TOC entry 235 (class 1259 OID 82354)
-- Name: client_node_registrations; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


--
-- TOC entry 267 (class 1259 OID 82874)
-- Name: client_scope; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


--
-- TOC entry 268 (class 1259 OID 82889)
-- Name: client_scope_attributes; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


--
-- TOC entry 291 (class 1259 OID 83392)
-- Name: client_scope_client; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_scope_client (
    client_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- TOC entry 269 (class 1259 OID 82895)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- TOC entry 210 (class 1259 OID 81980)
-- Name: client_session; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


--
-- TOC entry 256 (class 1259 OID 82657)
-- Name: client_session_auth_status; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 234 (class 1259 OID 82348)
-- Name: client_session_note; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 248 (class 1259 OID 82535)
-- Name: client_session_prot_mapper; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 81986)
-- Name: client_session_role; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 257 (class 1259 OID 82738)
-- Name: client_user_session_note; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 287 (class 1259 OID 83141)
-- Name: component; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


--
-- TOC entry 286 (class 1259 OID 83135)
-- Name: component_config; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


--
-- TOC entry 212 (class 1259 OID 81989)
-- Name: composite_role; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


--
-- TOC entry 213 (class 1259 OID 81992)
-- Name: credential; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- TOC entry 207 (class 1259 OID 81959)
-- Name: databasechangelog; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


--
-- TOC entry 206 (class 1259 OID 81954)
-- Name: databasechangeloglock; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


--
-- TOC entry 292 (class 1259 OID 83408)
-- Name: default_client_scope; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- TOC entry 214 (class 1259 OID 81998)
-- Name: event_entity; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


--
-- TOC entry 280 (class 1259 OID 83097)
-- Name: fed_user_attribute; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


--
-- TOC entry 281 (class 1259 OID 83103)
-- Name: fed_user_consent; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- TOC entry 294 (class 1259 OID 83434)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 282 (class 1259 OID 83112)
-- Name: fed_user_credential; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- TOC entry 283 (class 1259 OID 83122)
-- Name: fed_user_group_membership; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 284 (class 1259 OID 83125)
-- Name: fed_user_required_action; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 285 (class 1259 OID 83132)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 238 (class 1259 OID 82392)
-- Name: federated_identity; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


--
-- TOC entry 288 (class 1259 OID 83201)
-- Name: federated_user; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 264 (class 1259 OID 82811)
-- Name: group_attribute; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 263 (class 1259 OID 82808)
-- Name: group_role_mapping; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 239 (class 1259 OID 82398)
-- Name: identity_provider; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


--
-- TOC entry 240 (class 1259 OID 82408)
-- Name: identity_provider_config; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 245 (class 1259 OID 82514)
-- Name: identity_provider_mapper; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 246 (class 1259 OID 82520)
-- Name: idp_mapper_config; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 262 (class 1259 OID 82805)
-- Name: keycloak_group; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


--
-- TOC entry 215 (class 1259 OID 82007)
-- Name: keycloak_role; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


--
-- TOC entry 244 (class 1259 OID 82511)
-- Name: migration_model; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


--
-- TOC entry 261 (class 1259 OID 82795)
-- Name: offline_client_session; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


--
-- TOC entry 260 (class 1259 OID 82789)
-- Name: offline_user_session; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 274 (class 1259 OID 83018)
-- Name: policy_config; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- TOC entry 236 (class 1259 OID 82379)
-- Name: protocol_mapper; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


--
-- TOC entry 237 (class 1259 OID 82386)
-- Name: protocol_mapper_config; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 82014)
-- Name: realm; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 82032)
-- Name: realm_attribute; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 266 (class 1259 OID 82821)
-- Name: realm_default_groups; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 82038)
-- Name: realm_default_roles; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- TOC entry 243 (class 1259 OID 82503)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 82041)
-- Name: realm_events_listeners; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 299 (class 1259 OID 83548)
-- Name: realm_localizations; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 82044)
-- Name: realm_required_credential; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 82052)
-- Name: realm_smtp_config; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 241 (class 1259 OID 82418)
-- Name: realm_supported_locales; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 82064)
-- Name: redirect_uris; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 259 (class 1259 OID 82752)
-- Name: required_action_config; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 258 (class 1259 OID 82744)
-- Name: required_action_provider; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


--
-- TOC entry 296 (class 1259 OID 83473)
-- Name: resource_attribute; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


--
-- TOC entry 276 (class 1259 OID 83046)
-- Name: resource_policy; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- TOC entry 275 (class 1259 OID 83031)
-- Name: resource_scope; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 270 (class 1259 OID 82965)
-- Name: resource_server; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


--
-- TOC entry 295 (class 1259 OID 83449)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


--
-- TOC entry 273 (class 1259 OID 83003)
-- Name: resource_server_policy; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


--
-- TOC entry 271 (class 1259 OID 82973)
-- Name: resource_server_resource; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


--
-- TOC entry 272 (class 1259 OID 82988)
-- Name: resource_server_scope; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


--
-- TOC entry 297 (class 1259 OID 83492)
-- Name: resource_uris; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 298 (class 1259 OID 83502)
-- Name: role_attribute; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


--
-- TOC entry 223 (class 1259 OID 82067)
-- Name: scope_mapping; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- TOC entry 277 (class 1259 OID 83061)
-- Name: scope_policy; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 82073)
-- Name: user_attribute; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 82526)
-- Name: user_consent; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- TOC entry 293 (class 1259 OID 83424)
-- Name: user_consent_client_scope; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 82079)
-- Name: user_entity; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 82088)
-- Name: user_federation_config; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 254 (class 1259 OID 82642)
-- Name: user_federation_mapper; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 255 (class 1259 OID 82648)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 228 (class 1259 OID 82094)
-- Name: user_federation_provider; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


--
-- TOC entry 265 (class 1259 OID 82818)
-- Name: user_group_membership; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 82100)
-- Name: user_required_action; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 82103)
-- Name: user_role_mapping; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 82106)
-- Name: user_session; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


--
-- TOC entry 242 (class 1259 OID 82421)
-- Name: user_session_note; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


--
-- TOC entry 224 (class 1259 OID 82070)
-- Name: username_login_failure; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


--
-- TOC entry 232 (class 1259 OID 82119)
-- Name: web_origins; Type: TABLE; Schema: keycloak; Owner: -
--

CREATE TABLE keycloak.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 203 (class 1259 OID 16385)
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


--
-- TOC entry 204 (class 1259 OID 24577)
-- Name: item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


--
-- TOC entry 205 (class 1259 OID 24579)
-- Name: items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items (
    id integer DEFAULT nextval('public.item_id_seq'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    status character varying(100) NOT NULL,
    type character varying(100) NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    guid uuid DEFAULT (md5((random())::text))::uuid NOT NULL,
    published timestamp without time zone,
    is_public boolean DEFAULT false NOT NULL,
    created_by uuid NOT NULL,
    updated_by uuid NOT NULL
);


--
-- TOC entry 3851 (class 0 OID 82613)
-- Dependencies: 249
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- TOC entry 3880 (class 0 OID 83076)
-- Dependencies: 278
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- TOC entry 3854 (class 0 OID 82631)
-- Dependencies: 252
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
75b3ab41-e2a8-4751-8a5f-c274acd8fc82	\N	auth-cookie	master	8c6fe9ec-0193-4c98-b5a8-ff35cb3202f6	2	10	f	\N	\N
5410b796-ad4b-40ff-9bf4-0b7cdd548d03	\N	auth-spnego	master	8c6fe9ec-0193-4c98-b5a8-ff35cb3202f6	3	20	f	\N	\N
4decf07f-a0dd-4b21-af6b-0ce4ec17ef62	\N	identity-provider-redirector	master	8c6fe9ec-0193-4c98-b5a8-ff35cb3202f6	2	25	f	\N	\N
e570409f-ed45-41b6-bb78-e9fdd8165033	\N	\N	master	8c6fe9ec-0193-4c98-b5a8-ff35cb3202f6	2	30	t	cd76026d-e73b-44e2-992c-394d18700386	\N
eed57928-b4ec-4c8e-a28f-b01392b01e06	\N	auth-username-password-form	master	cd76026d-e73b-44e2-992c-394d18700386	0	10	f	\N	\N
377768e8-307e-4601-a4ee-21b4685da5af	\N	\N	master	cd76026d-e73b-44e2-992c-394d18700386	1	20	t	ec45156c-8915-4e9a-b4f6-9ce455d7ace6	\N
fa89e14b-5746-4677-9d5d-42e390fb31c1	\N	conditional-user-configured	master	ec45156c-8915-4e9a-b4f6-9ce455d7ace6	0	10	f	\N	\N
97263c46-bb09-4c61-a871-b227a95190ab	\N	auth-otp-form	master	ec45156c-8915-4e9a-b4f6-9ce455d7ace6	0	20	f	\N	\N
a6d91ebd-e9e8-48f9-b674-ef536e701a9a	\N	direct-grant-validate-username	master	b964a601-5f73-4cec-a380-1bcb44dd6dea	0	10	f	\N	\N
ce369045-3480-477e-bc78-c71c9ad86635	\N	direct-grant-validate-password	master	b964a601-5f73-4cec-a380-1bcb44dd6dea	0	20	f	\N	\N
b017e7e5-485d-4905-a9e4-a2e209044eac	\N	\N	master	b964a601-5f73-4cec-a380-1bcb44dd6dea	1	30	t	8fcb130b-f71b-42f8-a395-fa5fc7ed09f1	\N
e0cc5997-af41-46e5-a2aa-1042affcaed3	\N	conditional-user-configured	master	8fcb130b-f71b-42f8-a395-fa5fc7ed09f1	0	10	f	\N	\N
a9f98e09-c2c6-4568-9bab-f48c64342870	\N	direct-grant-validate-otp	master	8fcb130b-f71b-42f8-a395-fa5fc7ed09f1	0	20	f	\N	\N
0f97777a-423e-4fa7-a69e-c21d0512b8a8	\N	registration-page-form	master	831312ce-dd7f-47ec-b97c-b7c8e923b064	0	10	t	e016f647-0d02-4bfb-8c50-a0fc48f233ec	\N
2a1fc202-9e26-4165-ba15-8d7a5bee9b63	\N	registration-user-creation	master	e016f647-0d02-4bfb-8c50-a0fc48f233ec	0	20	f	\N	\N
fd988210-f9a3-4ac5-874d-f420bd7b4138	\N	registration-profile-action	master	e016f647-0d02-4bfb-8c50-a0fc48f233ec	0	40	f	\N	\N
c1541db5-9973-49db-aadf-4d4438de7536	\N	registration-password-action	master	e016f647-0d02-4bfb-8c50-a0fc48f233ec	0	50	f	\N	\N
c286b907-1091-4c30-a260-030188c696f9	\N	registration-recaptcha-action	master	e016f647-0d02-4bfb-8c50-a0fc48f233ec	3	60	f	\N	\N
ea798593-b3d7-4f1b-bf49-b000c3ad3610	\N	reset-credentials-choose-user	master	d3055c2a-2101-4f09-9b92-9c902fe020ed	0	10	f	\N	\N
03240ab1-70a8-4bf5-9c6f-b7c7fde7bc33	\N	reset-credential-email	master	d3055c2a-2101-4f09-9b92-9c902fe020ed	0	20	f	\N	\N
fda7ae5c-3409-447e-a35e-11b6b6a2ffad	\N	reset-password	master	d3055c2a-2101-4f09-9b92-9c902fe020ed	0	30	f	\N	\N
c6717c9a-5db9-45b3-bcf0-4f9f4ce3153c	\N	\N	master	d3055c2a-2101-4f09-9b92-9c902fe020ed	1	40	t	a94f0290-30dd-4f8f-b244-2d2a8fe5ec4f	\N
0abc48f0-2b2d-4b30-8fd8-5848de79f08e	\N	conditional-user-configured	master	a94f0290-30dd-4f8f-b244-2d2a8fe5ec4f	0	10	f	\N	\N
a68e13b5-ab13-49e3-a146-2e405a2425d2	\N	reset-otp	master	a94f0290-30dd-4f8f-b244-2d2a8fe5ec4f	0	20	f	\N	\N
74de2492-777a-4daf-8fb8-6f9277e98753	\N	client-secret	master	c5ba5f78-d833-4ea3-a73c-aafce1fad20a	2	10	f	\N	\N
66ac88ec-7dd4-4276-97bb-76a0ba9f28b2	\N	client-jwt	master	c5ba5f78-d833-4ea3-a73c-aafce1fad20a	2	20	f	\N	\N
79d4e309-9862-4497-ab9d-82bbc174edcc	\N	client-secret-jwt	master	c5ba5f78-d833-4ea3-a73c-aafce1fad20a	2	30	f	\N	\N
cfea8bd6-6da2-426e-9a52-115b910952f3	\N	client-x509	master	c5ba5f78-d833-4ea3-a73c-aafce1fad20a	2	40	f	\N	\N
9ef812e5-632c-4a7c-893f-a7dd859249ee	\N	idp-review-profile	master	ba85f090-6135-4a31-a506-4f1c5fb3f7cb	0	10	f	\N	83b8fed1-76d0-48d0-b1f4-88fd4a2830c1
8d6bdb8d-f74b-43eb-b555-5ce75ef79fdc	\N	\N	master	ba85f090-6135-4a31-a506-4f1c5fb3f7cb	0	20	t	f3b61463-6d5c-480e-a231-fd509e84d07d	\N
01300b1f-b6fb-4418-8e33-38d91b7b8564	\N	idp-create-user-if-unique	master	f3b61463-6d5c-480e-a231-fd509e84d07d	2	10	f	\N	fe7fd354-ea16-471c-8a64-e40c86d4f08a
4813a1ae-3831-43fd-8490-ed6fdce88a59	\N	\N	master	f3b61463-6d5c-480e-a231-fd509e84d07d	2	20	t	d424f561-5944-4c65-a53f-16e44e5af284	\N
54a47301-ecbb-4a3a-b648-62055e3c5874	\N	idp-confirm-link	master	d424f561-5944-4c65-a53f-16e44e5af284	0	10	f	\N	\N
34192362-a121-4b2d-bfd9-e6a66d011297	\N	\N	master	d424f561-5944-4c65-a53f-16e44e5af284	0	20	t	1e975246-16e2-4358-98a0-22afb382848a	\N
27017fcf-1a25-43fb-ba10-c589ff91959a	\N	idp-email-verification	master	1e975246-16e2-4358-98a0-22afb382848a	2	10	f	\N	\N
1b2deb6a-c295-41d2-b9da-470f2b10b288	\N	\N	master	1e975246-16e2-4358-98a0-22afb382848a	2	20	t	7aa46816-c365-49b5-add1-c22dcc0ce429	\N
4968606a-81d6-4493-8ed0-92b0f49db0ee	\N	idp-username-password-form	master	7aa46816-c365-49b5-add1-c22dcc0ce429	0	10	f	\N	\N
71d385f0-c3a7-4462-be58-8b6758cce65d	\N	\N	master	7aa46816-c365-49b5-add1-c22dcc0ce429	1	20	t	2d518418-8256-47c1-8004-ed370faf85d5	\N
eba21232-6956-4700-9b32-ca56b900417f	\N	conditional-user-configured	master	2d518418-8256-47c1-8004-ed370faf85d5	0	10	f	\N	\N
4de4ea3a-133e-4654-a42d-02c41b3e1d86	\N	auth-otp-form	master	2d518418-8256-47c1-8004-ed370faf85d5	0	20	f	\N	\N
3285cc5f-e6d6-4c21-b5c0-de45da8bbe34	\N	http-basic-authenticator	master	c1f2965b-edac-4745-81b1-543fb41fbf34	0	10	f	\N	\N
7bef78d7-be41-44b9-9dcf-0b43a4ab0503	\N	docker-http-basic-authenticator	master	d5755433-fab6-4a53-95fa-1ea4fcc183b8	0	10	f	\N	\N
32c44e6c-b65b-4b6f-907e-bab66f5fe27a	\N	no-cookie-redirect	master	c41777bf-dc8d-4f3f-913c-1f1556ec549e	0	10	f	\N	\N
be95545c-b346-4e3d-888f-99e4538ebbdf	\N	\N	master	c41777bf-dc8d-4f3f-913c-1f1556ec549e	0	20	t	8b19c6da-7b0c-43c2-8663-80da20a2798f	\N
052e1ffd-8f58-4554-8a43-e14927360f82	\N	basic-auth	master	8b19c6da-7b0c-43c2-8663-80da20a2798f	0	10	f	\N	\N
8606aa17-3f42-45c7-8913-0e6b1a2a8b1d	\N	basic-auth-otp	master	8b19c6da-7b0c-43c2-8663-80da20a2798f	3	20	f	\N	\N
1f3be3e1-904d-4b83-9333-d4ea63d511b8	\N	auth-spnego	master	8b19c6da-7b0c-43c2-8663-80da20a2798f	3	30	f	\N	\N
3652063e-4717-471d-a7c7-7a91f0e4f4d6	\N	auth-cookie	cd0a239f-f540-49da-a4c3-8f57fd497cb4	eaee8493-aa3f-4c76-a52c-85d840127909	2	10	f	\N	\N
30ddcd07-45d0-4314-a309-4217b36fa94d	\N	auth-spnego	cd0a239f-f540-49da-a4c3-8f57fd497cb4	eaee8493-aa3f-4c76-a52c-85d840127909	3	20	f	\N	\N
45d519fa-45af-41c1-870d-9ee5819b2fd2	\N	identity-provider-redirector	cd0a239f-f540-49da-a4c3-8f57fd497cb4	eaee8493-aa3f-4c76-a52c-85d840127909	2	25	f	\N	\N
24810bd1-7e0c-4e40-88e1-dce94ddd5f84	\N	\N	cd0a239f-f540-49da-a4c3-8f57fd497cb4	eaee8493-aa3f-4c76-a52c-85d840127909	2	30	t	46db6eb7-54b2-412d-817b-006e8cd13257	\N
d75a0e38-2ff8-4381-8cb0-657ec24db6f6	\N	auth-username-password-form	cd0a239f-f540-49da-a4c3-8f57fd497cb4	46db6eb7-54b2-412d-817b-006e8cd13257	0	10	f	\N	\N
5e9f308d-6d42-4f87-8bf5-02a36e12693d	\N	\N	cd0a239f-f540-49da-a4c3-8f57fd497cb4	46db6eb7-54b2-412d-817b-006e8cd13257	1	20	t	5895fa69-2fcd-4491-a91a-9c4c69bab39d	\N
f6b647c3-7d75-4e41-a0f4-c8e8a47a6d25	\N	conditional-user-configured	cd0a239f-f540-49da-a4c3-8f57fd497cb4	5895fa69-2fcd-4491-a91a-9c4c69bab39d	0	10	f	\N	\N
b4af88a9-f626-46c0-87a5-3cc86ad6b4c3	\N	auth-otp-form	cd0a239f-f540-49da-a4c3-8f57fd497cb4	5895fa69-2fcd-4491-a91a-9c4c69bab39d	0	20	f	\N	\N
5b24805f-0cbc-4b28-95d6-22896149d8ec	\N	direct-grant-validate-username	cd0a239f-f540-49da-a4c3-8f57fd497cb4	d9ae1ba0-727d-4e38-85ad-5c5efee6bf16	0	10	f	\N	\N
e34ec771-f6f3-4d5c-b2ef-43bbbe8cafe7	\N	direct-grant-validate-password	cd0a239f-f540-49da-a4c3-8f57fd497cb4	d9ae1ba0-727d-4e38-85ad-5c5efee6bf16	0	20	f	\N	\N
971152f8-06d9-46b8-a6fc-e8d693f1880f	\N	\N	cd0a239f-f540-49da-a4c3-8f57fd497cb4	d9ae1ba0-727d-4e38-85ad-5c5efee6bf16	1	30	t	d7658f35-196b-4bfa-bc0d-4de812f121b5	\N
d4c7cda0-d767-401b-b354-8a997add2be0	\N	conditional-user-configured	cd0a239f-f540-49da-a4c3-8f57fd497cb4	d7658f35-196b-4bfa-bc0d-4de812f121b5	0	10	f	\N	\N
555428c3-7255-4e9e-961b-65b15ca6ab13	\N	direct-grant-validate-otp	cd0a239f-f540-49da-a4c3-8f57fd497cb4	d7658f35-196b-4bfa-bc0d-4de812f121b5	0	20	f	\N	\N
a7ffb0de-ba3d-4eb2-abef-b6fa89d3b3ca	\N	registration-page-form	cd0a239f-f540-49da-a4c3-8f57fd497cb4	b28c2edd-43ab-4c78-aeb4-f7fef818e54b	0	10	t	39be2c9b-dd3a-424a-9d60-e8cee4c32a15	\N
3d957b9e-a682-4619-b220-80386a9f2d69	\N	registration-user-creation	cd0a239f-f540-49da-a4c3-8f57fd497cb4	39be2c9b-dd3a-424a-9d60-e8cee4c32a15	0	20	f	\N	\N
c239dfa9-7aed-4e71-afa7-cf2bf8d0364b	\N	registration-profile-action	cd0a239f-f540-49da-a4c3-8f57fd497cb4	39be2c9b-dd3a-424a-9d60-e8cee4c32a15	0	40	f	\N	\N
3b998e93-df9a-4947-9f51-e4a743fb551d	\N	registration-password-action	cd0a239f-f540-49da-a4c3-8f57fd497cb4	39be2c9b-dd3a-424a-9d60-e8cee4c32a15	0	50	f	\N	\N
de593c3b-83d3-4d2a-9700-d4cda8c33684	\N	registration-recaptcha-action	cd0a239f-f540-49da-a4c3-8f57fd497cb4	39be2c9b-dd3a-424a-9d60-e8cee4c32a15	3	60	f	\N	\N
132b7e86-958d-4c19-bf0f-30e4349d42a1	\N	reset-credentials-choose-user	cd0a239f-f540-49da-a4c3-8f57fd497cb4	aa2dabbe-b7cb-4287-b585-ff0baee6ef30	0	10	f	\N	\N
4b29275a-1c4a-48dd-a94e-b225d2ea2b9a	\N	reset-credential-email	cd0a239f-f540-49da-a4c3-8f57fd497cb4	aa2dabbe-b7cb-4287-b585-ff0baee6ef30	0	20	f	\N	\N
eec3f7f3-b853-4325-b57c-2db27fa052f6	\N	reset-password	cd0a239f-f540-49da-a4c3-8f57fd497cb4	aa2dabbe-b7cb-4287-b585-ff0baee6ef30	0	30	f	\N	\N
7ed555b5-2c83-4868-8ff2-1b0df44bef36	\N	\N	cd0a239f-f540-49da-a4c3-8f57fd497cb4	aa2dabbe-b7cb-4287-b585-ff0baee6ef30	1	40	t	b6c4fa5b-db6e-4aef-a0b3-d30c286d5932	\N
4bf534dd-ed37-46c0-b765-e0af8250c264	\N	conditional-user-configured	cd0a239f-f540-49da-a4c3-8f57fd497cb4	b6c4fa5b-db6e-4aef-a0b3-d30c286d5932	0	10	f	\N	\N
44d55fcd-d44f-4dfd-944a-2ec172c594f8	\N	reset-otp	cd0a239f-f540-49da-a4c3-8f57fd497cb4	b6c4fa5b-db6e-4aef-a0b3-d30c286d5932	0	20	f	\N	\N
ebfe59a3-1322-4217-94e4-82ed07cdcf22	\N	client-secret	cd0a239f-f540-49da-a4c3-8f57fd497cb4	1764b396-3da7-4eda-bf62-5bf4d79123fb	2	10	f	\N	\N
c64d9d19-39de-48d0-b43d-d2661015ca8d	\N	client-jwt	cd0a239f-f540-49da-a4c3-8f57fd497cb4	1764b396-3da7-4eda-bf62-5bf4d79123fb	2	20	f	\N	\N
ecf77ecb-ea71-4761-80e9-2a91a3e14c80	\N	client-secret-jwt	cd0a239f-f540-49da-a4c3-8f57fd497cb4	1764b396-3da7-4eda-bf62-5bf4d79123fb	2	30	f	\N	\N
bfd626cc-ef6d-4502-bd76-297a89be76b1	\N	client-x509	cd0a239f-f540-49da-a4c3-8f57fd497cb4	1764b396-3da7-4eda-bf62-5bf4d79123fb	2	40	f	\N	\N
f05172c0-c221-4321-b0c9-5d3c96d8e627	\N	idp-review-profile	cd0a239f-f540-49da-a4c3-8f57fd497cb4	fc4940bc-903c-4494-9cae-56e8c355bb78	0	10	f	\N	2a3ce4ff-0ecc-490e-859f-7ebd9d54bff2
6adb1565-1513-4688-b03b-d797f78f8c3f	\N	\N	cd0a239f-f540-49da-a4c3-8f57fd497cb4	fc4940bc-903c-4494-9cae-56e8c355bb78	0	20	t	59c43737-5013-4b76-b572-7a7fe52f09ac	\N
b0e86baf-c7a5-4c7a-b8e0-ded499e0c231	\N	idp-create-user-if-unique	cd0a239f-f540-49da-a4c3-8f57fd497cb4	59c43737-5013-4b76-b572-7a7fe52f09ac	2	10	f	\N	d2b85eaf-33af-4309-ac80-5154cb63f09d
b13a1dc7-3d91-4438-aa5a-0acb88404049	\N	\N	cd0a239f-f540-49da-a4c3-8f57fd497cb4	59c43737-5013-4b76-b572-7a7fe52f09ac	2	20	t	04b2539f-37a8-42e7-83b3-3d0361127f17	\N
67ca3d88-a03d-49de-ab55-cc3b9bd81aab	\N	idp-confirm-link	cd0a239f-f540-49da-a4c3-8f57fd497cb4	04b2539f-37a8-42e7-83b3-3d0361127f17	0	10	f	\N	\N
1a85b7ad-7746-4748-a5fb-566da54034a1	\N	\N	cd0a239f-f540-49da-a4c3-8f57fd497cb4	04b2539f-37a8-42e7-83b3-3d0361127f17	0	20	t	9f58fa0e-8f07-4e56-a236-433a2585d160	\N
d8d5dce0-da15-4822-b77f-1a7402cb0db3	\N	idp-email-verification	cd0a239f-f540-49da-a4c3-8f57fd497cb4	9f58fa0e-8f07-4e56-a236-433a2585d160	2	10	f	\N	\N
1db92352-d38c-4143-a98e-ef4735385587	\N	\N	cd0a239f-f540-49da-a4c3-8f57fd497cb4	9f58fa0e-8f07-4e56-a236-433a2585d160	2	20	t	d79d69a5-d1ab-44ff-ab83-ebb884f958ab	\N
8568bc93-847f-4374-b933-7aa3f2bbb254	\N	idp-username-password-form	cd0a239f-f540-49da-a4c3-8f57fd497cb4	d79d69a5-d1ab-44ff-ab83-ebb884f958ab	0	10	f	\N	\N
47bf4252-3ed6-422f-a085-50622f04fe01	\N	\N	cd0a239f-f540-49da-a4c3-8f57fd497cb4	d79d69a5-d1ab-44ff-ab83-ebb884f958ab	1	20	t	dea0abc8-3964-4f9d-9a42-0834f4fdef72	\N
c1122207-3612-4344-b4c9-4144cd75b83b	\N	conditional-user-configured	cd0a239f-f540-49da-a4c3-8f57fd497cb4	dea0abc8-3964-4f9d-9a42-0834f4fdef72	0	10	f	\N	\N
10e61319-69ac-49c8-99e5-3fd286b3ccd2	\N	auth-otp-form	cd0a239f-f540-49da-a4c3-8f57fd497cb4	dea0abc8-3964-4f9d-9a42-0834f4fdef72	0	20	f	\N	\N
7cafb6b1-c7a4-404c-a8c9-344036d34fb2	\N	http-basic-authenticator	cd0a239f-f540-49da-a4c3-8f57fd497cb4	07c685c9-02f6-42d3-a738-22d7867eb43f	0	10	f	\N	\N
00a1b6bd-9511-431e-9fd0-958132f9d07c	\N	docker-http-basic-authenticator	cd0a239f-f540-49da-a4c3-8f57fd497cb4	89f28140-bb7c-4196-8c4a-3dda701b220b	0	10	f	\N	\N
f4236ddd-0cdb-469c-8674-2c26ae43ecac	\N	no-cookie-redirect	cd0a239f-f540-49da-a4c3-8f57fd497cb4	0dcae503-7c3d-4943-9ab6-1d22bc12593f	0	10	f	\N	\N
4089c1a1-a990-4866-8ba9-8dd96779bc14	\N	\N	cd0a239f-f540-49da-a4c3-8f57fd497cb4	0dcae503-7c3d-4943-9ab6-1d22bc12593f	0	20	t	0a6fc122-835d-4aa5-a1ef-3d71193ed51c	\N
0c961ef4-a96f-442e-a085-690b1b8eb88b	\N	basic-auth	cd0a239f-f540-49da-a4c3-8f57fd497cb4	0a6fc122-835d-4aa5-a1ef-3d71193ed51c	0	10	f	\N	\N
90a6cbcc-7817-4724-b278-a52a89520268	\N	basic-auth-otp	cd0a239f-f540-49da-a4c3-8f57fd497cb4	0a6fc122-835d-4aa5-a1ef-3d71193ed51c	3	20	f	\N	\N
3bd0259e-f660-47ae-8ddb-754fe721ed02	\N	auth-spnego	cd0a239f-f540-49da-a4c3-8f57fd497cb4	0a6fc122-835d-4aa5-a1ef-3d71193ed51c	3	30	f	\N	\N
\.


--
-- TOC entry 3853 (class 0 OID 82625)
-- Dependencies: 251
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
8c6fe9ec-0193-4c98-b5a8-ff35cb3202f6	browser	browser based authentication	master	basic-flow	t	t
cd76026d-e73b-44e2-992c-394d18700386	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
ec45156c-8915-4e9a-b4f6-9ce455d7ace6	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
b964a601-5f73-4cec-a380-1bcb44dd6dea	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
8fcb130b-f71b-42f8-a395-fa5fc7ed09f1	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
831312ce-dd7f-47ec-b97c-b7c8e923b064	registration	registration flow	master	basic-flow	t	t
e016f647-0d02-4bfb-8c50-a0fc48f233ec	registration form	registration form	master	form-flow	f	t
d3055c2a-2101-4f09-9b92-9c902fe020ed	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
a94f0290-30dd-4f8f-b244-2d2a8fe5ec4f	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
c5ba5f78-d833-4ea3-a73c-aafce1fad20a	clients	Base authentication for clients	master	client-flow	t	t
ba85f090-6135-4a31-a506-4f1c5fb3f7cb	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
f3b61463-6d5c-480e-a231-fd509e84d07d	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
d424f561-5944-4c65-a53f-16e44e5af284	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
1e975246-16e2-4358-98a0-22afb382848a	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
7aa46816-c365-49b5-add1-c22dcc0ce429	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
2d518418-8256-47c1-8004-ed370faf85d5	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
c1f2965b-edac-4745-81b1-543fb41fbf34	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
d5755433-fab6-4a53-95fa-1ea4fcc183b8	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
c41777bf-dc8d-4f3f-913c-1f1556ec549e	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
8b19c6da-7b0c-43c2-8663-80da20a2798f	Authentication Options	Authentication options.	master	basic-flow	f	t
eaee8493-aa3f-4c76-a52c-85d840127909	browser	browser based authentication	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	t	t
46db6eb7-54b2-412d-817b-006e8cd13257	forms	Username, password, otp and other auth forms.	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	f	t
5895fa69-2fcd-4491-a91a-9c4c69bab39d	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	f	t
d9ae1ba0-727d-4e38-85ad-5c5efee6bf16	direct grant	OpenID Connect Resource Owner Grant	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	t	t
d7658f35-196b-4bfa-bc0d-4de812f121b5	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	f	t
b28c2edd-43ab-4c78-aeb4-f7fef818e54b	registration	registration flow	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	t	t
39be2c9b-dd3a-424a-9d60-e8cee4c32a15	registration form	registration form	cd0a239f-f540-49da-a4c3-8f57fd497cb4	form-flow	f	t
aa2dabbe-b7cb-4287-b585-ff0baee6ef30	reset credentials	Reset credentials for a user if they forgot their password or something	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	t	t
b6c4fa5b-db6e-4aef-a0b3-d30c286d5932	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	f	t
1764b396-3da7-4eda-bf62-5bf4d79123fb	clients	Base authentication for clients	cd0a239f-f540-49da-a4c3-8f57fd497cb4	client-flow	t	t
fc4940bc-903c-4494-9cae-56e8c355bb78	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	t	t
59c43737-5013-4b76-b572-7a7fe52f09ac	User creation or linking	Flow for the existing/non-existing user alternatives	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	f	t
04b2539f-37a8-42e7-83b3-3d0361127f17	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	f	t
9f58fa0e-8f07-4e56-a236-433a2585d160	Account verification options	Method with which to verity the existing account	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	f	t
d79d69a5-d1ab-44ff-ab83-ebb884f958ab	Verify Existing Account by Re-authentication	Reauthentication of existing account	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	f	t
dea0abc8-3964-4f9d-9a42-0834f4fdef72	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	f	t
07c685c9-02f6-42d3-a738-22d7867eb43f	saml ecp	SAML ECP Profile Authentication Flow	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	t	t
89f28140-bb7c-4196-8c4a-3dda701b220b	docker auth	Used by Docker clients to authenticate against the IDP	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	t	t
0dcae503-7c3d-4943-9ab6-1d22bc12593f	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	t	t
0a6fc122-835d-4aa5-a1ef-3d71193ed51c	Authentication Options	Authentication options.	cd0a239f-f540-49da-a4c3-8f57fd497cb4	basic-flow	f	t
\.


--
-- TOC entry 3852 (class 0 OID 82619)
-- Dependencies: 250
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.authenticator_config (id, alias, realm_id) FROM stdin;
83b8fed1-76d0-48d0-b1f4-88fd4a2830c1	review profile config	master
fe7fd354-ea16-471c-8a64-e40c86d4f08a	create unique user config	master
2a3ce4ff-0ecc-490e-859f-7ebd9d54bff2	review profile config	cd0a239f-f540-49da-a4c3-8f57fd497cb4
d2b85eaf-33af-4309-ac80-5154cb63f09d	create unique user config	cd0a239f-f540-49da-a4c3-8f57fd497cb4
\.


--
-- TOC entry 3855 (class 0 OID 82636)
-- Dependencies: 253
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
83b8fed1-76d0-48d0-b1f4-88fd4a2830c1	missing	update.profile.on.first.login
fe7fd354-ea16-471c-8a64-e40c86d4f08a	false	require.password.update.after.registration
2a3ce4ff-0ecc-490e-859f-7ebd9d54bff2	missing	update.profile.on.first.login
d2b85eaf-33af-4309-ac80-5154cb63f09d	false	require.password.update.after.registration
\.


--
-- TOC entry 3881 (class 0 OID 83091)
-- Dependencies: 279
-- Data for Name: broker_link; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 3811 (class 0 OID 81968)
-- Dependencies: 209
-- Data for Name: client; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	t	master-realm	0	f	c165c712-b977-4426-905f-2b1a554ef069	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
1134a440-e17e-4235-9205-fdc3ab98150a	t	f	account	0	f	6a9e4ec4-cb37-4619-8f44-947c9f71d3dc	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7b7142af-e684-45b1-8b3e-cdbd34877635	t	f	account-console	0	t	868e2cd8-ff22-4996-b998-f31f199c8b11	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d603acc4-8910-4208-b574-042cc8f90e7a	t	f	broker	0	f	fb1eadb8-a754-4f72-8026-7e02ac06d21a	\N	f	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
3c40435d-0d15-4f87-9d63-5399cbaf4639	t	f	security-admin-console	0	t	88520f64-8052-4a95-9e15-c86421391819	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
7a036427-8b68-495e-9627-b52de8fe931f	t	f	admin-cli	0	t	9d9bc745-7d9d-4e15-a772-92418e273159	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	t	realm-sample-realm	0	f	19c57c8f-1090-4ed5-8462-45dd2df82d0d	\N	t	\N	f	master	\N	0	f	f	realm-sample Realm	f	client-secret	\N	\N	\N	t	f	f	f
3a90bac6-ce11-467a-98b6-e2b2506d067c	t	f	realm-management	0	f	0e43c4e9-782e-410d-80c3-ee63af747e71	\N	t	\N	f	cd0a239f-f540-49da-a4c3-8f57fd497cb4	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
417353a9-b424-43ad-96cd-0d651fc3f184	t	f	account	0	f	b2db43a9-1669-4a81-9694-afdea9ffcf68	/realms/realm-sample/account/	f	\N	f	cd0a239f-f540-49da-a4c3-8f57fd497cb4	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4d364ac2-1ae1-4e14-84e3-8a108277c05d	t	f	account-console	0	t	b0579799-fed3-4e1f-b8f0-f6b552dda7bb	/realms/realm-sample/account/	f	\N	f	cd0a239f-f540-49da-a4c3-8f57fd497cb4	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
847f8402-3f9a-4733-8193-c1bb8922fe5b	t	f	broker	0	f	0b79c0ec-aa87-4181-8af9-de5c40810d96	\N	f	\N	f	cd0a239f-f540-49da-a4c3-8f57fd497cb4	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
eeac28db-e546-4cbd-8d1d-ea2bf0077028	t	f	security-admin-console	0	t	78b11e25-91d1-4dc8-b3c7-d85e6990c8af	/admin/realm-sample/console/	f	\N	f	cd0a239f-f540-49da-a4c3-8f57fd497cb4	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
a358c3ed-51cb-470f-9df3-93c8da846000	t	f	admin-cli	0	t	89052fe5-090b-4dc6-a75c-35eae7476fd0	\N	f	\N	f	cd0a239f-f540-49da-a4c3-8f57fd497cb4	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
572824ad-4fe5-41da-8fd1-c3ba5661374c	t	t	sample-client	0	t	8f27222d-a600-42af-b255-6f2c3d9f2efd	\N	f	\N	f	cd0a239f-f540-49da-a4c3-8f57fd497cb4	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
\.


--
-- TOC entry 3835 (class 0 OID 82342)
-- Dependencies: 233
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_attributes (client_id, value, name) FROM stdin;
7b7142af-e684-45b1-8b3e-cdbd34877635	S256	pkce.code.challenge.method
3c40435d-0d15-4f87-9d63-5399cbaf4639	S256	pkce.code.challenge.method
4d364ac2-1ae1-4e14-84e3-8a108277c05d	S256	pkce.code.challenge.method
eeac28db-e546-4cbd-8d1d-ea2bf0077028	S256	pkce.code.challenge.method
\.


--
-- TOC entry 3892 (class 0 OID 83350)
-- Dependencies: 290
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- TOC entry 3810 (class 0 OID 81965)
-- Dependencies: 208
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_default_roles (client_id, role_id) FROM stdin;
1134a440-e17e-4235-9205-fdc3ab98150a	ecee88a7-b0cb-40a1-bc3b-dee2d680d51a
1134a440-e17e-4235-9205-fdc3ab98150a	6b34fc9f-2cfc-4c1f-9f99-c2314742f37d
417353a9-b424-43ad-96cd-0d651fc3f184	2bd10fb2-e2a1-4695-955c-bce0bb624e93
417353a9-b424-43ad-96cd-0d651fc3f184	ecb7c80e-3a4c-4f97-b56e-900f697d9195
\.


--
-- TOC entry 3891 (class 0 OID 83225)
-- Dependencies: 289
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- TOC entry 3837 (class 0 OID 82354)
-- Dependencies: 235
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- TOC entry 3869 (class 0 OID 82874)
-- Dependencies: 267
-- Data for Name: client_scope; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_scope (id, name, realm_id, description, protocol) FROM stdin;
58e411ab-24d6-4256-9b04-dc94bb9a3e63	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
542c39e4-a0ae-467c-a11a-119d40d9cf91	role_list	master	SAML role list	saml
ab19a893-0b5d-41d6-9649-6269cfd8fc74	profile	master	OpenID Connect built-in scope: profile	openid-connect
1f5b66a8-fcbe-44f1-a146-a68a486fcf55	email	master	OpenID Connect built-in scope: email	openid-connect
6a8b58fa-b075-45d5-9db0-1850e42dc2df	address	master	OpenID Connect built-in scope: address	openid-connect
dc4edb03-85e7-44e4-ba52-308e9cefa7b3	phone	master	OpenID Connect built-in scope: phone	openid-connect
452dd164-f028-4c1d-9434-b06ec6ae0e2b	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
8b37700b-1792-4c4d-ae96-88d9f3b7f80f	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
9656cdb9-7432-4e0b-9744-06e6c6dfd779	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
8384725d-0ea5-4e60-8280-670410eedd6f	offline_access	cd0a239f-f540-49da-a4c3-8f57fd497cb4	OpenID Connect built-in scope: offline_access	openid-connect
5c16a285-19ef-4c28-931d-24e037796c6b	role_list	cd0a239f-f540-49da-a4c3-8f57fd497cb4	SAML role list	saml
d14f82e5-c666-49fb-900f-035e859723ed	profile	cd0a239f-f540-49da-a4c3-8f57fd497cb4	OpenID Connect built-in scope: profile	openid-connect
911a036a-a3eb-459d-8712-5a8add44d451	email	cd0a239f-f540-49da-a4c3-8f57fd497cb4	OpenID Connect built-in scope: email	openid-connect
7cae1885-591f-462e-862d-d2cda2435a65	address	cd0a239f-f540-49da-a4c3-8f57fd497cb4	OpenID Connect built-in scope: address	openid-connect
01bd033a-edf5-4f61-b352-8b0efe58ee41	phone	cd0a239f-f540-49da-a4c3-8f57fd497cb4	OpenID Connect built-in scope: phone	openid-connect
5496757b-0678-41fd-a53b-fcd1f720bb9c	roles	cd0a239f-f540-49da-a4c3-8f57fd497cb4	OpenID Connect scope for add user roles to the access token	openid-connect
a70675d8-0782-41dd-b771-92ea720a4230	web-origins	cd0a239f-f540-49da-a4c3-8f57fd497cb4	OpenID Connect scope for add allowed web origins to the access token	openid-connect
e9d72e1c-f971-4c85-b094-bb7c804cddb1	microprofile-jwt	cd0a239f-f540-49da-a4c3-8f57fd497cb4	Microprofile - JWT built-in scope	openid-connect
814f84b1-e4f9-4455-a428-8be5c9a25781	user	cd0a239f-f540-49da-a4c3-8f57fd497cb4	\N	openid-connect
\.


--
-- TOC entry 3870 (class 0 OID 82889)
-- Dependencies: 268
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_scope_attributes (scope_id, value, name) FROM stdin;
58e411ab-24d6-4256-9b04-dc94bb9a3e63	true	display.on.consent.screen
58e411ab-24d6-4256-9b04-dc94bb9a3e63	${offlineAccessScopeConsentText}	consent.screen.text
542c39e4-a0ae-467c-a11a-119d40d9cf91	true	display.on.consent.screen
542c39e4-a0ae-467c-a11a-119d40d9cf91	${samlRoleListScopeConsentText}	consent.screen.text
ab19a893-0b5d-41d6-9649-6269cfd8fc74	true	display.on.consent.screen
ab19a893-0b5d-41d6-9649-6269cfd8fc74	${profileScopeConsentText}	consent.screen.text
ab19a893-0b5d-41d6-9649-6269cfd8fc74	true	include.in.token.scope
1f5b66a8-fcbe-44f1-a146-a68a486fcf55	true	display.on.consent.screen
1f5b66a8-fcbe-44f1-a146-a68a486fcf55	${emailScopeConsentText}	consent.screen.text
1f5b66a8-fcbe-44f1-a146-a68a486fcf55	true	include.in.token.scope
6a8b58fa-b075-45d5-9db0-1850e42dc2df	true	display.on.consent.screen
6a8b58fa-b075-45d5-9db0-1850e42dc2df	${addressScopeConsentText}	consent.screen.text
6a8b58fa-b075-45d5-9db0-1850e42dc2df	true	include.in.token.scope
dc4edb03-85e7-44e4-ba52-308e9cefa7b3	true	display.on.consent.screen
dc4edb03-85e7-44e4-ba52-308e9cefa7b3	${phoneScopeConsentText}	consent.screen.text
dc4edb03-85e7-44e4-ba52-308e9cefa7b3	true	include.in.token.scope
452dd164-f028-4c1d-9434-b06ec6ae0e2b	true	display.on.consent.screen
452dd164-f028-4c1d-9434-b06ec6ae0e2b	${rolesScopeConsentText}	consent.screen.text
452dd164-f028-4c1d-9434-b06ec6ae0e2b	false	include.in.token.scope
8b37700b-1792-4c4d-ae96-88d9f3b7f80f	false	display.on.consent.screen
8b37700b-1792-4c4d-ae96-88d9f3b7f80f		consent.screen.text
8b37700b-1792-4c4d-ae96-88d9f3b7f80f	false	include.in.token.scope
9656cdb9-7432-4e0b-9744-06e6c6dfd779	false	display.on.consent.screen
9656cdb9-7432-4e0b-9744-06e6c6dfd779	true	include.in.token.scope
8384725d-0ea5-4e60-8280-670410eedd6f	true	display.on.consent.screen
8384725d-0ea5-4e60-8280-670410eedd6f	${offlineAccessScopeConsentText}	consent.screen.text
5c16a285-19ef-4c28-931d-24e037796c6b	true	display.on.consent.screen
5c16a285-19ef-4c28-931d-24e037796c6b	${samlRoleListScopeConsentText}	consent.screen.text
d14f82e5-c666-49fb-900f-035e859723ed	true	display.on.consent.screen
d14f82e5-c666-49fb-900f-035e859723ed	${profileScopeConsentText}	consent.screen.text
d14f82e5-c666-49fb-900f-035e859723ed	true	include.in.token.scope
911a036a-a3eb-459d-8712-5a8add44d451	true	display.on.consent.screen
911a036a-a3eb-459d-8712-5a8add44d451	${emailScopeConsentText}	consent.screen.text
911a036a-a3eb-459d-8712-5a8add44d451	true	include.in.token.scope
7cae1885-591f-462e-862d-d2cda2435a65	true	display.on.consent.screen
7cae1885-591f-462e-862d-d2cda2435a65	${addressScopeConsentText}	consent.screen.text
7cae1885-591f-462e-862d-d2cda2435a65	true	include.in.token.scope
01bd033a-edf5-4f61-b352-8b0efe58ee41	true	display.on.consent.screen
01bd033a-edf5-4f61-b352-8b0efe58ee41	${phoneScopeConsentText}	consent.screen.text
01bd033a-edf5-4f61-b352-8b0efe58ee41	true	include.in.token.scope
5496757b-0678-41fd-a53b-fcd1f720bb9c	true	display.on.consent.screen
5496757b-0678-41fd-a53b-fcd1f720bb9c	${rolesScopeConsentText}	consent.screen.text
5496757b-0678-41fd-a53b-fcd1f720bb9c	false	include.in.token.scope
a70675d8-0782-41dd-b771-92ea720a4230	false	display.on.consent.screen
a70675d8-0782-41dd-b771-92ea720a4230		consent.screen.text
a70675d8-0782-41dd-b771-92ea720a4230	false	include.in.token.scope
e9d72e1c-f971-4c85-b094-bb7c804cddb1	false	display.on.consent.screen
e9d72e1c-f971-4c85-b094-bb7c804cddb1	true	include.in.token.scope
\.


--
-- TOC entry 3893 (class 0 OID 83392)
-- Dependencies: 291
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
1134a440-e17e-4235-9205-fdc3ab98150a	542c39e4-a0ae-467c-a11a-119d40d9cf91	t
7b7142af-e684-45b1-8b3e-cdbd34877635	542c39e4-a0ae-467c-a11a-119d40d9cf91	t
7a036427-8b68-495e-9627-b52de8fe931f	542c39e4-a0ae-467c-a11a-119d40d9cf91	t
d603acc4-8910-4208-b574-042cc8f90e7a	542c39e4-a0ae-467c-a11a-119d40d9cf91	t
f1d6c39d-1edb-478f-afa9-f50ba13c43ff	542c39e4-a0ae-467c-a11a-119d40d9cf91	t
3c40435d-0d15-4f87-9d63-5399cbaf4639	542c39e4-a0ae-467c-a11a-119d40d9cf91	t
1134a440-e17e-4235-9205-fdc3ab98150a	1f5b66a8-fcbe-44f1-a146-a68a486fcf55	t
1134a440-e17e-4235-9205-fdc3ab98150a	8b37700b-1792-4c4d-ae96-88d9f3b7f80f	t
1134a440-e17e-4235-9205-fdc3ab98150a	452dd164-f028-4c1d-9434-b06ec6ae0e2b	t
1134a440-e17e-4235-9205-fdc3ab98150a	ab19a893-0b5d-41d6-9649-6269cfd8fc74	t
1134a440-e17e-4235-9205-fdc3ab98150a	9656cdb9-7432-4e0b-9744-06e6c6dfd779	f
1134a440-e17e-4235-9205-fdc3ab98150a	dc4edb03-85e7-44e4-ba52-308e9cefa7b3	f
1134a440-e17e-4235-9205-fdc3ab98150a	6a8b58fa-b075-45d5-9db0-1850e42dc2df	f
1134a440-e17e-4235-9205-fdc3ab98150a	58e411ab-24d6-4256-9b04-dc94bb9a3e63	f
7b7142af-e684-45b1-8b3e-cdbd34877635	1f5b66a8-fcbe-44f1-a146-a68a486fcf55	t
7b7142af-e684-45b1-8b3e-cdbd34877635	8b37700b-1792-4c4d-ae96-88d9f3b7f80f	t
7b7142af-e684-45b1-8b3e-cdbd34877635	452dd164-f028-4c1d-9434-b06ec6ae0e2b	t
7b7142af-e684-45b1-8b3e-cdbd34877635	ab19a893-0b5d-41d6-9649-6269cfd8fc74	t
7b7142af-e684-45b1-8b3e-cdbd34877635	9656cdb9-7432-4e0b-9744-06e6c6dfd779	f
7b7142af-e684-45b1-8b3e-cdbd34877635	dc4edb03-85e7-44e4-ba52-308e9cefa7b3	f
7b7142af-e684-45b1-8b3e-cdbd34877635	6a8b58fa-b075-45d5-9db0-1850e42dc2df	f
7b7142af-e684-45b1-8b3e-cdbd34877635	58e411ab-24d6-4256-9b04-dc94bb9a3e63	f
7a036427-8b68-495e-9627-b52de8fe931f	1f5b66a8-fcbe-44f1-a146-a68a486fcf55	t
7a036427-8b68-495e-9627-b52de8fe931f	8b37700b-1792-4c4d-ae96-88d9f3b7f80f	t
7a036427-8b68-495e-9627-b52de8fe931f	452dd164-f028-4c1d-9434-b06ec6ae0e2b	t
7a036427-8b68-495e-9627-b52de8fe931f	ab19a893-0b5d-41d6-9649-6269cfd8fc74	t
7a036427-8b68-495e-9627-b52de8fe931f	9656cdb9-7432-4e0b-9744-06e6c6dfd779	f
7a036427-8b68-495e-9627-b52de8fe931f	dc4edb03-85e7-44e4-ba52-308e9cefa7b3	f
7a036427-8b68-495e-9627-b52de8fe931f	6a8b58fa-b075-45d5-9db0-1850e42dc2df	f
7a036427-8b68-495e-9627-b52de8fe931f	58e411ab-24d6-4256-9b04-dc94bb9a3e63	f
d603acc4-8910-4208-b574-042cc8f90e7a	1f5b66a8-fcbe-44f1-a146-a68a486fcf55	t
d603acc4-8910-4208-b574-042cc8f90e7a	8b37700b-1792-4c4d-ae96-88d9f3b7f80f	t
d603acc4-8910-4208-b574-042cc8f90e7a	452dd164-f028-4c1d-9434-b06ec6ae0e2b	t
d603acc4-8910-4208-b574-042cc8f90e7a	ab19a893-0b5d-41d6-9649-6269cfd8fc74	t
d603acc4-8910-4208-b574-042cc8f90e7a	9656cdb9-7432-4e0b-9744-06e6c6dfd779	f
d603acc4-8910-4208-b574-042cc8f90e7a	dc4edb03-85e7-44e4-ba52-308e9cefa7b3	f
d603acc4-8910-4208-b574-042cc8f90e7a	6a8b58fa-b075-45d5-9db0-1850e42dc2df	f
d603acc4-8910-4208-b574-042cc8f90e7a	58e411ab-24d6-4256-9b04-dc94bb9a3e63	f
f1d6c39d-1edb-478f-afa9-f50ba13c43ff	1f5b66a8-fcbe-44f1-a146-a68a486fcf55	t
f1d6c39d-1edb-478f-afa9-f50ba13c43ff	8b37700b-1792-4c4d-ae96-88d9f3b7f80f	t
f1d6c39d-1edb-478f-afa9-f50ba13c43ff	452dd164-f028-4c1d-9434-b06ec6ae0e2b	t
f1d6c39d-1edb-478f-afa9-f50ba13c43ff	ab19a893-0b5d-41d6-9649-6269cfd8fc74	t
f1d6c39d-1edb-478f-afa9-f50ba13c43ff	9656cdb9-7432-4e0b-9744-06e6c6dfd779	f
f1d6c39d-1edb-478f-afa9-f50ba13c43ff	dc4edb03-85e7-44e4-ba52-308e9cefa7b3	f
f1d6c39d-1edb-478f-afa9-f50ba13c43ff	6a8b58fa-b075-45d5-9db0-1850e42dc2df	f
f1d6c39d-1edb-478f-afa9-f50ba13c43ff	58e411ab-24d6-4256-9b04-dc94bb9a3e63	f
3c40435d-0d15-4f87-9d63-5399cbaf4639	1f5b66a8-fcbe-44f1-a146-a68a486fcf55	t
3c40435d-0d15-4f87-9d63-5399cbaf4639	8b37700b-1792-4c4d-ae96-88d9f3b7f80f	t
3c40435d-0d15-4f87-9d63-5399cbaf4639	452dd164-f028-4c1d-9434-b06ec6ae0e2b	t
3c40435d-0d15-4f87-9d63-5399cbaf4639	ab19a893-0b5d-41d6-9649-6269cfd8fc74	t
3c40435d-0d15-4f87-9d63-5399cbaf4639	9656cdb9-7432-4e0b-9744-06e6c6dfd779	f
3c40435d-0d15-4f87-9d63-5399cbaf4639	dc4edb03-85e7-44e4-ba52-308e9cefa7b3	f
3c40435d-0d15-4f87-9d63-5399cbaf4639	6a8b58fa-b075-45d5-9db0-1850e42dc2df	f
3c40435d-0d15-4f87-9d63-5399cbaf4639	58e411ab-24d6-4256-9b04-dc94bb9a3e63	f
83e8abd9-2395-481f-b1d6-8e1857eb1ca7	542c39e4-a0ae-467c-a11a-119d40d9cf91	t
83e8abd9-2395-481f-b1d6-8e1857eb1ca7	1f5b66a8-fcbe-44f1-a146-a68a486fcf55	t
83e8abd9-2395-481f-b1d6-8e1857eb1ca7	8b37700b-1792-4c4d-ae96-88d9f3b7f80f	t
83e8abd9-2395-481f-b1d6-8e1857eb1ca7	452dd164-f028-4c1d-9434-b06ec6ae0e2b	t
83e8abd9-2395-481f-b1d6-8e1857eb1ca7	ab19a893-0b5d-41d6-9649-6269cfd8fc74	t
83e8abd9-2395-481f-b1d6-8e1857eb1ca7	9656cdb9-7432-4e0b-9744-06e6c6dfd779	f
83e8abd9-2395-481f-b1d6-8e1857eb1ca7	dc4edb03-85e7-44e4-ba52-308e9cefa7b3	f
83e8abd9-2395-481f-b1d6-8e1857eb1ca7	6a8b58fa-b075-45d5-9db0-1850e42dc2df	f
83e8abd9-2395-481f-b1d6-8e1857eb1ca7	58e411ab-24d6-4256-9b04-dc94bb9a3e63	f
417353a9-b424-43ad-96cd-0d651fc3f184	5c16a285-19ef-4c28-931d-24e037796c6b	t
4d364ac2-1ae1-4e14-84e3-8a108277c05d	5c16a285-19ef-4c28-931d-24e037796c6b	t
a358c3ed-51cb-470f-9df3-93c8da846000	5c16a285-19ef-4c28-931d-24e037796c6b	t
847f8402-3f9a-4733-8193-c1bb8922fe5b	5c16a285-19ef-4c28-931d-24e037796c6b	t
3a90bac6-ce11-467a-98b6-e2b2506d067c	5c16a285-19ef-4c28-931d-24e037796c6b	t
eeac28db-e546-4cbd-8d1d-ea2bf0077028	5c16a285-19ef-4c28-931d-24e037796c6b	t
417353a9-b424-43ad-96cd-0d651fc3f184	d14f82e5-c666-49fb-900f-035e859723ed	t
417353a9-b424-43ad-96cd-0d651fc3f184	911a036a-a3eb-459d-8712-5a8add44d451	t
417353a9-b424-43ad-96cd-0d651fc3f184	5496757b-0678-41fd-a53b-fcd1f720bb9c	t
417353a9-b424-43ad-96cd-0d651fc3f184	a70675d8-0782-41dd-b771-92ea720a4230	t
417353a9-b424-43ad-96cd-0d651fc3f184	01bd033a-edf5-4f61-b352-8b0efe58ee41	f
417353a9-b424-43ad-96cd-0d651fc3f184	7cae1885-591f-462e-862d-d2cda2435a65	f
417353a9-b424-43ad-96cd-0d651fc3f184	e9d72e1c-f971-4c85-b094-bb7c804cddb1	f
417353a9-b424-43ad-96cd-0d651fc3f184	8384725d-0ea5-4e60-8280-670410eedd6f	f
4d364ac2-1ae1-4e14-84e3-8a108277c05d	d14f82e5-c666-49fb-900f-035e859723ed	t
4d364ac2-1ae1-4e14-84e3-8a108277c05d	911a036a-a3eb-459d-8712-5a8add44d451	t
4d364ac2-1ae1-4e14-84e3-8a108277c05d	5496757b-0678-41fd-a53b-fcd1f720bb9c	t
4d364ac2-1ae1-4e14-84e3-8a108277c05d	a70675d8-0782-41dd-b771-92ea720a4230	t
4d364ac2-1ae1-4e14-84e3-8a108277c05d	01bd033a-edf5-4f61-b352-8b0efe58ee41	f
4d364ac2-1ae1-4e14-84e3-8a108277c05d	7cae1885-591f-462e-862d-d2cda2435a65	f
4d364ac2-1ae1-4e14-84e3-8a108277c05d	e9d72e1c-f971-4c85-b094-bb7c804cddb1	f
4d364ac2-1ae1-4e14-84e3-8a108277c05d	8384725d-0ea5-4e60-8280-670410eedd6f	f
a358c3ed-51cb-470f-9df3-93c8da846000	d14f82e5-c666-49fb-900f-035e859723ed	t
a358c3ed-51cb-470f-9df3-93c8da846000	911a036a-a3eb-459d-8712-5a8add44d451	t
a358c3ed-51cb-470f-9df3-93c8da846000	5496757b-0678-41fd-a53b-fcd1f720bb9c	t
a358c3ed-51cb-470f-9df3-93c8da846000	a70675d8-0782-41dd-b771-92ea720a4230	t
a358c3ed-51cb-470f-9df3-93c8da846000	01bd033a-edf5-4f61-b352-8b0efe58ee41	f
a358c3ed-51cb-470f-9df3-93c8da846000	7cae1885-591f-462e-862d-d2cda2435a65	f
a358c3ed-51cb-470f-9df3-93c8da846000	e9d72e1c-f971-4c85-b094-bb7c804cddb1	f
a358c3ed-51cb-470f-9df3-93c8da846000	8384725d-0ea5-4e60-8280-670410eedd6f	f
847f8402-3f9a-4733-8193-c1bb8922fe5b	d14f82e5-c666-49fb-900f-035e859723ed	t
847f8402-3f9a-4733-8193-c1bb8922fe5b	911a036a-a3eb-459d-8712-5a8add44d451	t
847f8402-3f9a-4733-8193-c1bb8922fe5b	5496757b-0678-41fd-a53b-fcd1f720bb9c	t
847f8402-3f9a-4733-8193-c1bb8922fe5b	a70675d8-0782-41dd-b771-92ea720a4230	t
847f8402-3f9a-4733-8193-c1bb8922fe5b	01bd033a-edf5-4f61-b352-8b0efe58ee41	f
847f8402-3f9a-4733-8193-c1bb8922fe5b	7cae1885-591f-462e-862d-d2cda2435a65	f
847f8402-3f9a-4733-8193-c1bb8922fe5b	e9d72e1c-f971-4c85-b094-bb7c804cddb1	f
847f8402-3f9a-4733-8193-c1bb8922fe5b	8384725d-0ea5-4e60-8280-670410eedd6f	f
3a90bac6-ce11-467a-98b6-e2b2506d067c	d14f82e5-c666-49fb-900f-035e859723ed	t
3a90bac6-ce11-467a-98b6-e2b2506d067c	911a036a-a3eb-459d-8712-5a8add44d451	t
3a90bac6-ce11-467a-98b6-e2b2506d067c	5496757b-0678-41fd-a53b-fcd1f720bb9c	t
3a90bac6-ce11-467a-98b6-e2b2506d067c	a70675d8-0782-41dd-b771-92ea720a4230	t
3a90bac6-ce11-467a-98b6-e2b2506d067c	01bd033a-edf5-4f61-b352-8b0efe58ee41	f
3a90bac6-ce11-467a-98b6-e2b2506d067c	7cae1885-591f-462e-862d-d2cda2435a65	f
3a90bac6-ce11-467a-98b6-e2b2506d067c	e9d72e1c-f971-4c85-b094-bb7c804cddb1	f
3a90bac6-ce11-467a-98b6-e2b2506d067c	8384725d-0ea5-4e60-8280-670410eedd6f	f
eeac28db-e546-4cbd-8d1d-ea2bf0077028	d14f82e5-c666-49fb-900f-035e859723ed	t
eeac28db-e546-4cbd-8d1d-ea2bf0077028	911a036a-a3eb-459d-8712-5a8add44d451	t
eeac28db-e546-4cbd-8d1d-ea2bf0077028	5496757b-0678-41fd-a53b-fcd1f720bb9c	t
eeac28db-e546-4cbd-8d1d-ea2bf0077028	a70675d8-0782-41dd-b771-92ea720a4230	t
eeac28db-e546-4cbd-8d1d-ea2bf0077028	01bd033a-edf5-4f61-b352-8b0efe58ee41	f
eeac28db-e546-4cbd-8d1d-ea2bf0077028	7cae1885-591f-462e-862d-d2cda2435a65	f
eeac28db-e546-4cbd-8d1d-ea2bf0077028	e9d72e1c-f971-4c85-b094-bb7c804cddb1	f
eeac28db-e546-4cbd-8d1d-ea2bf0077028	8384725d-0ea5-4e60-8280-670410eedd6f	f
572824ad-4fe5-41da-8fd1-c3ba5661374c	814f84b1-e4f9-4455-a428-8be5c9a25781	t
572824ad-4fe5-41da-8fd1-c3ba5661374c	a70675d8-0782-41dd-b771-92ea720a4230	t
572824ad-4fe5-41da-8fd1-c3ba5661374c	d14f82e5-c666-49fb-900f-035e859723ed	t
572824ad-4fe5-41da-8fd1-c3ba5661374c	5496757b-0678-41fd-a53b-fcd1f720bb9c	t
572824ad-4fe5-41da-8fd1-c3ba5661374c	911a036a-a3eb-459d-8712-5a8add44d451	t
\.


--
-- TOC entry 3871 (class 0 OID 82895)
-- Dependencies: 269
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_scope_role_mapping (scope_id, role_id) FROM stdin;
58e411ab-24d6-4256-9b04-dc94bb9a3e63	d01a17e2-11c6-44a1-b36e-f79593346796
8384725d-0ea5-4e60-8280-670410eedd6f	bcc590f0-b6bf-4eee-afe9-aea0acb387b4
\.


--
-- TOC entry 3812 (class 0 OID 81980)
-- Dependencies: 210
-- Data for Name: client_session; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- TOC entry 3858 (class 0 OID 82657)
-- Dependencies: 256
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- TOC entry 3836 (class 0 OID 82348)
-- Dependencies: 234
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- TOC entry 3850 (class 0 OID 82535)
-- Dependencies: 248
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- TOC entry 3813 (class 0 OID 81986)
-- Dependencies: 211
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- TOC entry 3859 (class 0 OID 82738)
-- Dependencies: 257
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- TOC entry 3889 (class 0 OID 83141)
-- Dependencies: 287
-- Data for Name: component; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
7bee4123-cdb6-4bf1-a5c9-344ad0ffde0f	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
c145948c-f554-477a-aeb9-28eedce77018	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
faecb43b-0caf-4fe8-914f-cf74ae87c88b	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
a774f3ac-d6c2-4e93-9a4b-2823d900663a	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
f6302636-b433-4512-bf5e-31d8fea5dfa9	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
cebfa000-39c4-47e5-9c0b-dbb35b489ec0	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
a32991bf-3749-4f2c-9969-ebd6f9cc9062	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
1828159c-4946-433c-9c7d-09c284378665	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
6c63042b-05fc-408d-9e2c-3647c612d754	fallback-RS256	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
d299dbb5-7dda-4a08-ad46-e9881b0af440	fallback-HS256	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
24872f9f-1c66-45a5-a7ab-0c8f29215394	rsa-generated	cd0a239f-f540-49da-a4c3-8f57fd497cb4	rsa-generated	org.keycloak.keys.KeyProvider	cd0a239f-f540-49da-a4c3-8f57fd497cb4	\N
2d6b7dc9-ab4c-4fc3-95d7-4a9bede4bcda	hmac-generated	cd0a239f-f540-49da-a4c3-8f57fd497cb4	hmac-generated	org.keycloak.keys.KeyProvider	cd0a239f-f540-49da-a4c3-8f57fd497cb4	\N
0b306480-8871-4ab7-8687-f68d8a858e14	aes-generated	cd0a239f-f540-49da-a4c3-8f57fd497cb4	aes-generated	org.keycloak.keys.KeyProvider	cd0a239f-f540-49da-a4c3-8f57fd497cb4	\N
5fff6108-ec39-49f6-ad4b-ea8f6411cd6b	Trusted Hosts	cd0a239f-f540-49da-a4c3-8f57fd497cb4	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cd0a239f-f540-49da-a4c3-8f57fd497cb4	anonymous
575f9b48-cf65-458d-9ce4-d1185374e4fe	Consent Required	cd0a239f-f540-49da-a4c3-8f57fd497cb4	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cd0a239f-f540-49da-a4c3-8f57fd497cb4	anonymous
475d092e-224b-4969-8feb-586001fdc186	Full Scope Disabled	cd0a239f-f540-49da-a4c3-8f57fd497cb4	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cd0a239f-f540-49da-a4c3-8f57fd497cb4	anonymous
43c8accc-a462-4668-8d2b-f078ec62ab6c	Max Clients Limit	cd0a239f-f540-49da-a4c3-8f57fd497cb4	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cd0a239f-f540-49da-a4c3-8f57fd497cb4	anonymous
72210737-5ff0-457c-9724-15b534d0434c	Allowed Protocol Mapper Types	cd0a239f-f540-49da-a4c3-8f57fd497cb4	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cd0a239f-f540-49da-a4c3-8f57fd497cb4	anonymous
a40ad885-a746-479a-bcc6-0cc956d989ba	Allowed Client Scopes	cd0a239f-f540-49da-a4c3-8f57fd497cb4	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cd0a239f-f540-49da-a4c3-8f57fd497cb4	anonymous
b5d9ed75-8c66-48b9-a417-cfe97841d8d2	Allowed Protocol Mapper Types	cd0a239f-f540-49da-a4c3-8f57fd497cb4	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cd0a239f-f540-49da-a4c3-8f57fd497cb4	authenticated
53d08211-8ec6-4a16-b9dc-bbae50e9756d	Allowed Client Scopes	cd0a239f-f540-49da-a4c3-8f57fd497cb4	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cd0a239f-f540-49da-a4c3-8f57fd497cb4	authenticated
\.


--
-- TOC entry 3888 (class 0 OID 83135)
-- Dependencies: 286
-- Data for Name: component_config; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.component_config (id, component_id, name, value) FROM stdin;
ca45e2c2-3c64-4ddb-8d08-024f510c7a09	f6302636-b433-4512-bf5e-31d8fea5dfa9	allowed-protocol-mapper-types	saml-user-attribute-mapper
d1b92e1c-a9d1-486c-87d7-0bc0b99f02db	f6302636-b433-4512-bf5e-31d8fea5dfa9	allowed-protocol-mapper-types	oidc-address-mapper
3c495459-abd3-4021-92d3-b68cc6cd28d8	f6302636-b433-4512-bf5e-31d8fea5dfa9	allowed-protocol-mapper-types	saml-role-list-mapper
3c333cf5-5f66-4b60-a9ff-f6fbd2086b5e	f6302636-b433-4512-bf5e-31d8fea5dfa9	allowed-protocol-mapper-types	saml-user-property-mapper
0ab0d995-5b30-4b90-8392-32db3963b8d2	f6302636-b433-4512-bf5e-31d8fea5dfa9	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
6c0427f7-7b28-4c1c-a580-57ed822d49ea	f6302636-b433-4512-bf5e-31d8fea5dfa9	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b7c32f52-34f2-4713-a308-d76206aa59f6	f6302636-b433-4512-bf5e-31d8fea5dfa9	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b9741064-25ac-40e0-8e85-e473ac6777a0	f6302636-b433-4512-bf5e-31d8fea5dfa9	allowed-protocol-mapper-types	oidc-full-name-mapper
013b53c7-00c1-44df-a764-d6b0a4719e36	1828159c-4946-433c-9c7d-09c284378665	allow-default-scopes	true
1295fe90-259d-4c02-81d3-9fa7122530f3	a774f3ac-d6c2-4e93-9a4b-2823d900663a	max-clients	200
7ff43b20-a5c0-486c-9974-630520bf66c9	7bee4123-cdb6-4bf1-a5c9-344ad0ffde0f	host-sending-registration-request-must-match	true
31e60243-70dd-4be7-9310-52f958a6190c	7bee4123-cdb6-4bf1-a5c9-344ad0ffde0f	client-uris-must-match	true
68c8033e-eb31-4db2-a0aa-0a793c04f787	a32991bf-3749-4f2c-9969-ebd6f9cc9062	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
8b253472-5d26-4d75-bbba-4b0278ee1f94	a32991bf-3749-4f2c-9969-ebd6f9cc9062	allowed-protocol-mapper-types	oidc-full-name-mapper
b2d508c2-3903-412e-9679-e6311c08430a	a32991bf-3749-4f2c-9969-ebd6f9cc9062	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
a2045783-5491-4fff-8fd5-166abef7e7c3	a32991bf-3749-4f2c-9969-ebd6f9cc9062	allowed-protocol-mapper-types	saml-user-attribute-mapper
f8aa8d7a-1a55-4f53-b1db-6b0ca5f85c39	a32991bf-3749-4f2c-9969-ebd6f9cc9062	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
ee5bd57a-097f-4632-84fb-1c275d90d11e	a32991bf-3749-4f2c-9969-ebd6f9cc9062	allowed-protocol-mapper-types	saml-user-property-mapper
230c9ecc-5818-46d4-9c9c-e884332281a0	a32991bf-3749-4f2c-9969-ebd6f9cc9062	allowed-protocol-mapper-types	saml-role-list-mapper
81cc6d57-56bc-44d7-8fba-ac1f0b28b20b	a32991bf-3749-4f2c-9969-ebd6f9cc9062	allowed-protocol-mapper-types	oidc-address-mapper
1507d4da-d74d-48b4-9cf1-c22f6112f69b	cebfa000-39c4-47e5-9c0b-dbb35b489ec0	allow-default-scopes	true
4f29b94e-7428-4dc0-b935-15375d03026d	6c63042b-05fc-408d-9e2c-3647c612d754	algorithm	RS256
26bf2fc7-6010-4b19-8840-9599b222948a	6c63042b-05fc-408d-9e2c-3647c612d754	privateKey	MIIEpAIBAAKCAQEAsRiG75im2VJfdhHtK0Fwi7iTtgmqyb/IBXJ0PqSfcV5thnebQ0FaF0I9USvcnBkL0H1cKFI6MG07jlsganks5OeLSNiuQ1cBnNW2lSMnpXZwbouQlATGMfJYuKC+L7Eii18jMgWAX7qdi8Rhoh09YDLXVlBmLHnrgWe8OAz1jNqCqNHFVFGZPEYQDBqUdYd0YIx1ipp5rc5lBymovL1E1kcJ7l3zfraZCLQoloj3PH3JdG5nQCQOxYrHtjVmo6R4GYPqj+5w5bzoSpieLIXO52oNHl62WribgM2OIalMaS/Hw7KvQAOm2Q8XnN4eIjJd9bBihKVL7YjQx/0VRxr7wQIDAQABAoIBAQCfEQm6UWGkF6HY2lctoBSn2v0J5/r4RYMyqVASKClyWb+EpQ/XQ+7Yr02GCCCaMMD03nSVXu4XKzXwMpeWKwsQ+4yWvNEheRfgt/DMWgw1SYHJOSB+Yx9mI2hfRToueisuBiEFv/1DfsodjSGozByhuGjEhWiQkF3hGLztl25CuU9ZIDryHiVHyZvKMck1Oa+6k5BxjE55gSd70fpgRnBkZ+4in36c05EoJ5bJu6VleAZe5AIOjQz/EZtujqkUvG1Dl4BC+0gI8SZbkV+k5KLheW15K/QN3IjMiWtY4cHLdDbA/5c0JxhsaDpz3iQAL2YecQBGvmwE9M7l9TvqUgYVAoGBANbCOFPIDJ7zr2g4v6TmDBfnHNKgV1J3qf69PbP9K3YdytiSn3baxcduUz4Xe536WnCgAy0LJiq2AZAm0VXqCpamkieboXl/Lqg+w9Vp2ghd8GOwczCmqhaJBWmjwOmzqS9uQ8VU4xP5sXcfkSyTIlYRY04Oq+poH7GE3EZFuf87AoGBANMawgt9b1ExZEra3h+86C4yOs4x9/f8u8ga50M/9Ir0y3RBcGIi98pI9X0nbHAC8AIulWqm1VWtEtHJIH5ATYJPx6j/bV2rTqH2tIpROTZpsR+/ixVsYjvHhU8CklAZXTxcjijy3NmAWgtDmcW97emAjJACxJGKWPC75t5KGzkzAoGBAMMSLenkN5qWTMkFawaUs31uv16OqGLPMUmjiY2ZNEYY76zjGhfyxl3NV6151R59TnMo1Vmv295F7ouKxvEcIrwO14lEs1rR7IaEZIvQl2ysL3PNzgPuD2di1NjNFqjxOYdMyCBRZ+Y4EzvaH5r2luTI7IP1jbDhHZC41wC5yyYLAoGARtVFouFVxqKSCmPiADg8l7OW87TkhTsyLvSIAJKnFTEKS1nhwawGBMPySyo9QmBZ9AF5dS3Bi1vlYqrf0jz1RPJMBjKemb1vRv0mmvqh/dX87rAwlOGnHHPYESjFu0aneCd+M9M5s2lTzU/Deww9lgniIDgtiMApE62Yy6GF/O0CgYA9g/uGHyRBo93hI3+w9sKYQVDuCzC0RyL119dK5AjyH6zyEcP7DdmiPWZ7MEcoLvDWoA5IxCEW+uO9UoiUK17m42Xy/Pw26vyA47R14ik3K7yhnqrvSQ7O5zmW9YYwvEaycROd5WknUmbEJccr/Apro68XTEw7uMbHd6U2IUbCZg==
35ed8688-7c15-4707-8a89-de35318b7da8	6c63042b-05fc-408d-9e2c-3647c612d754	priority	-100
50d59444-c22e-4ee4-9711-0cd25c35fea9	6c63042b-05fc-408d-9e2c-3647c612d754	certificate	MIICmzCCAYMCBgF2x3xlrjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjEwMTAzMDkwMTI3WhcNMzEwMTAzMDkwMzA3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCxGIbvmKbZUl92Ee0rQXCLuJO2CarJv8gFcnQ+pJ9xXm2Gd5tDQVoXQj1RK9ycGQvQfVwoUjowbTuOWyBqeSzk54tI2K5DVwGc1baVIyeldnBui5CUBMYx8li4oL4vsSKLXyMyBYBfup2LxGGiHT1gMtdWUGYseeuBZ7w4DPWM2oKo0cVUUZk8RhAMGpR1h3RgjHWKmnmtzmUHKai8vUTWRwnuXfN+tpkItCiWiPc8fcl0bmdAJA7Fise2NWajpHgZg+qP7nDlvOhKmJ4shc7nag0eXrZauJuAzY4hqUxpL8fDsq9AA6bZDxec3h4iMl31sGKEpUvtiNDH/RVHGvvBAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAD18fOg+ckrRgUuK22XBqFXGIRSU15Y6GdMltcV3NCC9WQjwaLjJMFYLVoPVH9fWIuPk5TssMt18Q1pYR8isnktn3jbBYVYDzPFaPZquZ/Jxmow6q6opEdD4RjzLG80O7/jVhrMjt5dt4/nH10Q1DPzvH0pJpXgp8jIphY4gOODPcVVixmwWDp2eb8hHhPKqydFO3iQCbearTwT3x/9F7pS+TYXzI4/u0bPv27nfzbZGZjIUvqfsWnpYhGkfxtVseOtokrswF//A7vK8RfOc88uwIvz1lRpRiG2Djcgab65zm4ICnbZsRmLy7waWve8g7bEDUMR5nyVcrNTivFe5QGs=
18ecb7e6-da77-4002-8e10-a539244866db	d299dbb5-7dda-4a08-ad46-e9881b0af440	algorithm	HS256
690cf430-e75b-4220-9af1-a14ce5e58ecc	d299dbb5-7dda-4a08-ad46-e9881b0af440	kid	cc1ee824-ae80-474b-9bd9-255b4d5974b7
5085bd1f-e979-4949-a1f3-efd167d1e2dc	d299dbb5-7dda-4a08-ad46-e9881b0af440	priority	-100
c7922145-1de3-4cee-8d09-e60207850116	d299dbb5-7dda-4a08-ad46-e9881b0af440	secret	LjMyJxvVqk3eLp3OtkRX4TfUOEs7z_nWc-zGtFmxdhqy3uJWSYU8vlzo5jMh8eA71a6m910i_FuHx9IdTR3y2A
f1c4564f-09fb-43bc-a031-66a5cee11fbc	24872f9f-1c66-45a5-a7ab-0c8f29215394	certificate	MIICpzCCAY8CBgF2x3xs5TANBgkqhkiG9w0BAQsFADAXMRUwEwYDVQQDDAxyZWFsbS1zYW1wbGUwHhcNMjEwMTAzMDkwMTI5WhcNMzEwMTAzMDkwMzA5WjAXMRUwEwYDVQQDDAxyZWFsbS1zYW1wbGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCLP1JV6sOXNPoOaB+niTR6duaJYimBOKH92cAzeKE+hsLPR2YQnicBCNgBr2/2EsSzuDekIc6wFJaWwcaifWOqBMP1GcpYLfTaRHoNPvVwHNLqCWl/wJAtMNxlGupoDgAgoREFtskeY/s5Fak8KukyxuzQGPHqKF3q3LFdWRHx/GY6P6CDXEcMN8TNvgu/3JANDPa/ITPaCp3MgokqmW64u7gNnkqEtQ9IX8mBlrjD2KcuY6XLvWQWkwf6fQZLikcBw+HVpK+RnsWLeFec4BOjg5YdbvDqBOdfSdLBEQDy5YJupcdu6MQtKjAa5C5ZQRcW7u5bgevE9jI/RNaqB0vpAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEdwbamha6+GiyFc6QNhuaBnoVNhWjuYlyCGGgOX56eWzVcUJ3xQziwNwaseQzf4IfvLkJ0e59hgEbbgcNZwWcEFtoBjLHh0geciyhUaEiu6jxtvm1bSwL0GQ1hUoMRQiw2wrdvBFrnxSWlVRo32s9ddh1RDpufs8mmj2BI4KNO2iSdwuFkKuPKxnFVPCp7QU6RfooeBGP8Yn+HNuTz8yBaKUZlVbqbi5GFmrvbRF7XFQXOinsAKbnTfKiRzTb+uZqsMFAX5Fm0kh54KxMuBVr10NZpZtOLSovgBzqzN40E2oKyjxw5olt1jF8DoCvyzl6Ok14EkfUPirSYUcb06GU8=
e62fc0a8-1f72-4b16-b8c6-73cf1a074396	24872f9f-1c66-45a5-a7ab-0c8f29215394	priority	100
97b13eb6-956f-4bd6-997d-36cbc5cdd91b	24872f9f-1c66-45a5-a7ab-0c8f29215394	privateKey	MIIEogIBAAKCAQEAiz9SVerDlzT6Dmgfp4k0enbmiWIpgTih/dnAM3ihPobCz0dmEJ4nAQjYAa9v9hLEs7g3pCHOsBSWlsHGon1jqgTD9RnKWC302kR6DT71cBzS6glpf8CQLTDcZRrqaA4AIKERBbbJHmP7ORWpPCrpMsbs0Bjx6ihd6tyxXVkR8fxmOj+gg1xHDDfEzb4Lv9yQDQz2vyEz2gqdzIKJKpluuLu4DZ5KhLUPSF/JgZa4w9inLmOly71kFpMH+n0GS4pHAcPh1aSvkZ7Fi3hXnOATo4OWHW7w6gTnX0nSwREA8uWCbqXHbujELSowGuQuWUEXFu7uW4HrxPYyP0TWqgdL6QIDAQABAoIBADTgs+yKfQHTjU2hPrwJP1NuCXeMPkSi8+kJIpKpMVokJKA/9cNDu34KFLT3ISYp1GaHAyIh8HIvL0xKg5q60PkEXEGcLJm1wfCM5mhXSy7q0zEqp9RqlJWEo30FbpRbFLNPVr57vf37a7AuyJhflzTAE7emcV9BOwDwE65mH4lrgKUMGEKAFiIS/GgSY9Yg+d38sWcqPQzINfzAwex7LpGJwObveWmcW/Act60dzLvKP+gp086OFS2qNeAjmdDR5784reacyAwH+OWWmVV8Iq5DCIDwMaU0L9drumPCWhX+KIzI5FK5PG2Cct8HmasBBj8zt7jZ767Ksa5uQY3eRIECgYEA/ttGP7xtrXemQ3GKV9vye9yIlBaydaQlrn6WkYuk5WKoIOkXHa8Y0lyYVV9z/IBv/okoMAOV8N2zdTgp8bfXjiiHfGXQc66gtD8y1NTnNxhPkpYQ0XJCSx9VGXi3I46aM0f4sE1D1AZYCV7XngDfwU41vVaq3rp2Hp7w9wB2SRkCgYEAi99CeyKfThtPWRE/Efm75H3N2PbhjwQQVfwLOzNjZL1hZziaeBGnqR6rgeX8U8G6JsjThpDDMLucVc7ZPMBtOyAwEl7RhZTAz+6JL79ory0dlNNolqyFd4qWwjItDvV3CA/LX2iF1IZVEEjV4kqhXa6Iy1dh5H6UW1UH+EQx41ECgYB/yLokYvorK/71egx/mQywBheFCQxZ5//syhP8ziPTz++08Kpie9TaRQssYzvosw10dpjr2iBoMQE2GP8O77ro0HF+ch5eooR5W+bEyCtWeJ4NRakRG1UaDY/BwcEx1uKCK+gJnfQQb03dBOzfkFigt/JCCR6LprprCA6SCm1EoQKBgH8P9uXDQvKCbqebui7LLfvYqPny9F6mM2zZBR7nhOBMBcLuMaznZOaGXQko8vrnXwLCpx10Pkzz8YYl3USKDfCLQgA+MJnn0uxRZkCA4klYc6nyDu3plWlN9bw+Np6DMHmbV4W5fvHcgkPD1sC2STbASbZnEB+xOXZqnU3ULXmxAoGALClwXx21p0LiupaSozCm9e0QVxEjBgFASaQkPk18mY8Xv8NVYVBooPO8HRNXzpAjqoYZzNmeuGq/EXQrNDvJ71BZeGNmFteNdUmHWzg0/uEzMgQKGfyyVOZQoQbX3Q3qzHfu1umw+ters+8Aitrsj+8MRL7bRdwwLa4TccpaCb0=
90bba6d1-e2f3-4dd2-b970-50d129bd8d07	2d6b7dc9-ab4c-4fc3-95d7-4a9bede4bcda	secret	A2J-NB9flsoibhfRkw-gA_MTb1LiS7XgZ4XdPKn1Rlvyeqf6kgw25KQATdRk_XBemEkD1BaJkYCRbPtDae_Agg
e08e015a-651e-4644-9699-4eb22ae6f194	2d6b7dc9-ab4c-4fc3-95d7-4a9bede4bcda	algorithm	HS256
78e86107-b3d7-411c-a360-98bc7c38f1d6	2d6b7dc9-ab4c-4fc3-95d7-4a9bede4bcda	priority	100
71d78a7b-7cde-4e8b-9a16-00406c90f2dd	2d6b7dc9-ab4c-4fc3-95d7-4a9bede4bcda	kid	a7149f02-33e9-47c4-99a6-ab5a53e8248a
b3696435-3811-4671-87e5-bcf393ae2835	0b306480-8871-4ab7-8687-f68d8a858e14	priority	100
3be05f05-5309-4fc7-b9fb-eea71b421c79	0b306480-8871-4ab7-8687-f68d8a858e14	kid	886596c6-3f33-4e16-9913-e3804569c7ee
2dc66c2d-e160-4488-9975-3d39a5443a74	0b306480-8871-4ab7-8687-f68d8a858e14	secret	JOw9koqRBJC-v2N-NqDIJQ
09d39878-272f-4546-b995-f7f6a9505ed1	a40ad885-a746-479a-bcc6-0cc956d989ba	allow-default-scopes	true
235e5863-3c34-4a0d-bcc5-53115f18d1b1	b5d9ed75-8c66-48b9-a417-cfe97841d8d2	allowed-protocol-mapper-types	oidc-full-name-mapper
20303199-b573-4995-9316-ae9df8aeeff0	b5d9ed75-8c66-48b9-a417-cfe97841d8d2	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
2fe0309a-b635-4ac0-a94f-78f613589b22	b5d9ed75-8c66-48b9-a417-cfe97841d8d2	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
2d05dbb0-4915-4e4e-8cb4-b1533d89686d	b5d9ed75-8c66-48b9-a417-cfe97841d8d2	allowed-protocol-mapper-types	oidc-address-mapper
a5cca76c-87ff-4e47-aa9d-561f8c77a615	b5d9ed75-8c66-48b9-a417-cfe97841d8d2	allowed-protocol-mapper-types	saml-user-attribute-mapper
852dda0d-c209-429f-907f-1c2a202f18eb	b5d9ed75-8c66-48b9-a417-cfe97841d8d2	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
86e58244-d19f-4bcd-9c86-321f97b2463d	b5d9ed75-8c66-48b9-a417-cfe97841d8d2	allowed-protocol-mapper-types	saml-user-property-mapper
03b58a50-010f-4f11-bfe5-f943bd7eddea	b5d9ed75-8c66-48b9-a417-cfe97841d8d2	allowed-protocol-mapper-types	saml-role-list-mapper
e3cdd2e3-9e10-49fb-8069-9efcb1f5e5a7	5fff6108-ec39-49f6-ad4b-ea8f6411cd6b	host-sending-registration-request-must-match	true
4388387d-0d3f-46bb-ad82-00883e658819	5fff6108-ec39-49f6-ad4b-ea8f6411cd6b	client-uris-must-match	true
e45da8fe-a800-4e52-bbab-6e18fda399c6	43c8accc-a462-4668-8d2b-f078ec62ab6c	max-clients	200
ff1045a2-87f3-4638-ad8b-6ce2085e2a97	53d08211-8ec6-4a16-b9dc-bbae50e9756d	allow-default-scopes	true
56349d09-b213-401a-a0f3-90f8c47073ff	72210737-5ff0-457c-9724-15b534d0434c	allowed-protocol-mapper-types	saml-user-property-mapper
7f9ddfaf-0f52-4162-99cf-ad25881b6adb	72210737-5ff0-457c-9724-15b534d0434c	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
28850f05-0f2b-4fbc-87ad-4e747c141237	72210737-5ff0-457c-9724-15b534d0434c	allowed-protocol-mapper-types	oidc-address-mapper
84b44e00-7b19-44f5-8a13-4081dddd578c	72210737-5ff0-457c-9724-15b534d0434c	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
96aa4329-92f5-48ac-9943-b4ad42fd9195	72210737-5ff0-457c-9724-15b534d0434c	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b523f29e-331e-438d-a6b1-def2a26986a2	72210737-5ff0-457c-9724-15b534d0434c	allowed-protocol-mapper-types	saml-role-list-mapper
7d61e6ce-a48b-42f9-b588-1443f50c613d	72210737-5ff0-457c-9724-15b534d0434c	allowed-protocol-mapper-types	oidc-full-name-mapper
bb4dfd05-8836-4517-9715-9822b29168f0	72210737-5ff0-457c-9724-15b534d0434c	allowed-protocol-mapper-types	saml-user-attribute-mapper
\.


--
-- TOC entry 3814 (class 0 OID 81989)
-- Dependencies: 212
-- Data for Name: composite_role; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.composite_role (composite, child_role) FROM stdin;
8683c126-2702-4da9-bc75-f205e1201585	3c12dc81-877e-495e-bffc-83d011358e37
8683c126-2702-4da9-bc75-f205e1201585	a7328571-b519-4773-88b7-2dc23d937c03
8683c126-2702-4da9-bc75-f205e1201585	46435a60-2205-4af6-98fe-42f33799b479
8683c126-2702-4da9-bc75-f205e1201585	5d1fca33-2c56-45d4-9cfb-a48a3e5a26df
8683c126-2702-4da9-bc75-f205e1201585	0548086f-a600-4d68-b213-b591bab57559
8683c126-2702-4da9-bc75-f205e1201585	f98d9199-e622-4caf-b01a-b8219749f9db
8683c126-2702-4da9-bc75-f205e1201585	d01cd3fd-ad8b-4634-85de-00d741b080e4
8683c126-2702-4da9-bc75-f205e1201585	39cb834e-b2c6-48c1-9196-83cc8270dd10
8683c126-2702-4da9-bc75-f205e1201585	c09d5123-ec81-4a68-8d4a-e25058a586cc
8683c126-2702-4da9-bc75-f205e1201585	9513d208-040b-4ba8-9646-2a8f36d44da4
8683c126-2702-4da9-bc75-f205e1201585	7a84d725-2ac5-4cd4-a58e-03b70b346d0b
8683c126-2702-4da9-bc75-f205e1201585	a4104c46-d9ce-4d08-961b-939540a77ac9
8683c126-2702-4da9-bc75-f205e1201585	288ff3de-8c65-435d-9c5c-5f173cf76adf
8683c126-2702-4da9-bc75-f205e1201585	f17b7db7-6b01-4402-ac7c-de0b389a8913
8683c126-2702-4da9-bc75-f205e1201585	23b86386-113c-42b0-95d9-874ebc0ecbea
8683c126-2702-4da9-bc75-f205e1201585	b3896a1e-20be-444a-bc87-4d08a47da955
8683c126-2702-4da9-bc75-f205e1201585	03da4414-2dd2-415e-8395-b93b60981141
8683c126-2702-4da9-bc75-f205e1201585	2b19085e-6bed-463c-9a76-4e22215aac15
0548086f-a600-4d68-b213-b591bab57559	b3896a1e-20be-444a-bc87-4d08a47da955
5d1fca33-2c56-45d4-9cfb-a48a3e5a26df	2b19085e-6bed-463c-9a76-4e22215aac15
5d1fca33-2c56-45d4-9cfb-a48a3e5a26df	23b86386-113c-42b0-95d9-874ebc0ecbea
6b34fc9f-2cfc-4c1f-9f99-c2314742f37d	e77ce48c-1085-4603-af1c-3beb7133a33c
6bd3a9ab-c994-4f73-a9d6-fe70514feb56	cde24067-c1ff-4abf-acd3-136bcaa8bb07
8683c126-2702-4da9-bc75-f205e1201585	2967b296-1d83-4489-931a-cab09020c3b3
8683c126-2702-4da9-bc75-f205e1201585	44ab7770-8a2d-4026-bc00-08b8e554c341
8683c126-2702-4da9-bc75-f205e1201585	529dfc69-4fd3-4025-a9dc-6338dec64fbf
8683c126-2702-4da9-bc75-f205e1201585	5bd2447e-e092-4a20-9297-de2c7777d0d9
8683c126-2702-4da9-bc75-f205e1201585	1345f307-fe63-4c45-9111-226f6d3c6047
8683c126-2702-4da9-bc75-f205e1201585	f187aa56-875b-4768-9750-8fdd1e653f7a
8683c126-2702-4da9-bc75-f205e1201585	c40f32a4-d640-4027-983c-4e09ae130f5a
8683c126-2702-4da9-bc75-f205e1201585	db536739-1e16-454f-a995-7a707abcfbe8
8683c126-2702-4da9-bc75-f205e1201585	3bae7601-8375-417f-a0cb-1e696fbc6bbd
8683c126-2702-4da9-bc75-f205e1201585	53ef1aaf-d94e-4441-bfde-2fe108bad3aa
8683c126-2702-4da9-bc75-f205e1201585	11bdc0f6-dcee-4f17-b11b-777135d8029c
8683c126-2702-4da9-bc75-f205e1201585	414ba225-93cf-42c1-ac92-b20b8c2c698e
8683c126-2702-4da9-bc75-f205e1201585	0d7e0685-fe6d-4a3e-be0b-fd634bd6d03d
8683c126-2702-4da9-bc75-f205e1201585	e96feb4e-42cf-4cd6-9a43-196a8f46408f
8683c126-2702-4da9-bc75-f205e1201585	8aac98e4-50dc-40c5-b31e-e80e4c13dfc8
8683c126-2702-4da9-bc75-f205e1201585	fb7a1f24-60bc-4940-843a-e737301f397c
8683c126-2702-4da9-bc75-f205e1201585	dbf0e4a4-0dcd-4edd-813b-da72d85d78b9
8683c126-2702-4da9-bc75-f205e1201585	05a0bb50-c2ff-446c-8b4c-7b5bf8c4090e
1345f307-fe63-4c45-9111-226f6d3c6047	fb7a1f24-60bc-4940-843a-e737301f397c
5bd2447e-e092-4a20-9297-de2c7777d0d9	8aac98e4-50dc-40c5-b31e-e80e4c13dfc8
5bd2447e-e092-4a20-9297-de2c7777d0d9	05a0bb50-c2ff-446c-8b4c-7b5bf8c4090e
cace0afd-4041-49aa-8e39-65ac35383b6e	9b2f2712-027e-43b3-8787-749c24bcf0cd
cace0afd-4041-49aa-8e39-65ac35383b6e	8a619745-e92e-493b-878b-49d059503b6d
cace0afd-4041-49aa-8e39-65ac35383b6e	db2629b6-697a-42f6-b4a5-1d7b1505e651
cace0afd-4041-49aa-8e39-65ac35383b6e	fe95c4c7-113a-49ee-bdc6-a8ee1636e167
cace0afd-4041-49aa-8e39-65ac35383b6e	ca24ea7b-ebee-4234-b0df-45642b035fc7
cace0afd-4041-49aa-8e39-65ac35383b6e	f00fcfb3-fdc5-4cfa-a088-3784d7a7cb4b
cace0afd-4041-49aa-8e39-65ac35383b6e	7df2380d-ad66-4a14-8464-87f7e68e072b
cace0afd-4041-49aa-8e39-65ac35383b6e	adbc4b9d-fa90-4c2f-9afc-479a07f85ace
cace0afd-4041-49aa-8e39-65ac35383b6e	6098434a-58f2-4681-b7ba-b2c0ab2e9508
cace0afd-4041-49aa-8e39-65ac35383b6e	b331df83-c8a9-411b-94e9-bdb5b5966045
cace0afd-4041-49aa-8e39-65ac35383b6e	bda710c8-ed81-4295-b978-9786e535b2c2
cace0afd-4041-49aa-8e39-65ac35383b6e	ba9476af-cb72-4d0b-9dab-a49ca24f7850
cace0afd-4041-49aa-8e39-65ac35383b6e	92a37819-4bf4-4083-be29-b088646cd1b5
cace0afd-4041-49aa-8e39-65ac35383b6e	54962904-6845-4c41-9623-78447c2ebbdf
cace0afd-4041-49aa-8e39-65ac35383b6e	f9f698eb-4439-46fa-8ea6-c3cc4f4e526a
cace0afd-4041-49aa-8e39-65ac35383b6e	b77ee27c-d30c-4c57-99c8-d9cd5baf70e0
cace0afd-4041-49aa-8e39-65ac35383b6e	836ca232-837b-4a37-9c6f-5d59006e6d41
fe95c4c7-113a-49ee-bdc6-a8ee1636e167	f9f698eb-4439-46fa-8ea6-c3cc4f4e526a
db2629b6-697a-42f6-b4a5-1d7b1505e651	54962904-6845-4c41-9623-78447c2ebbdf
db2629b6-697a-42f6-b4a5-1d7b1505e651	836ca232-837b-4a37-9c6f-5d59006e6d41
ecb7c80e-3a4c-4f97-b56e-900f697d9195	56ce60ea-40a3-4a47-9b3a-bef255ab1bd7
82ffd582-e547-4e2c-860d-0b8c1fad4029	c87819a4-e357-4d65-a97f-7ac6b4d346b6
8683c126-2702-4da9-bc75-f205e1201585	49ae5102-4888-436f-ae1b-80281ed8affc
cace0afd-4041-49aa-8e39-65ac35383b6e	e464824f-9284-486d-b528-1a5c7fbf843a
\.


--
-- TOC entry 3815 (class 0 OID 81992)
-- Dependencies: 213
-- Data for Name: credential; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
1b1589cd-762b-403a-998f-1a0b6d237841	\N	password	eebbe7fa-13c8-485f-b5ad-17906528e47b	1609664564668	\N	{"value":"lADrlSLD+zXtPSFDQrrNqMGD9iT67uYhULuAeBGYBYouGRNjRbYqdrURb253WukrNg5/eeuboz5uiXmzDKEfoQ==","salt":"kkMTxwQsaD6cW+TixyhSRg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
d04741a1-f613-4994-bacc-1de279ecbcd5	\N	password	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b	1609664611893	\N	{"value":"7sjno9rcIR0y4O5QccrBxld93FjSn+cvGEKacNwUnnYJjwzTBlnB1jkvHF3ykHPG+ruxrpHdtwU3NSPInCx4zQ==","salt":"jke1umZhP/Ve538u3H/Y6A==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- TOC entry 3809 (class 0 OID 81959)
-- Dependencies: 207
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2021-01-03 09:02:39.86794	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	9664559533
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2021-01-03 09:02:39.8782	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	9664559533
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2021-01-03 09:02:39.918347	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	9664559533
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2021-01-03 09:02:39.924023	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	9664559533
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2021-01-03 09:02:40.032006	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	9664559533
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2021-01-03 09:02:40.036959	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	9664559533
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2021-01-03 09:02:40.123405	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	9664559533
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2021-01-03 09:02:40.127633	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	9664559533
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2021-01-03 09:02:40.132953	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	9664559533
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2021-01-03 09:02:40.234674	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	9664559533
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2021-01-03 09:02:40.29026	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	9664559533
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2021-01-03 09:02:40.293809	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	9664559533
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2021-01-03 09:02:40.309949	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	9664559533
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-01-03 09:02:40.333967	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	9664559533
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-01-03 09:02:40.336948	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	9664559533
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-01-03 09:02:40.339767	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	9664559533
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-01-03 09:02:40.342528	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	9664559533
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2021-01-03 09:02:40.39175	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	9664559533
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2021-01-03 09:02:40.434648	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	9664559533
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2021-01-03 09:02:40.440059	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	9664559533
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-01-03 09:02:41.014191	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	9664559533
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2021-01-03 09:02:40.442847	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	9664559533
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2021-01-03 09:02:40.445749	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	9664559533
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2021-01-03 09:02:40.46296	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	9664559533
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2021-01-03 09:02:40.468362	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	9664559533
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2021-01-03 09:02:40.470677	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	9664559533
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2021-01-03 09:02:40.521673	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	9664559533
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2021-01-03 09:02:40.610515	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	9664559533
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2021-01-03 09:02:40.614588	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	9664559533
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2021-01-03 09:02:40.695802	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	9664559533
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2021-01-03 09:02:40.710854	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	9664559533
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2021-01-03 09:02:40.728654	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	9664559533
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2021-01-03 09:02:40.733134	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	9664559533
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-01-03 09:02:40.739283	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	9664559533
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-01-03 09:02:40.742021	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	9664559533
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-01-03 09:02:40.771591	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	9664559533
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2021-01-03 09:02:40.777064	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	9664559533
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-01-03 09:02:40.785452	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	9664559533
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2021-01-03 09:02:40.789964	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	9664559533
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2021-01-03 09:02:40.794402	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	9664559533
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-01-03 09:02:40.796758	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	9664559533
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-01-03 09:02:40.799093	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	9664559533
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2021-01-03 09:02:40.803681	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	9664559533
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-01-03 09:02:41.002175	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	9664559533
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2021-01-03 09:02:41.008275	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	9664559533
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-01-03 09:02:41.018613	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	9664559533
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-01-03 09:02:41.021089	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	9664559533
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-01-03 09:02:41.067738	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	9664559533
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-01-03 09:02:41.074075	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	9664559533
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2021-01-03 09:02:41.137335	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	9664559533
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2021-01-03 09:02:41.188294	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	9664559533
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2021-01-03 09:02:41.19316	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	9664559533
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2021-01-03 09:02:41.196253	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	9664559533
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2021-01-03 09:02:41.199269	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	9664559533
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-01-03 09:02:41.208772	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	9664559533
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-01-03 09:02:41.214827	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	9664559533
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-01-03 09:02:41.239907	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	9664559533
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-01-03 09:02:41.365191	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	9664559533
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2021-01-03 09:02:41.405396	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	9664559533
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2021-01-03 09:02:41.411122	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	9664559533
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-01-03 09:02:41.41864	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	9664559533
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-01-03 09:02:41.434826	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	9664559533
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2021-01-03 09:02:41.445983	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	9664559533
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2021-01-03 09:02:41.450147	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	9664559533
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2021-01-03 09:02:41.454409	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	9664559533
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2021-01-03 09:02:41.475758	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	9664559533
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2021-01-03 09:02:41.484007	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	9664559533
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2021-01-03 09:02:41.489705	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	9664559533
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2021-01-03 09:02:41.500964	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	9664559533
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2021-01-03 09:02:41.506943	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	9664559533
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2021-01-03 09:02:41.51166	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	9664559533
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-01-03 09:02:41.518473	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	9664559533
8.0.0-updating-credential-data-not-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-01-03 09:02:41.523893	73	EXECUTED	7:03b3f4b264c3c68ba082250a80b74216	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	9664559533
8.0.0-updating-credential-data-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-01-03 09:02:41.526161	74	MARK_RAN	7:64c5728f5ca1f5aa4392217701c4fe23	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	9664559533
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-01-03 09:02:41.540514	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	9664559533
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-01-03 09:02:41.550701	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	9664559533
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-01-03 09:02:41.555695	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	9664559533
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-01-03 09:02:41.558197	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	9664559533
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-01-03 09:02:41.576859	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	9664559533
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-01-03 09:02:41.579537	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	9664559533
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-01-03 09:02:41.587963	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	9664559533
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-01-03 09:02:41.590481	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	9664559533
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-01-03 09:02:41.595353	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	9664559533
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-01-03 09:02:41.597561	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	9664559533
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-01-03 09:02:41.606618	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	9664559533
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2021-01-03 09:02:41.612084	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	9664559533
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-01-03 09:02:41.618934	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	9664559533
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-01-03 09:02:41.631256	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	9664559533
\.


--
-- TOC entry 3808 (class 0 OID 81954)
-- Dependencies: 206
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- TOC entry 3894 (class 0 OID 83408)
-- Dependencies: 292
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	58e411ab-24d6-4256-9b04-dc94bb9a3e63	f
master	542c39e4-a0ae-467c-a11a-119d40d9cf91	t
master	ab19a893-0b5d-41d6-9649-6269cfd8fc74	t
master	1f5b66a8-fcbe-44f1-a146-a68a486fcf55	t
master	6a8b58fa-b075-45d5-9db0-1850e42dc2df	f
master	dc4edb03-85e7-44e4-ba52-308e9cefa7b3	f
master	452dd164-f028-4c1d-9434-b06ec6ae0e2b	t
master	8b37700b-1792-4c4d-ae96-88d9f3b7f80f	t
master	9656cdb9-7432-4e0b-9744-06e6c6dfd779	f
cd0a239f-f540-49da-a4c3-8f57fd497cb4	8384725d-0ea5-4e60-8280-670410eedd6f	f
cd0a239f-f540-49da-a4c3-8f57fd497cb4	5c16a285-19ef-4c28-931d-24e037796c6b	t
cd0a239f-f540-49da-a4c3-8f57fd497cb4	d14f82e5-c666-49fb-900f-035e859723ed	t
cd0a239f-f540-49da-a4c3-8f57fd497cb4	911a036a-a3eb-459d-8712-5a8add44d451	t
cd0a239f-f540-49da-a4c3-8f57fd497cb4	7cae1885-591f-462e-862d-d2cda2435a65	f
cd0a239f-f540-49da-a4c3-8f57fd497cb4	01bd033a-edf5-4f61-b352-8b0efe58ee41	f
cd0a239f-f540-49da-a4c3-8f57fd497cb4	5496757b-0678-41fd-a53b-fcd1f720bb9c	t
cd0a239f-f540-49da-a4c3-8f57fd497cb4	a70675d8-0782-41dd-b771-92ea720a4230	t
cd0a239f-f540-49da-a4c3-8f57fd497cb4	e9d72e1c-f971-4c85-b094-bb7c804cddb1	f
\.


--
-- TOC entry 3816 (class 0 OID 81998)
-- Dependencies: 214
-- Data for Name: event_entity; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- TOC entry 3882 (class 0 OID 83097)
-- Dependencies: 280
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- TOC entry 3883 (class 0 OID 83103)
-- Dependencies: 281
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 3896 (class 0 OID 83434)
-- Dependencies: 294
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 3884 (class 0 OID 83112)
-- Dependencies: 282
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- TOC entry 3885 (class 0 OID 83122)
-- Dependencies: 283
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 3886 (class 0 OID 83125)
-- Dependencies: 284
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 3887 (class 0 OID 83132)
-- Dependencies: 285
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 3840 (class 0 OID 82392)
-- Dependencies: 238
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 3890 (class 0 OID 83201)
-- Dependencies: 288
-- Data for Name: federated_user; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- TOC entry 3866 (class 0 OID 82811)
-- Dependencies: 264
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- TOC entry 3865 (class 0 OID 82808)
-- Dependencies: 263
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- TOC entry 3841 (class 0 OID 82398)
-- Dependencies: 239
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- TOC entry 3842 (class 0 OID 82408)
-- Dependencies: 240
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 3847 (class 0 OID 82514)
-- Dependencies: 245
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- TOC entry 3848 (class 0 OID 82520)
-- Dependencies: 246
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 3864 (class 0 OID 82805)
-- Dependencies: 262
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- TOC entry 3817 (class 0 OID 82007)
-- Dependencies: 215
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
8683c126-2702-4da9-bc75-f205e1201585	master	f	${role_admin}	admin	master	\N	master
3c12dc81-877e-495e-bffc-83d011358e37	master	f	${role_create-realm}	create-realm	master	\N	master
a7328571-b519-4773-88b7-2dc23d937c03	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_create-client}	create-client	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
46435a60-2205-4af6-98fe-42f33799b479	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_view-realm}	view-realm	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
5d1fca33-2c56-45d4-9cfb-a48a3e5a26df	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_view-users}	view-users	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
0548086f-a600-4d68-b213-b591bab57559	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_view-clients}	view-clients	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
f98d9199-e622-4caf-b01a-b8219749f9db	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_view-events}	view-events	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
d01cd3fd-ad8b-4634-85de-00d741b080e4	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_view-identity-providers}	view-identity-providers	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
39cb834e-b2c6-48c1-9196-83cc8270dd10	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_view-authorization}	view-authorization	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
c09d5123-ec81-4a68-8d4a-e25058a586cc	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_manage-realm}	manage-realm	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
9513d208-040b-4ba8-9646-2a8f36d44da4	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_manage-users}	manage-users	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
7a84d725-2ac5-4cd4-a58e-03b70b346d0b	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_manage-clients}	manage-clients	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
a4104c46-d9ce-4d08-961b-939540a77ac9	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_manage-events}	manage-events	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
288ff3de-8c65-435d-9c5c-5f173cf76adf	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_manage-identity-providers}	manage-identity-providers	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
f17b7db7-6b01-4402-ac7c-de0b389a8913	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_manage-authorization}	manage-authorization	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
23b86386-113c-42b0-95d9-874ebc0ecbea	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_query-users}	query-users	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
b3896a1e-20be-444a-bc87-4d08a47da955	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_query-clients}	query-clients	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
03da4414-2dd2-415e-8395-b93b60981141	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_query-realms}	query-realms	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
2b19085e-6bed-463c-9a76-4e22215aac15	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_query-groups}	query-groups	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
ecee88a7-b0cb-40a1-bc3b-dee2d680d51a	1134a440-e17e-4235-9205-fdc3ab98150a	t	${role_view-profile}	view-profile	master	1134a440-e17e-4235-9205-fdc3ab98150a	\N
6b34fc9f-2cfc-4c1f-9f99-c2314742f37d	1134a440-e17e-4235-9205-fdc3ab98150a	t	${role_manage-account}	manage-account	master	1134a440-e17e-4235-9205-fdc3ab98150a	\N
e77ce48c-1085-4603-af1c-3beb7133a33c	1134a440-e17e-4235-9205-fdc3ab98150a	t	${role_manage-account-links}	manage-account-links	master	1134a440-e17e-4235-9205-fdc3ab98150a	\N
c323aee6-8f84-49e5-a49a-ae67dd1a68fe	1134a440-e17e-4235-9205-fdc3ab98150a	t	${role_view-applications}	view-applications	master	1134a440-e17e-4235-9205-fdc3ab98150a	\N
cde24067-c1ff-4abf-acd3-136bcaa8bb07	1134a440-e17e-4235-9205-fdc3ab98150a	t	${role_view-consent}	view-consent	master	1134a440-e17e-4235-9205-fdc3ab98150a	\N
6bd3a9ab-c994-4f73-a9d6-fe70514feb56	1134a440-e17e-4235-9205-fdc3ab98150a	t	${role_manage-consent}	manage-consent	master	1134a440-e17e-4235-9205-fdc3ab98150a	\N
8f59e777-7f62-4f31-bb29-975a813aceee	1134a440-e17e-4235-9205-fdc3ab98150a	t	${role_delete-account}	delete-account	master	1134a440-e17e-4235-9205-fdc3ab98150a	\N
416a7855-b762-45cf-8b12-50bfca27a88d	d603acc4-8910-4208-b574-042cc8f90e7a	t	${role_read-token}	read-token	master	d603acc4-8910-4208-b574-042cc8f90e7a	\N
2967b296-1d83-4489-931a-cab09020c3b3	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	t	${role_impersonation}	impersonation	master	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	\N
d01a17e2-11c6-44a1-b36e-f79593346796	master	f	${role_offline-access}	offline_access	master	\N	master
19bdd7e5-17b4-4e91-ad47-17496a9ecb8a	master	f	${role_uma_authorization}	uma_authorization	master	\N	master
44ab7770-8a2d-4026-bc00-08b8e554c341	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_create-client}	create-client	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
529dfc69-4fd3-4025-a9dc-6338dec64fbf	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_view-realm}	view-realm	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
5bd2447e-e092-4a20-9297-de2c7777d0d9	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_view-users}	view-users	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
1345f307-fe63-4c45-9111-226f6d3c6047	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_view-clients}	view-clients	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
f187aa56-875b-4768-9750-8fdd1e653f7a	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_view-events}	view-events	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
c40f32a4-d640-4027-983c-4e09ae130f5a	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_view-identity-providers}	view-identity-providers	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
db536739-1e16-454f-a995-7a707abcfbe8	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_view-authorization}	view-authorization	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
3bae7601-8375-417f-a0cb-1e696fbc6bbd	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_manage-realm}	manage-realm	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
53ef1aaf-d94e-4441-bfde-2fe108bad3aa	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_manage-users}	manage-users	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
11bdc0f6-dcee-4f17-b11b-777135d8029c	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_manage-clients}	manage-clients	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
414ba225-93cf-42c1-ac92-b20b8c2c698e	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_manage-events}	manage-events	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
0d7e0685-fe6d-4a3e-be0b-fd634bd6d03d	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_manage-identity-providers}	manage-identity-providers	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
e96feb4e-42cf-4cd6-9a43-196a8f46408f	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_manage-authorization}	manage-authorization	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
8aac98e4-50dc-40c5-b31e-e80e4c13dfc8	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_query-users}	query-users	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
fb7a1f24-60bc-4940-843a-e737301f397c	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_query-clients}	query-clients	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
dbf0e4a4-0dcd-4edd-813b-da72d85d78b9	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_query-realms}	query-realms	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
05a0bb50-c2ff-446c-8b4c-7b5bf8c4090e	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_query-groups}	query-groups	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
cace0afd-4041-49aa-8e39-65ac35383b6e	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_realm-admin}	realm-admin	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
9b2f2712-027e-43b3-8787-749c24bcf0cd	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_create-client}	create-client	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
8a619745-e92e-493b-878b-49d059503b6d	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_view-realm}	view-realm	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
db2629b6-697a-42f6-b4a5-1d7b1505e651	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_view-users}	view-users	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
fe95c4c7-113a-49ee-bdc6-a8ee1636e167	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_view-clients}	view-clients	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
ca24ea7b-ebee-4234-b0df-45642b035fc7	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_view-events}	view-events	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
f00fcfb3-fdc5-4cfa-a088-3784d7a7cb4b	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_view-identity-providers}	view-identity-providers	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
7df2380d-ad66-4a14-8464-87f7e68e072b	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_view-authorization}	view-authorization	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
adbc4b9d-fa90-4c2f-9afc-479a07f85ace	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_manage-realm}	manage-realm	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
6098434a-58f2-4681-b7ba-b2c0ab2e9508	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_manage-users}	manage-users	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
b331df83-c8a9-411b-94e9-bdb5b5966045	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_manage-clients}	manage-clients	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
bda710c8-ed81-4295-b978-9786e535b2c2	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_manage-events}	manage-events	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
ba9476af-cb72-4d0b-9dab-a49ca24f7850	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_manage-identity-providers}	manage-identity-providers	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
92a37819-4bf4-4083-be29-b088646cd1b5	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_manage-authorization}	manage-authorization	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
54962904-6845-4c41-9623-78447c2ebbdf	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_query-users}	query-users	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
f9f698eb-4439-46fa-8ea6-c3cc4f4e526a	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_query-clients}	query-clients	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
b77ee27c-d30c-4c57-99c8-d9cd5baf70e0	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_query-realms}	query-realms	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
836ca232-837b-4a37-9c6f-5d59006e6d41	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_query-groups}	query-groups	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
2bd10fb2-e2a1-4695-955c-bce0bb624e93	417353a9-b424-43ad-96cd-0d651fc3f184	t	${role_view-profile}	view-profile	cd0a239f-f540-49da-a4c3-8f57fd497cb4	417353a9-b424-43ad-96cd-0d651fc3f184	\N
ecb7c80e-3a4c-4f97-b56e-900f697d9195	417353a9-b424-43ad-96cd-0d651fc3f184	t	${role_manage-account}	manage-account	cd0a239f-f540-49da-a4c3-8f57fd497cb4	417353a9-b424-43ad-96cd-0d651fc3f184	\N
56ce60ea-40a3-4a47-9b3a-bef255ab1bd7	417353a9-b424-43ad-96cd-0d651fc3f184	t	${role_manage-account-links}	manage-account-links	cd0a239f-f540-49da-a4c3-8f57fd497cb4	417353a9-b424-43ad-96cd-0d651fc3f184	\N
140a0b58-2a1a-484b-82a5-8e45ab76c24c	417353a9-b424-43ad-96cd-0d651fc3f184	t	${role_view-applications}	view-applications	cd0a239f-f540-49da-a4c3-8f57fd497cb4	417353a9-b424-43ad-96cd-0d651fc3f184	\N
c87819a4-e357-4d65-a97f-7ac6b4d346b6	417353a9-b424-43ad-96cd-0d651fc3f184	t	${role_view-consent}	view-consent	cd0a239f-f540-49da-a4c3-8f57fd497cb4	417353a9-b424-43ad-96cd-0d651fc3f184	\N
82ffd582-e547-4e2c-860d-0b8c1fad4029	417353a9-b424-43ad-96cd-0d651fc3f184	t	${role_manage-consent}	manage-consent	cd0a239f-f540-49da-a4c3-8f57fd497cb4	417353a9-b424-43ad-96cd-0d651fc3f184	\N
ca7b758b-0065-4dff-9bc4-9c7b511df574	417353a9-b424-43ad-96cd-0d651fc3f184	t	${role_delete-account}	delete-account	cd0a239f-f540-49da-a4c3-8f57fd497cb4	417353a9-b424-43ad-96cd-0d651fc3f184	\N
49ae5102-4888-436f-ae1b-80281ed8affc	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	t	${role_impersonation}	impersonation	master	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	\N
e464824f-9284-486d-b528-1a5c7fbf843a	3a90bac6-ce11-467a-98b6-e2b2506d067c	t	${role_impersonation}	impersonation	cd0a239f-f540-49da-a4c3-8f57fd497cb4	3a90bac6-ce11-467a-98b6-e2b2506d067c	\N
161e34b7-3344-48ca-9b53-44ccd97c2d5e	847f8402-3f9a-4733-8193-c1bb8922fe5b	t	${role_read-token}	read-token	cd0a239f-f540-49da-a4c3-8f57fd497cb4	847f8402-3f9a-4733-8193-c1bb8922fe5b	\N
bcc590f0-b6bf-4eee-afe9-aea0acb387b4	cd0a239f-f540-49da-a4c3-8f57fd497cb4	f	${role_offline-access}	offline_access	cd0a239f-f540-49da-a4c3-8f57fd497cb4	\N	cd0a239f-f540-49da-a4c3-8f57fd497cb4
d8c6bfe1-f42a-4807-b14a-0151975e5146	cd0a239f-f540-49da-a4c3-8f57fd497cb4	f	${role_uma_authorization}	uma_authorization	cd0a239f-f540-49da-a4c3-8f57fd497cb4	\N	cd0a239f-f540-49da-a4c3-8f57fd497cb4
9e656de5-36d0-4182-9f73-7ced7472d57e	cd0a239f-f540-49da-a4c3-8f57fd497cb4	f	\N	sample-role	cd0a239f-f540-49da-a4c3-8f57fd497cb4	\N	cd0a239f-f540-49da-a4c3-8f57fd497cb4
\.


--
-- TOC entry 3846 (class 0 OID 82511)
-- Dependencies: 244
-- Data for Name: migration_model; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.migration_model (id, version, update_time) FROM stdin;
vpke4	12.0.1	1609664563
\.


--
-- TOC entry 3863 (class 0 OID 82795)
-- Dependencies: 261
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 3862 (class 0 OID 82789)
-- Dependencies: 260
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- TOC entry 3876 (class 0 OID 83018)
-- Dependencies: 274
-- Data for Name: policy_config; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- TOC entry 3838 (class 0 OID 82379)
-- Dependencies: 236
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
2ec28296-d677-48a1-985f-0e25d1261987	audience resolve	openid-connect	oidc-audience-resolve-mapper	7b7142af-e684-45b1-8b3e-cdbd34877635	\N
318e481c-1e67-48ae-9c03-127644b23759	locale	openid-connect	oidc-usermodel-attribute-mapper	3c40435d-0d15-4f87-9d63-5399cbaf4639	\N
e465f56e-bcbf-41cd-b5f6-e7a386bdd98e	role list	saml	saml-role-list-mapper	\N	542c39e4-a0ae-467c-a11a-119d40d9cf91
3792cc50-ac8d-4bc2-9dab-553d787a4112	full name	openid-connect	oidc-full-name-mapper	\N	ab19a893-0b5d-41d6-9649-6269cfd8fc74
25f92c5a-27ce-4f08-b391-438d82c30dcb	family name	openid-connect	oidc-usermodel-property-mapper	\N	ab19a893-0b5d-41d6-9649-6269cfd8fc74
32f053ba-4629-4907-b43d-b182b5567cf1	given name	openid-connect	oidc-usermodel-property-mapper	\N	ab19a893-0b5d-41d6-9649-6269cfd8fc74
09c6d532-0902-4f1b-bcce-98fc258093e1	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	ab19a893-0b5d-41d6-9649-6269cfd8fc74
017e6063-55e6-4b6e-a4f9-74c320b7c6ff	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	ab19a893-0b5d-41d6-9649-6269cfd8fc74
4929f2c8-6339-4e74-953c-1b5e2248b147	username	openid-connect	oidc-usermodel-property-mapper	\N	ab19a893-0b5d-41d6-9649-6269cfd8fc74
71cbfdb3-d1d8-4a0a-adaa-caaf28dcf26e	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	ab19a893-0b5d-41d6-9649-6269cfd8fc74
789cacf6-8e76-4da4-8c7d-fd64fac5c26c	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	ab19a893-0b5d-41d6-9649-6269cfd8fc74
3c12faf3-4774-4a40-ae27-d0fd8924fedf	website	openid-connect	oidc-usermodel-attribute-mapper	\N	ab19a893-0b5d-41d6-9649-6269cfd8fc74
8162b079-9f5f-4820-981c-3b4a9d95ffff	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	ab19a893-0b5d-41d6-9649-6269cfd8fc74
51d51837-44aa-4e9d-89f8-6240bd25ee71	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	ab19a893-0b5d-41d6-9649-6269cfd8fc74
75ae0029-00b2-4060-a191-c7b7aae8b7ed	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	ab19a893-0b5d-41d6-9649-6269cfd8fc74
334a4623-8092-437c-9652-4412379bbb53	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	ab19a893-0b5d-41d6-9649-6269cfd8fc74
136cb508-3847-4264-b8b3-ae1aeb940c7b	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	ab19a893-0b5d-41d6-9649-6269cfd8fc74
4b2b63db-31bd-4cd4-84fb-b2c32e590451	email	openid-connect	oidc-usermodel-property-mapper	\N	1f5b66a8-fcbe-44f1-a146-a68a486fcf55
31ed2438-7bfc-4833-a23c-70f55cde1a19	email verified	openid-connect	oidc-usermodel-property-mapper	\N	1f5b66a8-fcbe-44f1-a146-a68a486fcf55
1e3dc27e-e062-4b97-9e29-1ecb9d1ddbed	address	openid-connect	oidc-address-mapper	\N	6a8b58fa-b075-45d5-9db0-1850e42dc2df
83ef7d55-631c-4c01-a1b2-4ad767edbbc7	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	dc4edb03-85e7-44e4-ba52-308e9cefa7b3
01df233d-3ae5-4a86-b6c3-c3b90db75857	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	dc4edb03-85e7-44e4-ba52-308e9cefa7b3
a5fab146-80ba-40d7-9b47-669cb2bc37fd	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	452dd164-f028-4c1d-9434-b06ec6ae0e2b
a6eefb49-6dab-40e6-a3c9-478491e09231	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	452dd164-f028-4c1d-9434-b06ec6ae0e2b
730cf5ea-9d6d-4977-8b6c-c67559bb5597	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	452dd164-f028-4c1d-9434-b06ec6ae0e2b
91b360a8-eeba-4268-80f4-e6a97924a58d	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	8b37700b-1792-4c4d-ae96-88d9f3b7f80f
e7906fc7-149e-48d6-b830-02621452c1d5	upn	openid-connect	oidc-usermodel-property-mapper	\N	9656cdb9-7432-4e0b-9744-06e6c6dfd779
3f8565c7-b8b9-446e-acc3-1b1e7dda5524	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	9656cdb9-7432-4e0b-9744-06e6c6dfd779
3cafcc18-ccdc-4987-b696-004581c560f4	audience resolve	openid-connect	oidc-audience-resolve-mapper	4d364ac2-1ae1-4e14-84e3-8a108277c05d	\N
8a836650-b2a0-4c6e-9de2-48c796a26202	role list	saml	saml-role-list-mapper	\N	5c16a285-19ef-4c28-931d-24e037796c6b
0b5f4151-7cb3-4da3-bec8-5ba7103b0adc	full name	openid-connect	oidc-full-name-mapper	\N	d14f82e5-c666-49fb-900f-035e859723ed
4ff007bd-5d74-4165-8e60-fdd8be0d6d27	family name	openid-connect	oidc-usermodel-property-mapper	\N	d14f82e5-c666-49fb-900f-035e859723ed
a08def4c-8d40-48ac-bc06-13001ba751a3	given name	openid-connect	oidc-usermodel-property-mapper	\N	d14f82e5-c666-49fb-900f-035e859723ed
bbc94ea3-a5f1-4549-aa4a-60afa1873152	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	d14f82e5-c666-49fb-900f-035e859723ed
f00ea3f3-e7c4-4c24-964d-7b18712bb5ea	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	d14f82e5-c666-49fb-900f-035e859723ed
0cc3105a-c9c9-4c69-b16d-e29857efd712	username	openid-connect	oidc-usermodel-property-mapper	\N	d14f82e5-c666-49fb-900f-035e859723ed
9bc5e487-a47a-4a60-8824-0ddefaa3554d	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	d14f82e5-c666-49fb-900f-035e859723ed
b5eaecc8-3b4e-4e6b-9454-6c797ee4e64f	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	d14f82e5-c666-49fb-900f-035e859723ed
6c8fa36d-578b-4db4-8cd2-32601ccf7211	website	openid-connect	oidc-usermodel-attribute-mapper	\N	d14f82e5-c666-49fb-900f-035e859723ed
708ddd03-6da0-48e5-8407-687b80a8cdf6	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	d14f82e5-c666-49fb-900f-035e859723ed
4e9c8b03-c902-476b-8e8a-2583d9eea952	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	d14f82e5-c666-49fb-900f-035e859723ed
b02f100e-a230-49b1-bc94-a2c2667e198e	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	d14f82e5-c666-49fb-900f-035e859723ed
a0fe6c36-b9b1-4dd4-8e9d-e2c58bb6d812	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	d14f82e5-c666-49fb-900f-035e859723ed
6379f510-92d3-404f-a6ed-1e228e4edee4	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	d14f82e5-c666-49fb-900f-035e859723ed
5c099240-b258-4f7e-901b-8f02a2bc636c	email	openid-connect	oidc-usermodel-property-mapper	\N	911a036a-a3eb-459d-8712-5a8add44d451
6955a32e-2e2c-4956-ac96-0ad5f49fd0c3	email verified	openid-connect	oidc-usermodel-property-mapper	\N	911a036a-a3eb-459d-8712-5a8add44d451
6fadabc7-9753-4d7c-9a93-b53826b1ac8c	address	openid-connect	oidc-address-mapper	\N	7cae1885-591f-462e-862d-d2cda2435a65
f90e6c10-d7c6-4c94-aff7-02ced7ce84c5	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	01bd033a-edf5-4f61-b352-8b0efe58ee41
309183df-ba8d-4209-94fc-31a1e17945e6	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	01bd033a-edf5-4f61-b352-8b0efe58ee41
6c8d4761-124a-453e-87ec-f453672c8487	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	5496757b-0678-41fd-a53b-fcd1f720bb9c
73fdcf40-2608-47ea-be26-a9e45965815e	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	5496757b-0678-41fd-a53b-fcd1f720bb9c
f44c4ffa-da95-4288-bb27-a03a6fc5f532	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	5496757b-0678-41fd-a53b-fcd1f720bb9c
3a4e7379-9d4f-43e6-b5df-5f445324f35c	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	a70675d8-0782-41dd-b771-92ea720a4230
043fc60f-9721-4cb8-8b0b-39d0d4b13dc6	upn	openid-connect	oidc-usermodel-property-mapper	\N	e9d72e1c-f971-4c85-b094-bb7c804cddb1
bba84435-6a88-4856-812d-8f0c105761ed	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	e9d72e1c-f971-4c85-b094-bb7c804cddb1
99f68a8f-ee30-473d-beea-f4180ee1695e	locale	openid-connect	oidc-usermodel-attribute-mapper	eeac28db-e546-4cbd-8d1d-ea2bf0077028	\N
e4acd4be-3813-45ef-b754-33a50f0e5088	id	openid-connect	oidc-usermodel-property-mapper	572824ad-4fe5-41da-8fd1-c3ba5661374c	\N
\.


--
-- TOC entry 3839 (class 0 OID 82386)
-- Dependencies: 237
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
318e481c-1e67-48ae-9c03-127644b23759	true	userinfo.token.claim
318e481c-1e67-48ae-9c03-127644b23759	locale	user.attribute
318e481c-1e67-48ae-9c03-127644b23759	true	id.token.claim
318e481c-1e67-48ae-9c03-127644b23759	true	access.token.claim
318e481c-1e67-48ae-9c03-127644b23759	locale	claim.name
318e481c-1e67-48ae-9c03-127644b23759	String	jsonType.label
e465f56e-bcbf-41cd-b5f6-e7a386bdd98e	false	single
e465f56e-bcbf-41cd-b5f6-e7a386bdd98e	Basic	attribute.nameformat
e465f56e-bcbf-41cd-b5f6-e7a386bdd98e	Role	attribute.name
3792cc50-ac8d-4bc2-9dab-553d787a4112	true	userinfo.token.claim
3792cc50-ac8d-4bc2-9dab-553d787a4112	true	id.token.claim
3792cc50-ac8d-4bc2-9dab-553d787a4112	true	access.token.claim
25f92c5a-27ce-4f08-b391-438d82c30dcb	true	userinfo.token.claim
25f92c5a-27ce-4f08-b391-438d82c30dcb	lastName	user.attribute
25f92c5a-27ce-4f08-b391-438d82c30dcb	true	id.token.claim
25f92c5a-27ce-4f08-b391-438d82c30dcb	true	access.token.claim
25f92c5a-27ce-4f08-b391-438d82c30dcb	family_name	claim.name
25f92c5a-27ce-4f08-b391-438d82c30dcb	String	jsonType.label
32f053ba-4629-4907-b43d-b182b5567cf1	true	userinfo.token.claim
32f053ba-4629-4907-b43d-b182b5567cf1	firstName	user.attribute
32f053ba-4629-4907-b43d-b182b5567cf1	true	id.token.claim
32f053ba-4629-4907-b43d-b182b5567cf1	true	access.token.claim
32f053ba-4629-4907-b43d-b182b5567cf1	given_name	claim.name
32f053ba-4629-4907-b43d-b182b5567cf1	String	jsonType.label
09c6d532-0902-4f1b-bcce-98fc258093e1	true	userinfo.token.claim
09c6d532-0902-4f1b-bcce-98fc258093e1	middleName	user.attribute
09c6d532-0902-4f1b-bcce-98fc258093e1	true	id.token.claim
09c6d532-0902-4f1b-bcce-98fc258093e1	true	access.token.claim
09c6d532-0902-4f1b-bcce-98fc258093e1	middle_name	claim.name
09c6d532-0902-4f1b-bcce-98fc258093e1	String	jsonType.label
017e6063-55e6-4b6e-a4f9-74c320b7c6ff	true	userinfo.token.claim
017e6063-55e6-4b6e-a4f9-74c320b7c6ff	nickname	user.attribute
017e6063-55e6-4b6e-a4f9-74c320b7c6ff	true	id.token.claim
017e6063-55e6-4b6e-a4f9-74c320b7c6ff	true	access.token.claim
017e6063-55e6-4b6e-a4f9-74c320b7c6ff	nickname	claim.name
017e6063-55e6-4b6e-a4f9-74c320b7c6ff	String	jsonType.label
4929f2c8-6339-4e74-953c-1b5e2248b147	true	userinfo.token.claim
4929f2c8-6339-4e74-953c-1b5e2248b147	username	user.attribute
4929f2c8-6339-4e74-953c-1b5e2248b147	true	id.token.claim
4929f2c8-6339-4e74-953c-1b5e2248b147	true	access.token.claim
4929f2c8-6339-4e74-953c-1b5e2248b147	preferred_username	claim.name
4929f2c8-6339-4e74-953c-1b5e2248b147	String	jsonType.label
71cbfdb3-d1d8-4a0a-adaa-caaf28dcf26e	true	userinfo.token.claim
71cbfdb3-d1d8-4a0a-adaa-caaf28dcf26e	profile	user.attribute
71cbfdb3-d1d8-4a0a-adaa-caaf28dcf26e	true	id.token.claim
71cbfdb3-d1d8-4a0a-adaa-caaf28dcf26e	true	access.token.claim
71cbfdb3-d1d8-4a0a-adaa-caaf28dcf26e	profile	claim.name
71cbfdb3-d1d8-4a0a-adaa-caaf28dcf26e	String	jsonType.label
789cacf6-8e76-4da4-8c7d-fd64fac5c26c	true	userinfo.token.claim
789cacf6-8e76-4da4-8c7d-fd64fac5c26c	picture	user.attribute
789cacf6-8e76-4da4-8c7d-fd64fac5c26c	true	id.token.claim
789cacf6-8e76-4da4-8c7d-fd64fac5c26c	true	access.token.claim
789cacf6-8e76-4da4-8c7d-fd64fac5c26c	picture	claim.name
789cacf6-8e76-4da4-8c7d-fd64fac5c26c	String	jsonType.label
3c12faf3-4774-4a40-ae27-d0fd8924fedf	true	userinfo.token.claim
3c12faf3-4774-4a40-ae27-d0fd8924fedf	website	user.attribute
3c12faf3-4774-4a40-ae27-d0fd8924fedf	true	id.token.claim
3c12faf3-4774-4a40-ae27-d0fd8924fedf	true	access.token.claim
3c12faf3-4774-4a40-ae27-d0fd8924fedf	website	claim.name
3c12faf3-4774-4a40-ae27-d0fd8924fedf	String	jsonType.label
8162b079-9f5f-4820-981c-3b4a9d95ffff	true	userinfo.token.claim
8162b079-9f5f-4820-981c-3b4a9d95ffff	gender	user.attribute
8162b079-9f5f-4820-981c-3b4a9d95ffff	true	id.token.claim
8162b079-9f5f-4820-981c-3b4a9d95ffff	true	access.token.claim
8162b079-9f5f-4820-981c-3b4a9d95ffff	gender	claim.name
8162b079-9f5f-4820-981c-3b4a9d95ffff	String	jsonType.label
51d51837-44aa-4e9d-89f8-6240bd25ee71	true	userinfo.token.claim
51d51837-44aa-4e9d-89f8-6240bd25ee71	birthdate	user.attribute
51d51837-44aa-4e9d-89f8-6240bd25ee71	true	id.token.claim
51d51837-44aa-4e9d-89f8-6240bd25ee71	true	access.token.claim
51d51837-44aa-4e9d-89f8-6240bd25ee71	birthdate	claim.name
51d51837-44aa-4e9d-89f8-6240bd25ee71	String	jsonType.label
75ae0029-00b2-4060-a191-c7b7aae8b7ed	true	userinfo.token.claim
75ae0029-00b2-4060-a191-c7b7aae8b7ed	zoneinfo	user.attribute
75ae0029-00b2-4060-a191-c7b7aae8b7ed	true	id.token.claim
75ae0029-00b2-4060-a191-c7b7aae8b7ed	true	access.token.claim
75ae0029-00b2-4060-a191-c7b7aae8b7ed	zoneinfo	claim.name
75ae0029-00b2-4060-a191-c7b7aae8b7ed	String	jsonType.label
334a4623-8092-437c-9652-4412379bbb53	true	userinfo.token.claim
334a4623-8092-437c-9652-4412379bbb53	locale	user.attribute
334a4623-8092-437c-9652-4412379bbb53	true	id.token.claim
334a4623-8092-437c-9652-4412379bbb53	true	access.token.claim
334a4623-8092-437c-9652-4412379bbb53	locale	claim.name
334a4623-8092-437c-9652-4412379bbb53	String	jsonType.label
136cb508-3847-4264-b8b3-ae1aeb940c7b	true	userinfo.token.claim
136cb508-3847-4264-b8b3-ae1aeb940c7b	updatedAt	user.attribute
136cb508-3847-4264-b8b3-ae1aeb940c7b	true	id.token.claim
136cb508-3847-4264-b8b3-ae1aeb940c7b	true	access.token.claim
136cb508-3847-4264-b8b3-ae1aeb940c7b	updated_at	claim.name
136cb508-3847-4264-b8b3-ae1aeb940c7b	String	jsonType.label
4b2b63db-31bd-4cd4-84fb-b2c32e590451	true	userinfo.token.claim
4b2b63db-31bd-4cd4-84fb-b2c32e590451	email	user.attribute
4b2b63db-31bd-4cd4-84fb-b2c32e590451	true	id.token.claim
4b2b63db-31bd-4cd4-84fb-b2c32e590451	true	access.token.claim
4b2b63db-31bd-4cd4-84fb-b2c32e590451	email	claim.name
4b2b63db-31bd-4cd4-84fb-b2c32e590451	String	jsonType.label
31ed2438-7bfc-4833-a23c-70f55cde1a19	true	userinfo.token.claim
31ed2438-7bfc-4833-a23c-70f55cde1a19	emailVerified	user.attribute
31ed2438-7bfc-4833-a23c-70f55cde1a19	true	id.token.claim
31ed2438-7bfc-4833-a23c-70f55cde1a19	true	access.token.claim
31ed2438-7bfc-4833-a23c-70f55cde1a19	email_verified	claim.name
31ed2438-7bfc-4833-a23c-70f55cde1a19	boolean	jsonType.label
1e3dc27e-e062-4b97-9e29-1ecb9d1ddbed	formatted	user.attribute.formatted
1e3dc27e-e062-4b97-9e29-1ecb9d1ddbed	country	user.attribute.country
1e3dc27e-e062-4b97-9e29-1ecb9d1ddbed	postal_code	user.attribute.postal_code
1e3dc27e-e062-4b97-9e29-1ecb9d1ddbed	true	userinfo.token.claim
1e3dc27e-e062-4b97-9e29-1ecb9d1ddbed	street	user.attribute.street
1e3dc27e-e062-4b97-9e29-1ecb9d1ddbed	true	id.token.claim
1e3dc27e-e062-4b97-9e29-1ecb9d1ddbed	region	user.attribute.region
1e3dc27e-e062-4b97-9e29-1ecb9d1ddbed	true	access.token.claim
1e3dc27e-e062-4b97-9e29-1ecb9d1ddbed	locality	user.attribute.locality
83ef7d55-631c-4c01-a1b2-4ad767edbbc7	true	userinfo.token.claim
83ef7d55-631c-4c01-a1b2-4ad767edbbc7	phoneNumber	user.attribute
83ef7d55-631c-4c01-a1b2-4ad767edbbc7	true	id.token.claim
83ef7d55-631c-4c01-a1b2-4ad767edbbc7	true	access.token.claim
83ef7d55-631c-4c01-a1b2-4ad767edbbc7	phone_number	claim.name
83ef7d55-631c-4c01-a1b2-4ad767edbbc7	String	jsonType.label
01df233d-3ae5-4a86-b6c3-c3b90db75857	true	userinfo.token.claim
01df233d-3ae5-4a86-b6c3-c3b90db75857	phoneNumberVerified	user.attribute
01df233d-3ae5-4a86-b6c3-c3b90db75857	true	id.token.claim
01df233d-3ae5-4a86-b6c3-c3b90db75857	true	access.token.claim
01df233d-3ae5-4a86-b6c3-c3b90db75857	phone_number_verified	claim.name
01df233d-3ae5-4a86-b6c3-c3b90db75857	boolean	jsonType.label
a5fab146-80ba-40d7-9b47-669cb2bc37fd	true	multivalued
a5fab146-80ba-40d7-9b47-669cb2bc37fd	foo	user.attribute
a5fab146-80ba-40d7-9b47-669cb2bc37fd	true	access.token.claim
a5fab146-80ba-40d7-9b47-669cb2bc37fd	realm_access.roles	claim.name
a5fab146-80ba-40d7-9b47-669cb2bc37fd	String	jsonType.label
a6eefb49-6dab-40e6-a3c9-478491e09231	true	multivalued
a6eefb49-6dab-40e6-a3c9-478491e09231	foo	user.attribute
a6eefb49-6dab-40e6-a3c9-478491e09231	true	access.token.claim
a6eefb49-6dab-40e6-a3c9-478491e09231	resource_access.${client_id}.roles	claim.name
a6eefb49-6dab-40e6-a3c9-478491e09231	String	jsonType.label
e7906fc7-149e-48d6-b830-02621452c1d5	true	userinfo.token.claim
e7906fc7-149e-48d6-b830-02621452c1d5	username	user.attribute
e7906fc7-149e-48d6-b830-02621452c1d5	true	id.token.claim
e7906fc7-149e-48d6-b830-02621452c1d5	true	access.token.claim
e7906fc7-149e-48d6-b830-02621452c1d5	upn	claim.name
e7906fc7-149e-48d6-b830-02621452c1d5	String	jsonType.label
3f8565c7-b8b9-446e-acc3-1b1e7dda5524	true	multivalued
3f8565c7-b8b9-446e-acc3-1b1e7dda5524	foo	user.attribute
3f8565c7-b8b9-446e-acc3-1b1e7dda5524	true	id.token.claim
3f8565c7-b8b9-446e-acc3-1b1e7dda5524	true	access.token.claim
3f8565c7-b8b9-446e-acc3-1b1e7dda5524	groups	claim.name
3f8565c7-b8b9-446e-acc3-1b1e7dda5524	String	jsonType.label
8a836650-b2a0-4c6e-9de2-48c796a26202	false	single
8a836650-b2a0-4c6e-9de2-48c796a26202	Basic	attribute.nameformat
8a836650-b2a0-4c6e-9de2-48c796a26202	Role	attribute.name
0b5f4151-7cb3-4da3-bec8-5ba7103b0adc	true	userinfo.token.claim
0b5f4151-7cb3-4da3-bec8-5ba7103b0adc	true	id.token.claim
0b5f4151-7cb3-4da3-bec8-5ba7103b0adc	true	access.token.claim
4ff007bd-5d74-4165-8e60-fdd8be0d6d27	true	userinfo.token.claim
4ff007bd-5d74-4165-8e60-fdd8be0d6d27	lastName	user.attribute
4ff007bd-5d74-4165-8e60-fdd8be0d6d27	true	id.token.claim
4ff007bd-5d74-4165-8e60-fdd8be0d6d27	true	access.token.claim
4ff007bd-5d74-4165-8e60-fdd8be0d6d27	family_name	claim.name
4ff007bd-5d74-4165-8e60-fdd8be0d6d27	String	jsonType.label
a08def4c-8d40-48ac-bc06-13001ba751a3	true	userinfo.token.claim
a08def4c-8d40-48ac-bc06-13001ba751a3	firstName	user.attribute
a08def4c-8d40-48ac-bc06-13001ba751a3	true	id.token.claim
a08def4c-8d40-48ac-bc06-13001ba751a3	true	access.token.claim
a08def4c-8d40-48ac-bc06-13001ba751a3	given_name	claim.name
a08def4c-8d40-48ac-bc06-13001ba751a3	String	jsonType.label
bbc94ea3-a5f1-4549-aa4a-60afa1873152	true	userinfo.token.claim
bbc94ea3-a5f1-4549-aa4a-60afa1873152	middleName	user.attribute
bbc94ea3-a5f1-4549-aa4a-60afa1873152	true	id.token.claim
bbc94ea3-a5f1-4549-aa4a-60afa1873152	true	access.token.claim
bbc94ea3-a5f1-4549-aa4a-60afa1873152	middle_name	claim.name
bbc94ea3-a5f1-4549-aa4a-60afa1873152	String	jsonType.label
f00ea3f3-e7c4-4c24-964d-7b18712bb5ea	true	userinfo.token.claim
f00ea3f3-e7c4-4c24-964d-7b18712bb5ea	nickname	user.attribute
f00ea3f3-e7c4-4c24-964d-7b18712bb5ea	true	id.token.claim
f00ea3f3-e7c4-4c24-964d-7b18712bb5ea	true	access.token.claim
f00ea3f3-e7c4-4c24-964d-7b18712bb5ea	nickname	claim.name
f00ea3f3-e7c4-4c24-964d-7b18712bb5ea	String	jsonType.label
0cc3105a-c9c9-4c69-b16d-e29857efd712	true	userinfo.token.claim
0cc3105a-c9c9-4c69-b16d-e29857efd712	username	user.attribute
0cc3105a-c9c9-4c69-b16d-e29857efd712	true	id.token.claim
0cc3105a-c9c9-4c69-b16d-e29857efd712	true	access.token.claim
0cc3105a-c9c9-4c69-b16d-e29857efd712	preferred_username	claim.name
0cc3105a-c9c9-4c69-b16d-e29857efd712	String	jsonType.label
9bc5e487-a47a-4a60-8824-0ddefaa3554d	true	userinfo.token.claim
9bc5e487-a47a-4a60-8824-0ddefaa3554d	profile	user.attribute
9bc5e487-a47a-4a60-8824-0ddefaa3554d	true	id.token.claim
9bc5e487-a47a-4a60-8824-0ddefaa3554d	true	access.token.claim
9bc5e487-a47a-4a60-8824-0ddefaa3554d	profile	claim.name
9bc5e487-a47a-4a60-8824-0ddefaa3554d	String	jsonType.label
b5eaecc8-3b4e-4e6b-9454-6c797ee4e64f	true	userinfo.token.claim
b5eaecc8-3b4e-4e6b-9454-6c797ee4e64f	picture	user.attribute
b5eaecc8-3b4e-4e6b-9454-6c797ee4e64f	true	id.token.claim
b5eaecc8-3b4e-4e6b-9454-6c797ee4e64f	true	access.token.claim
b5eaecc8-3b4e-4e6b-9454-6c797ee4e64f	picture	claim.name
b5eaecc8-3b4e-4e6b-9454-6c797ee4e64f	String	jsonType.label
6c8fa36d-578b-4db4-8cd2-32601ccf7211	true	userinfo.token.claim
6c8fa36d-578b-4db4-8cd2-32601ccf7211	website	user.attribute
6c8fa36d-578b-4db4-8cd2-32601ccf7211	true	id.token.claim
6c8fa36d-578b-4db4-8cd2-32601ccf7211	true	access.token.claim
6c8fa36d-578b-4db4-8cd2-32601ccf7211	website	claim.name
6c8fa36d-578b-4db4-8cd2-32601ccf7211	String	jsonType.label
708ddd03-6da0-48e5-8407-687b80a8cdf6	true	userinfo.token.claim
708ddd03-6da0-48e5-8407-687b80a8cdf6	gender	user.attribute
708ddd03-6da0-48e5-8407-687b80a8cdf6	true	id.token.claim
708ddd03-6da0-48e5-8407-687b80a8cdf6	true	access.token.claim
708ddd03-6da0-48e5-8407-687b80a8cdf6	gender	claim.name
708ddd03-6da0-48e5-8407-687b80a8cdf6	String	jsonType.label
4e9c8b03-c902-476b-8e8a-2583d9eea952	true	userinfo.token.claim
4e9c8b03-c902-476b-8e8a-2583d9eea952	birthdate	user.attribute
4e9c8b03-c902-476b-8e8a-2583d9eea952	true	id.token.claim
4e9c8b03-c902-476b-8e8a-2583d9eea952	true	access.token.claim
4e9c8b03-c902-476b-8e8a-2583d9eea952	birthdate	claim.name
4e9c8b03-c902-476b-8e8a-2583d9eea952	String	jsonType.label
b02f100e-a230-49b1-bc94-a2c2667e198e	true	userinfo.token.claim
b02f100e-a230-49b1-bc94-a2c2667e198e	zoneinfo	user.attribute
b02f100e-a230-49b1-bc94-a2c2667e198e	true	id.token.claim
b02f100e-a230-49b1-bc94-a2c2667e198e	true	access.token.claim
b02f100e-a230-49b1-bc94-a2c2667e198e	zoneinfo	claim.name
b02f100e-a230-49b1-bc94-a2c2667e198e	String	jsonType.label
a0fe6c36-b9b1-4dd4-8e9d-e2c58bb6d812	true	userinfo.token.claim
a0fe6c36-b9b1-4dd4-8e9d-e2c58bb6d812	locale	user.attribute
a0fe6c36-b9b1-4dd4-8e9d-e2c58bb6d812	true	id.token.claim
a0fe6c36-b9b1-4dd4-8e9d-e2c58bb6d812	true	access.token.claim
a0fe6c36-b9b1-4dd4-8e9d-e2c58bb6d812	locale	claim.name
a0fe6c36-b9b1-4dd4-8e9d-e2c58bb6d812	String	jsonType.label
6379f510-92d3-404f-a6ed-1e228e4edee4	true	userinfo.token.claim
6379f510-92d3-404f-a6ed-1e228e4edee4	updatedAt	user.attribute
6379f510-92d3-404f-a6ed-1e228e4edee4	true	id.token.claim
6379f510-92d3-404f-a6ed-1e228e4edee4	true	access.token.claim
6379f510-92d3-404f-a6ed-1e228e4edee4	updated_at	claim.name
6379f510-92d3-404f-a6ed-1e228e4edee4	String	jsonType.label
5c099240-b258-4f7e-901b-8f02a2bc636c	true	userinfo.token.claim
5c099240-b258-4f7e-901b-8f02a2bc636c	email	user.attribute
5c099240-b258-4f7e-901b-8f02a2bc636c	true	id.token.claim
5c099240-b258-4f7e-901b-8f02a2bc636c	true	access.token.claim
5c099240-b258-4f7e-901b-8f02a2bc636c	email	claim.name
5c099240-b258-4f7e-901b-8f02a2bc636c	String	jsonType.label
6955a32e-2e2c-4956-ac96-0ad5f49fd0c3	true	userinfo.token.claim
6955a32e-2e2c-4956-ac96-0ad5f49fd0c3	emailVerified	user.attribute
6955a32e-2e2c-4956-ac96-0ad5f49fd0c3	true	id.token.claim
6955a32e-2e2c-4956-ac96-0ad5f49fd0c3	true	access.token.claim
6955a32e-2e2c-4956-ac96-0ad5f49fd0c3	email_verified	claim.name
6955a32e-2e2c-4956-ac96-0ad5f49fd0c3	boolean	jsonType.label
6fadabc7-9753-4d7c-9a93-b53826b1ac8c	formatted	user.attribute.formatted
6fadabc7-9753-4d7c-9a93-b53826b1ac8c	country	user.attribute.country
6fadabc7-9753-4d7c-9a93-b53826b1ac8c	postal_code	user.attribute.postal_code
6fadabc7-9753-4d7c-9a93-b53826b1ac8c	true	userinfo.token.claim
6fadabc7-9753-4d7c-9a93-b53826b1ac8c	street	user.attribute.street
6fadabc7-9753-4d7c-9a93-b53826b1ac8c	true	id.token.claim
6fadabc7-9753-4d7c-9a93-b53826b1ac8c	region	user.attribute.region
6fadabc7-9753-4d7c-9a93-b53826b1ac8c	true	access.token.claim
6fadabc7-9753-4d7c-9a93-b53826b1ac8c	locality	user.attribute.locality
f90e6c10-d7c6-4c94-aff7-02ced7ce84c5	true	userinfo.token.claim
f90e6c10-d7c6-4c94-aff7-02ced7ce84c5	phoneNumber	user.attribute
f90e6c10-d7c6-4c94-aff7-02ced7ce84c5	true	id.token.claim
f90e6c10-d7c6-4c94-aff7-02ced7ce84c5	true	access.token.claim
f90e6c10-d7c6-4c94-aff7-02ced7ce84c5	phone_number	claim.name
f90e6c10-d7c6-4c94-aff7-02ced7ce84c5	String	jsonType.label
309183df-ba8d-4209-94fc-31a1e17945e6	true	userinfo.token.claim
309183df-ba8d-4209-94fc-31a1e17945e6	phoneNumberVerified	user.attribute
309183df-ba8d-4209-94fc-31a1e17945e6	true	id.token.claim
309183df-ba8d-4209-94fc-31a1e17945e6	true	access.token.claim
309183df-ba8d-4209-94fc-31a1e17945e6	phone_number_verified	claim.name
309183df-ba8d-4209-94fc-31a1e17945e6	boolean	jsonType.label
6c8d4761-124a-453e-87ec-f453672c8487	true	multivalued
6c8d4761-124a-453e-87ec-f453672c8487	foo	user.attribute
6c8d4761-124a-453e-87ec-f453672c8487	true	access.token.claim
6c8d4761-124a-453e-87ec-f453672c8487	realm_access.roles	claim.name
6c8d4761-124a-453e-87ec-f453672c8487	String	jsonType.label
73fdcf40-2608-47ea-be26-a9e45965815e	true	multivalued
73fdcf40-2608-47ea-be26-a9e45965815e	foo	user.attribute
73fdcf40-2608-47ea-be26-a9e45965815e	true	access.token.claim
73fdcf40-2608-47ea-be26-a9e45965815e	resource_access.${client_id}.roles	claim.name
73fdcf40-2608-47ea-be26-a9e45965815e	String	jsonType.label
043fc60f-9721-4cb8-8b0b-39d0d4b13dc6	true	userinfo.token.claim
043fc60f-9721-4cb8-8b0b-39d0d4b13dc6	username	user.attribute
043fc60f-9721-4cb8-8b0b-39d0d4b13dc6	true	id.token.claim
043fc60f-9721-4cb8-8b0b-39d0d4b13dc6	true	access.token.claim
043fc60f-9721-4cb8-8b0b-39d0d4b13dc6	upn	claim.name
043fc60f-9721-4cb8-8b0b-39d0d4b13dc6	String	jsonType.label
bba84435-6a88-4856-812d-8f0c105761ed	true	multivalued
bba84435-6a88-4856-812d-8f0c105761ed	foo	user.attribute
bba84435-6a88-4856-812d-8f0c105761ed	true	id.token.claim
bba84435-6a88-4856-812d-8f0c105761ed	true	access.token.claim
bba84435-6a88-4856-812d-8f0c105761ed	groups	claim.name
bba84435-6a88-4856-812d-8f0c105761ed	String	jsonType.label
99f68a8f-ee30-473d-beea-f4180ee1695e	true	userinfo.token.claim
99f68a8f-ee30-473d-beea-f4180ee1695e	locale	user.attribute
99f68a8f-ee30-473d-beea-f4180ee1695e	true	id.token.claim
99f68a8f-ee30-473d-beea-f4180ee1695e	true	access.token.claim
99f68a8f-ee30-473d-beea-f4180ee1695e	locale	claim.name
99f68a8f-ee30-473d-beea-f4180ee1695e	String	jsonType.label
e4acd4be-3813-45ef-b754-33a50f0e5088	true	userinfo.token.claim
e4acd4be-3813-45ef-b754-33a50f0e5088	id	user.attribute
e4acd4be-3813-45ef-b754-33a50f0e5088	true	id.token.claim
e4acd4be-3813-45ef-b754-33a50f0e5088	true	access.token.claim
e4acd4be-3813-45ef-b754-33a50f0e5088	user_id	claim.name
e4acd4be-3813-45ef-b754-33a50f0e5088	String	jsonType.label
\.


--
-- TOC entry 3818 (class 0 OID 82014)
-- Dependencies: 216
-- Data for Name: realm; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	f1d6c39d-1edb-478f-afa9-f50ba13c43ff	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	8c6fe9ec-0193-4c98-b5a8-ff35cb3202f6	831312ce-dd7f-47ec-b97c-b7c8e923b064	b964a601-5f73-4cec-a380-1bcb44dd6dea	d3055c2a-2101-4f09-9b92-9c902fe020ed	c5ba5f78-d833-4ea3-a73c-aafce1fad20a	2592000	f	900	t	f	d5755433-fab6-4a53-95fa-1ea4fcc183b8	0	f	0	0
cd0a239f-f540-49da-a4c3-8f57fd497cb4	60	300	300	\N	\N	\N	t	f	0	\N	realm-sample	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	83e8abd9-2395-481f-b1d6-8e1857eb1ca7	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	eaee8493-aa3f-4c76-a52c-85d840127909	b28c2edd-43ab-4c78-aeb4-f7fef818e54b	d9ae1ba0-727d-4e38-85ad-5c5efee6bf16	aa2dabbe-b7cb-4287-b585-ff0baee6ef30	1764b396-3da7-4eda-bf62-5bf4d79123fb	2592000	f	900	t	f	89f28140-bb7c-4196-8c4a-3dda701b220b	0	f	0	0
\.


--
-- TOC entry 3819 (class 0 OID 82032)
-- Dependencies: 217
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.realm_attribute (name, value, realm_id) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly		master
_browser_header.xContentTypeOptions	nosniff	master
_browser_header.xRobotsTag	none	master
_browser_header.xFrameOptions	SAMEORIGIN	master
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	master
_browser_header.xXSSProtection	1; mode=block	master
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	master
bruteForceProtected	false	master
permanentLockout	false	master
maxFailureWaitSeconds	900	master
minimumQuickLoginWaitSeconds	60	master
waitIncrementSeconds	60	master
quickLoginCheckMilliSeconds	1000	master
maxDeltaTimeSeconds	43200	master
failureFactor	30	master
displayName	Keycloak	master
displayNameHtml	<div class="kc-logo-text"><span>Keycloak</span></div>	master
offlineSessionMaxLifespanEnabled	false	master
offlineSessionMaxLifespan	5184000	master
_browser_header.contentSecurityPolicyReportOnly		cd0a239f-f540-49da-a4c3-8f57fd497cb4
_browser_header.xContentTypeOptions	nosniff	cd0a239f-f540-49da-a4c3-8f57fd497cb4
_browser_header.xRobotsTag	none	cd0a239f-f540-49da-a4c3-8f57fd497cb4
_browser_header.xFrameOptions	SAMEORIGIN	cd0a239f-f540-49da-a4c3-8f57fd497cb4
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	cd0a239f-f540-49da-a4c3-8f57fd497cb4
_browser_header.xXSSProtection	1; mode=block	cd0a239f-f540-49da-a4c3-8f57fd497cb4
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	cd0a239f-f540-49da-a4c3-8f57fd497cb4
bruteForceProtected	false	cd0a239f-f540-49da-a4c3-8f57fd497cb4
permanentLockout	false	cd0a239f-f540-49da-a4c3-8f57fd497cb4
maxFailureWaitSeconds	900	cd0a239f-f540-49da-a4c3-8f57fd497cb4
minimumQuickLoginWaitSeconds	60	cd0a239f-f540-49da-a4c3-8f57fd497cb4
waitIncrementSeconds	60	cd0a239f-f540-49da-a4c3-8f57fd497cb4
quickLoginCheckMilliSeconds	1000	cd0a239f-f540-49da-a4c3-8f57fd497cb4
maxDeltaTimeSeconds	43200	cd0a239f-f540-49da-a4c3-8f57fd497cb4
failureFactor	30	cd0a239f-f540-49da-a4c3-8f57fd497cb4
offlineSessionMaxLifespanEnabled	false	cd0a239f-f540-49da-a4c3-8f57fd497cb4
offlineSessionMaxLifespan	5184000	cd0a239f-f540-49da-a4c3-8f57fd497cb4
actionTokenGeneratedByAdminLifespan	43200	cd0a239f-f540-49da-a4c3-8f57fd497cb4
actionTokenGeneratedByUserLifespan	300	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyRpEntityName	keycloak	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicySignatureAlgorithms	ES256	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyRpId		cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyAttestationConveyancePreference	not specified	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyAuthenticatorAttachment	not specified	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyRequireResidentKey	not specified	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyUserVerificationRequirement	not specified	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyCreateTimeout	0	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyAvoidSameAuthenticatorRegister	false	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyRpEntityNamePasswordless	keycloak	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicySignatureAlgorithmsPasswordless	ES256	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyRpIdPasswordless		cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyAttestationConveyancePreferencePasswordless	not specified	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyAuthenticatorAttachmentPasswordless	not specified	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyRequireResidentKeyPasswordless	not specified	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyUserVerificationRequirementPasswordless	not specified	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyCreateTimeoutPasswordless	0	cd0a239f-f540-49da-a4c3-8f57fd497cb4
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	false	cd0a239f-f540-49da-a4c3-8f57fd497cb4
\.


--
-- TOC entry 3868 (class 0 OID 82821)
-- Dependencies: 266
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- TOC entry 3820 (class 0 OID 82038)
-- Dependencies: 218
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.realm_default_roles (realm_id, role_id) FROM stdin;
master	d01a17e2-11c6-44a1-b36e-f79593346796
master	19bdd7e5-17b4-4e91-ad47-17496a9ecb8a
cd0a239f-f540-49da-a4c3-8f57fd497cb4	bcc590f0-b6bf-4eee-afe9-aea0acb387b4
cd0a239f-f540-49da-a4c3-8f57fd497cb4	d8c6bfe1-f42a-4807-b14a-0151975e5146
\.


--
-- TOC entry 3845 (class 0 OID 82503)
-- Dependencies: 243
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- TOC entry 3821 (class 0 OID 82041)
-- Dependencies: 219
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
cd0a239f-f540-49da-a4c3-8f57fd497cb4	jboss-logging
\.


--
-- TOC entry 3901 (class 0 OID 83548)
-- Dependencies: 299
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- TOC entry 3822 (class 0 OID 82044)
-- Dependencies: 220
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	cd0a239f-f540-49da-a4c3-8f57fd497cb4
\.


--
-- TOC entry 3823 (class 0 OID 82052)
-- Dependencies: 221
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- TOC entry 3843 (class 0 OID 82418)
-- Dependencies: 241
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- TOC entry 3824 (class 0 OID 82064)
-- Dependencies: 222
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.redirect_uris (client_id, value) FROM stdin;
1134a440-e17e-4235-9205-fdc3ab98150a	/realms/master/account/*
7b7142af-e684-45b1-8b3e-cdbd34877635	/realms/master/account/*
3c40435d-0d15-4f87-9d63-5399cbaf4639	/admin/master/console/*
417353a9-b424-43ad-96cd-0d651fc3f184	/realms/realm-sample/account/*
4d364ac2-1ae1-4e14-84e3-8a108277c05d	/realms/realm-sample/account/*
eeac28db-e546-4cbd-8d1d-ea2bf0077028	/admin/realm-sample/console/*
572824ad-4fe5-41da-8fd1-c3ba5661374c	*
\.


--
-- TOC entry 3861 (class 0 OID 82752)
-- Dependencies: 259
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- TOC entry 3860 (class 0 OID 82744)
-- Dependencies: 258
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
e9f79509-5344-4b35-8db8-705c7f355881	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
a7ccae96-9169-4433-8f37-2ae989252dad	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
c33d5829-b2c3-42de-9af2-adfc177c1ffd	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
d80c8e36-d1ed-467b-b9af-ba7b0deb9ae0	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
0e700542-8388-491a-8457-181e0d59f8af	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
3f64c97b-2637-4d22-96c3-d1b6ba33dd01	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
ec33810a-eb70-4358-a325-a4053a530d47	delete_account	Delete Account	master	f	f	delete_account	60
e0abe3a7-1b4d-402d-95ef-68994c36640d	VERIFY_EMAIL	Verify Email	cd0a239f-f540-49da-a4c3-8f57fd497cb4	t	f	VERIFY_EMAIL	50
9dbb0913-e225-4b04-96c0-f551f49c7348	UPDATE_PROFILE	Update Profile	cd0a239f-f540-49da-a4c3-8f57fd497cb4	t	f	UPDATE_PROFILE	40
a04987b6-39df-417e-90b2-26b1090c4afe	CONFIGURE_TOTP	Configure OTP	cd0a239f-f540-49da-a4c3-8f57fd497cb4	t	f	CONFIGURE_TOTP	10
effeb988-e83d-421d-bf14-9cc828af11dc	UPDATE_PASSWORD	Update Password	cd0a239f-f540-49da-a4c3-8f57fd497cb4	t	f	UPDATE_PASSWORD	30
b9098800-60e4-4962-9a53-5dcec094109b	terms_and_conditions	Terms and Conditions	cd0a239f-f540-49da-a4c3-8f57fd497cb4	f	f	terms_and_conditions	20
99a4c682-17cb-4436-bbda-3fa8c989f5e9	update_user_locale	Update User Locale	cd0a239f-f540-49da-a4c3-8f57fd497cb4	t	f	update_user_locale	1000
9b453203-eed3-4e3b-8d92-b4d762272c5c	delete_account	Delete Account	cd0a239f-f540-49da-a4c3-8f57fd497cb4	f	f	delete_account	60
\.


--
-- TOC entry 3898 (class 0 OID 83473)
-- Dependencies: 296
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- TOC entry 3878 (class 0 OID 83046)
-- Dependencies: 276
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- TOC entry 3877 (class 0 OID 83031)
-- Dependencies: 275
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- TOC entry 3872 (class 0 OID 82965)
-- Dependencies: 270
-- Data for Name: resource_server; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- TOC entry 3897 (class 0 OID 83449)
-- Dependencies: 295
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- TOC entry 3875 (class 0 OID 83003)
-- Dependencies: 273
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- TOC entry 3873 (class 0 OID 82973)
-- Dependencies: 271
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- TOC entry 3874 (class 0 OID 82988)
-- Dependencies: 272
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- TOC entry 3899 (class 0 OID 83492)
-- Dependencies: 297
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.resource_uris (resource_id, value) FROM stdin;
\.


--
-- TOC entry 3900 (class 0 OID 83502)
-- Dependencies: 298
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- TOC entry 3825 (class 0 OID 82067)
-- Dependencies: 223
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.scope_mapping (client_id, role_id) FROM stdin;
7b7142af-e684-45b1-8b3e-cdbd34877635	6b34fc9f-2cfc-4c1f-9f99-c2314742f37d
4d364ac2-1ae1-4e14-84e3-8a108277c05d	ecb7c80e-3a4c-4f97-b56e-900f697d9195
\.


--
-- TOC entry 3879 (class 0 OID 83061)
-- Dependencies: 277
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- TOC entry 3827 (class 0 OID 82073)
-- Dependencies: 225
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- TOC entry 3849 (class 0 OID 82526)
-- Dependencies: 247
-- Data for Name: user_consent; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 3895 (class 0 OID 83424)
-- Dependencies: 293
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 3828 (class 0 OID 82079)
-- Dependencies: 226
-- Data for Name: user_entity; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
eebbe7fa-13c8-485f-b5ad-17906528e47b	\N	e522b252-4855-49a4-a73c-f42b19cfeae7	f	t	\N	\N	\N	master	admin	1609664564548	\N	0
5caab7e1-4e26-4fc7-8c7a-cb1105d0480b	\N	2ef3d192-fe25-4628-9853-fef215b4a4c3	f	t	\N	\N	\N	cd0a239f-f540-49da-a4c3-8f57fd497cb4	sample	1609664609593	\N	0
\.


--
-- TOC entry 3829 (class 0 OID 82088)
-- Dependencies: 227
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 3856 (class 0 OID 82642)
-- Dependencies: 254
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- TOC entry 3857 (class 0 OID 82648)
-- Dependencies: 255
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 3830 (class 0 OID 82094)
-- Dependencies: 228
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- TOC entry 3867 (class 0 OID 82818)
-- Dependencies: 265
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- TOC entry 3831 (class 0 OID 82100)
-- Dependencies: 229
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- TOC entry 3832 (class 0 OID 82103)
-- Dependencies: 230
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.user_role_mapping (role_id, user_id) FROM stdin;
d01a17e2-11c6-44a1-b36e-f79593346796	eebbe7fa-13c8-485f-b5ad-17906528e47b
19bdd7e5-17b4-4e91-ad47-17496a9ecb8a	eebbe7fa-13c8-485f-b5ad-17906528e47b
ecee88a7-b0cb-40a1-bc3b-dee2d680d51a	eebbe7fa-13c8-485f-b5ad-17906528e47b
6b34fc9f-2cfc-4c1f-9f99-c2314742f37d	eebbe7fa-13c8-485f-b5ad-17906528e47b
8683c126-2702-4da9-bc75-f205e1201585	eebbe7fa-13c8-485f-b5ad-17906528e47b
d8c6bfe1-f42a-4807-b14a-0151975e5146	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b
bcc590f0-b6bf-4eee-afe9-aea0acb387b4	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b
ecb7c80e-3a4c-4f97-b56e-900f697d9195	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b
2bd10fb2-e2a1-4695-955c-bce0bb624e93	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b
9e656de5-36d0-4182-9f73-7ced7472d57e	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b
\.


--
-- TOC entry 3833 (class 0 OID 82106)
-- Dependencies: 231
-- Data for Name: user_session; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- TOC entry 3844 (class 0 OID 82421)
-- Dependencies: 242
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- TOC entry 3826 (class 0 OID 82070)
-- Dependencies: 224
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- TOC entry 3834 (class 0 OID 82119)
-- Dependencies: 232
-- Data for Name: web_origins; Type: TABLE DATA; Schema: keycloak; Owner: -
--

COPY keycloak.web_origins (client_id, value) FROM stdin;
3c40435d-0d15-4f87-9d63-5399cbaf4639	+
eeac28db-e546-4cbd-8d1d-ea2bf0077028	+
572824ad-4fe5-41da-8fd1-c3ba5661374c	*
\.


--
-- TOC entry 3805 (class 0 OID 16385)
-- Dependencies: 203
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.1	Item	SQL	V1.1__Item.sql	572695683	dev	2020-03-07 12:13:47.833944	17	t
2	1.2	Item	SQL	V1.2__Item.sql	-1657134404	dev	2021-01-03 08:22:57.101472	21	t
3	1.3	Item	SQL	V1.3__Item.sql	958239504	dev	2021-01-09 11:14:56.751974	58	t
\.


--
-- TOC entry 3807 (class 0 OID 24579)
-- Dependencies: 205
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.items (id, name, description, status, type, created, updated, guid, published, is_public, created_by, updated_by) FROM stdin;
4	Submission	\N	DRAFT	PERSONAL	2020-03-07 12:18:35.008941	2020-03-07 12:18:35.008945	8c6afaa7-bc67-ce76-e435-84fc9f1f14bf	\N	f	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b
1	Plan project 	\N	DRAFT	PERSONAL	2020-03-07 12:18:09.539491	2020-03-07 12:20:06.458977	3ab91119-4db9-0192-cc5d-2093f00b5222	\N	f	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b
2	Demo	demo test	DONE	PERSONAL	2020-03-07 12:18:21.122661	2020-03-07 12:18:21.122673	ab61f89d-1995-e722-1acf-eb385bb393e8	2020-03-07 12:18:21	t	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b
3	Presentaation	presenation	DONE	PERSONAL	2020-03-07 12:18:28.34067	2020-03-07 12:18:28.340674	a18c127a-8a42-bcdc-172e-af26548c2017	2020-03-07 12:18:21	t	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b
5	EditItem	EditItemDescription	DRAFT	PERSONAL	2021-03-06 07:54:13.136981	2021-03-06 07:54:13.136981	8e07bf06-6334-45a5-b3ef-33ee5c82d4b0	\N	f	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b
6	DeleteItem	DeleteItemDescription	DRAFT	PERSONAL	2021-03-06 07:54:20.474162	2021-03-06 07:54:20.474162	806bee1c-e2ef-4d9d-8c90-028496794e68	\N	f	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b
7	SearchItem	SearchItemDescription	DRAFT	PERSONAL	2021-03-06 07:54:28.321819	2021-03-06 07:54:28.321819	b30f983c-c973-427e-b0ef-a75763a45183	\N	f	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b	5caab7e1-4e26-4fc7-8c7a-cb1105d0480b
\.


--
-- TOC entry 3908 (class 0 OID 0)
-- Dependencies: 204
-- Name: item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.item_id_seq', 7, true);


--
-- TOC entry 3362 (class 2606 OID 83215)
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- TOC entry 3330 (class 2606 OID 83529)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3570 (class 2606 OID 83354)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3572 (class 2606 OID 83397)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3567 (class 2606 OID 83229)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3484 (class 2606 OID 82860)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3532 (class 2606 OID 83148)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3458 (class 2606 OID 82765)
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- TOC entry 3305 (class 2606 OID 83323)
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3558 (class 2606 OID 83168)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3561 (class 2606 OID 83166)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3550 (class 2606 OID 83164)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3534 (class 2606 OID 83150)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3537 (class 2606 OID 83152)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3542 (class 2606 OID 83158)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3546 (class 2606 OID 83160)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3554 (class 2606 OID 83162)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3565 (class 2606 OID 83208)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3486 (class 2606 OID 83313)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3418 (class 2606 OID 83330)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3349 (class 2606 OID 83332)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3413 (class 2606 OID 83334)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3406 (class 2606 OID 82431)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3390 (class 2606 OID 82359)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3327 (class 2606 OID 82131)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3402 (class 2606 OID 82433)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3336 (class 2606 OID 82133)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3318 (class 2606 OID 82135)
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- TOC entry 3385 (class 2606 OID 82137)
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- TOC entry 3376 (class 2606 OID 82139)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3392 (class 2606 OID 82361)
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- TOC entry 3310 (class 2606 OID 82143)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3315 (class 2606 OID 82145)
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- TOC entry 3359 (class 2606 OID 82147)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3394 (class 2606 OID 82363)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3341 (class 2606 OID 82149)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3352 (class 2606 OID 82151)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3332 (class 2606 OID 82153)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3436 (class 2606 OID 83317)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3448 (class 2606 OID 82670)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3444 (class 2606 OID 82668)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3441 (class 2606 OID 82666)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3438 (class 2606 OID 82664)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3456 (class 2606 OID 82674)
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- TOC entry 3382 (class 2606 OID 82155)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3320 (class 2606 OID 83311)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3434 (class 2606 OID 82551)
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- TOC entry 3411 (class 2606 OID 82435)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3518 (class 2606 OID 83025)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3354 (class 2606 OID 82157)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3324 (class 2606 OID 82159)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3374 (class 2606 OID 82161)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3585 (class 2606 OID 83453)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3503 (class 2606 OID 82980)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3513 (class 2606 OID 83010)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3529 (class 2606 OID 83080)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3523 (class 2606 OID 83050)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3508 (class 2606 OID 82995)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3520 (class 2606 OID 83035)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3526 (class 2606 OID 83065)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3367 (class 2606 OID 82163)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3454 (class 2606 OID 82678)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3450 (class 2606 OID 82676)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3583 (class 2606 OID 83438)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3580 (class 2606 OID 83428)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3429 (class 2606 OID 82545)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3471 (class 2606 OID 82827)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3478 (class 2606 OID 82834)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3475 (class 2606 OID 82848)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3424 (class 2606 OID 82541)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3427 (class 2606 OID 82727)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3421 (class 2606 OID 82539)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3468 (class 2606 OID 83536)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3465 (class 2606 OID 82802)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3396 (class 2606 OID 82429)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3400 (class 2606 OID 82720)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3344 (class 2606 OID 83309)
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- TOC entry 3356 (class 2606 OID 83336)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3463 (class 2606 OID 82763)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3460 (class 2606 OID 82761)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3379 (class 2606 OID 82672)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3591 (class 2606 OID 83501)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3593 (class 2606 OID 83509)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3364 (class 2606 OID 82759)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3481 (class 2606 OID 82841)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3416 (class 2606 OID 82439)
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- TOC entry 3387 (class 2606 OID 83338)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3495 (class 2606 OID 82946)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3490 (class 2606 OID 82905)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3303 (class 2606 OID 81958)
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- TOC entry 3501 (class 2606 OID 83291)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3499 (class 2606 OID 82934)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3578 (class 2606 OID 83413)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3596 (class 2606 OID 83555)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3589 (class 2606 OID 83481)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3473 (class 2606 OID 83221)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3409 (class 2606 OID 82486)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3308 (class 2606 OID 82165)
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- TOC entry 3313 (class 2606 OID 82167)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3492 (class 2606 OID 83366)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3370 (class 2606 OID 82171)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3506 (class 2606 OID 83545)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3587 (class 2606 OID 83540)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3516 (class 2606 OID 83282)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3511 (class 2606 OID 83286)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3347 (class 2606 OID 82173)
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- TOC entry 3432 (class 2606 OID 83531)
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3339 (class 2606 OID 82179)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3372 (class 2606 OID 83210)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3296 (class 2606 OID 16393)
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- TOC entry 3299 (class 2606 OID 24587)
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- TOC entry 3530 (class 1259 OID 83235)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON keycloak.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3439 (class 1259 OID 83239)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_auth_config_realm ON keycloak.authenticator_config USING btree (realm_id);


--
-- TOC entry 3445 (class 1259 OID 83237)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_auth_exec_flow ON keycloak.authentication_execution USING btree (flow_id);


--
-- TOC entry 3446 (class 1259 OID 83236)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_auth_exec_realm_flow ON keycloak.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3442 (class 1259 OID 83238)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_auth_flow_realm ON keycloak.authentication_flow USING btree (realm_id);


--
-- TOC entry 3573 (class 1259 OID 83445)
-- Name: idx_cl_clscope; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_cl_clscope ON keycloak.client_scope_client USING btree (scope_id);


--
-- TOC entry 3306 (class 1259 OID 83241)
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_client_def_roles_client ON keycloak.client_default_roles USING btree (client_id);


--
-- TOC entry 3311 (class 1259 OID 83546)
-- Name: idx_client_id; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_client_id ON keycloak.client USING btree (client_id);


--
-- TOC entry 3568 (class 1259 OID 83279)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_client_init_acc_realm ON keycloak.client_initial_access USING btree (realm_id);


--
-- TOC entry 3316 (class 1259 OID 83243)
-- Name: idx_client_session_session; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_client_session_session ON keycloak.client_session USING btree (session_id);


--
-- TOC entry 3493 (class 1259 OID 83443)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_clscope_attrs ON keycloak.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3574 (class 1259 OID 83444)
-- Name: idx_clscope_cl; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_clscope_cl ON keycloak.client_scope_client USING btree (client_id);


--
-- TOC entry 3397 (class 1259 OID 83440)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_clscope_protmap ON keycloak.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3496 (class 1259 OID 83441)
-- Name: idx_clscope_role; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_clscope_role ON keycloak.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3559 (class 1259 OID 83245)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_compo_config_compo ON keycloak.component_config USING btree (component_id);


--
-- TOC entry 3562 (class 1259 OID 83516)
-- Name: idx_component_provider_type; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_component_provider_type ON keycloak.component USING btree (provider_type);


--
-- TOC entry 3563 (class 1259 OID 83244)
-- Name: idx_component_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_component_realm ON keycloak.component USING btree (realm_id);


--
-- TOC entry 3321 (class 1259 OID 83246)
-- Name: idx_composite; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_composite ON keycloak.composite_role USING btree (composite);


--
-- TOC entry 3322 (class 1259 OID 83247)
-- Name: idx_composite_child; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_composite_child ON keycloak.composite_role USING btree (child_role);


--
-- TOC entry 3575 (class 1259 OID 83446)
-- Name: idx_defcls_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_defcls_realm ON keycloak.default_client_scope USING btree (realm_id);


--
-- TOC entry 3576 (class 1259 OID 83447)
-- Name: idx_defcls_scope; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_defcls_scope ON keycloak.default_client_scope USING btree (scope_id);


--
-- TOC entry 3328 (class 1259 OID 83547)
-- Name: idx_event_time; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_event_time ON keycloak.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3403 (class 1259 OID 82964)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_fedidentity_feduser ON keycloak.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3404 (class 1259 OID 82963)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_fedidentity_user ON keycloak.federated_identity USING btree (user_id);


--
-- TOC entry 3535 (class 1259 OID 83339)
-- Name: idx_fu_attribute; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_fu_attribute ON keycloak.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3538 (class 1259 OID 83360)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_fu_cnsnt_ext ON keycloak.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3539 (class 1259 OID 83527)
-- Name: idx_fu_consent; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_fu_consent ON keycloak.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3540 (class 1259 OID 83341)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_fu_consent_ru ON keycloak.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3543 (class 1259 OID 83342)
-- Name: idx_fu_credential; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_fu_credential ON keycloak.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3544 (class 1259 OID 83343)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_fu_credential_ru ON keycloak.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3547 (class 1259 OID 83344)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_fu_group_membership ON keycloak.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3548 (class 1259 OID 83345)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_fu_group_membership_ru ON keycloak.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3551 (class 1259 OID 83346)
-- Name: idx_fu_required_action; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_fu_required_action ON keycloak.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3552 (class 1259 OID 83347)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_fu_required_action_ru ON keycloak.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3555 (class 1259 OID 83348)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_fu_role_mapping ON keycloak.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3556 (class 1259 OID 83349)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_fu_role_mapping_ru ON keycloak.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3479 (class 1259 OID 83250)
-- Name: idx_group_attr_group; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_group_attr_group ON keycloak.group_attribute USING btree (group_id);


--
-- TOC entry 3476 (class 1259 OID 83251)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_group_role_mapp_group ON keycloak.group_role_mapping USING btree (group_id);


--
-- TOC entry 3425 (class 1259 OID 83253)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_id_prov_mapp_realm ON keycloak.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3407 (class 1259 OID 83252)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_ident_prov_realm ON keycloak.identity_provider USING btree (realm_id);


--
-- TOC entry 3333 (class 1259 OID 83254)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_keycloak_role_client ON keycloak.keycloak_role USING btree (client);


--
-- TOC entry 3334 (class 1259 OID 83255)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_keycloak_role_realm ON keycloak.keycloak_role USING btree (realm);


--
-- TOC entry 3466 (class 1259 OID 83520)
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_offline_uss_createdon ON keycloak.offline_user_session USING btree (created_on);


--
-- TOC entry 3398 (class 1259 OID 83256)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_protocol_mapper_client ON keycloak.protocol_mapper USING btree (client_id);


--
-- TOC entry 3342 (class 1259 OID 83259)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_realm_attr_realm ON keycloak.realm_attribute USING btree (realm_id);


--
-- TOC entry 3488 (class 1259 OID 83439)
-- Name: idx_realm_clscope; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_realm_clscope ON keycloak.client_scope USING btree (realm_id);


--
-- TOC entry 3487 (class 1259 OID 83260)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_realm_def_grp_realm ON keycloak.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3345 (class 1259 OID 83261)
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_realm_def_roles_realm ON keycloak.realm_default_roles USING btree (realm_id);


--
-- TOC entry 3350 (class 1259 OID 83263)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_realm_evt_list_realm ON keycloak.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3419 (class 1259 OID 83262)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_realm_evt_types_realm ON keycloak.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3337 (class 1259 OID 83258)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_realm_master_adm_cli ON keycloak.realm USING btree (master_admin_client);


--
-- TOC entry 3414 (class 1259 OID 83264)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_realm_supp_local_realm ON keycloak.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3357 (class 1259 OID 83265)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_redir_uri_client ON keycloak.redirect_uris USING btree (client_id);


--
-- TOC entry 3461 (class 1259 OID 83266)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_req_act_prov_realm ON keycloak.required_action_provider USING btree (realm_id);


--
-- TOC entry 3524 (class 1259 OID 83267)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_res_policy_policy ON keycloak.resource_policy USING btree (policy_id);


--
-- TOC entry 3521 (class 1259 OID 83268)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_res_scope_scope ON keycloak.resource_scope USING btree (scope_id);


--
-- TOC entry 3514 (class 1259 OID 83287)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_res_serv_pol_res_serv ON keycloak.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3504 (class 1259 OID 83288)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_res_srv_res_res_srv ON keycloak.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3509 (class 1259 OID 83289)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_res_srv_scope_res_srv ON keycloak.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3594 (class 1259 OID 83515)
-- Name: idx_role_attribute; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_role_attribute ON keycloak.role_attribute USING btree (role_id);


--
-- TOC entry 3497 (class 1259 OID 83442)
-- Name: idx_role_clscope; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_role_clscope ON keycloak.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3360 (class 1259 OID 83272)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_scope_mapping_role ON keycloak.scope_mapping USING btree (role_id);


--
-- TOC entry 3527 (class 1259 OID 83273)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_scope_policy_policy ON keycloak.scope_policy USING btree (policy_id);


--
-- TOC entry 3422 (class 1259 OID 83525)
-- Name: idx_update_time; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_update_time ON keycloak.migration_model USING btree (update_time);


--
-- TOC entry 3469 (class 1259 OID 82953)
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON keycloak.offline_client_session USING btree (user_session_id);


--
-- TOC entry 3581 (class 1259 OID 83448)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_usconsent_clscope ON keycloak.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3365 (class 1259 OID 82960)
-- Name: idx_user_attribute; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_user_attribute ON keycloak.user_attribute USING btree (user_id);


--
-- TOC entry 3430 (class 1259 OID 82957)
-- Name: idx_user_consent; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_user_consent ON keycloak.user_consent USING btree (user_id);


--
-- TOC entry 3325 (class 1259 OID 82961)
-- Name: idx_user_credential; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_user_credential ON keycloak.credential USING btree (user_id);


--
-- TOC entry 3368 (class 1259 OID 82954)
-- Name: idx_user_email; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_user_email ON keycloak.user_entity USING btree (email);


--
-- TOC entry 3482 (class 1259 OID 82956)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_user_group_mapping ON keycloak.user_group_membership USING btree (user_id);


--
-- TOC entry 3380 (class 1259 OID 82962)
-- Name: idx_user_reqactions; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_user_reqactions ON keycloak.user_required_action USING btree (user_id);


--
-- TOC entry 3383 (class 1259 OID 82955)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_user_role_mapping ON keycloak.user_role_mapping USING btree (user_id);


--
-- TOC entry 3451 (class 1259 OID 83275)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_usr_fed_map_fed_prv ON keycloak.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3452 (class 1259 OID 83276)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_usr_fed_map_realm ON keycloak.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3377 (class 1259 OID 83277)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_usr_fed_prv_realm ON keycloak.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3388 (class 1259 OID 83278)
-- Name: idx_web_orig_client; Type: INDEX; Schema: keycloak; Owner: -
--

CREATE INDEX idx_web_orig_client ON keycloak.web_origins USING btree (client_id);


--
-- TOC entry 3297 (class 1259 OID 16394)
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- TOC entry 3300 (class 1259 OID 73769)
-- Name: ix_items_guid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_items_guid ON public.items USING btree (guid);


--
-- TOC entry 3301 (class 1259 OID 98337)
-- Name: ix_items_published; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_items_published ON public.items USING btree (published);


--
-- TOC entry 3641 (class 2606 OID 82679)
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3625 (class 2606 OID 82440)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3618 (class 2606 OID 82364)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3624 (class 2606 OID 82450)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3620 (class 2606 OID 82599)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3619 (class 2606 OID 82369)
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3628 (class 2606 OID 82480)
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES keycloak.user_session(id);


--
-- TOC entry 3600 (class 2606 OID 82182)
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3610 (class 2606 OID 82187)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3614 (class 2606 OID 82192)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3633 (class 2606 OID 82577)
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3608 (class 2606 OID 82202)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3676 (class 2606 OID 83482)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3612 (class 2606 OID 82207)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3615 (class 2606 OID 82217)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3604 (class 2606 OID 82222)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES keycloak.realm(id);


--
-- TOC entry 3609 (class 2606 OID 82227)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3605 (class 2606 OID 82242)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3601 (class 2606 OID 82247)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 3637 (class 2606 OID 82699)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES keycloak.authentication_flow(id);


--
-- TOC entry 3636 (class 2606 OID 82694)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3635 (class 2606 OID 82689)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3634 (class 2606 OID 82684)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3599 (class 2606 OID 82252)
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES keycloak.user_session(id);


--
-- TOC entry 3616 (class 2606 OID 82257)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3667 (class 2606 OID 83398)
-- Name: client_scope_client fk_c_cli_scope_client; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_client FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3668 (class 2606 OID 83403)
-- Name: client_scope_client fk_c_cli_scope_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 3650 (class 2606 OID 83387)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 3651 (class 2606 OID 83377)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 3642 (class 2606 OID 82771)
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3622 (class 2606 OID 83372)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 3666 (class 2606 OID 83230)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3664 (class 2606 OID 83174)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES keycloak.component(id);


--
-- TOC entry 3665 (class 2606 OID 83169)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3648 (class 2606 OID 82861)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3606 (class 2606 OID 82267)
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3640 (class 2606 OID 82714)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES keycloak.user_federation_mapper(id);


--
-- TOC entry 3639 (class 2606 OID 82709)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES keycloak.user_federation_provider(id);


--
-- TOC entry 3638 (class 2606 OID 82704)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3663 (class 2606 OID 83086)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3661 (class 2606 OID 83071)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3672 (class 2606 OID 83454)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 3652 (class 2606 OID 83297)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 3673 (class 2606 OID 83459)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3674 (class 2606 OID 83464)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 3662 (class 2606 OID 83081)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3660 (class 2606 OID 83066)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 3675 (class 2606 OID 83487)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3654 (class 2606 OID 83292)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 3656 (class 2606 OID 83036)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3658 (class 2606 OID 83051)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3659 (class 2606 OID 83056)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3657 (class 2606 OID 83041)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 3653 (class 2606 OID 83302)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 3602 (class 2606 OID 82272)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 3671 (class 2606 OID 83429)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES keycloak.user_consent(id);


--
-- TOC entry 3632 (class 2606 OID 82562)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3646 (class 2606 OID 82835)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES keycloak.keycloak_group(id);


--
-- TOC entry 3644 (class 2606 OID 82828)
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3645 (class 2606 OID 82849)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES keycloak.keycloak_group(id);


--
-- TOC entry 3629 (class 2606 OID 82506)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3607 (class 2606 OID 82282)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3630 (class 2606 OID 82552)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3631 (class 2606 OID 82728)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES keycloak.identity_provider_mapper(id);


--
-- TOC entry 3617 (class 2606 OID 82292)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3597 (class 2606 OID 83324)
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3611 (class 2606 OID 82302)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3598 (class 2606 OID 82312)
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3621 (class 2606 OID 82445)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3603 (class 2606 OID 82317)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3623 (class 2606 OID 82721)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES keycloak.protocol_mapper(id);


--
-- TOC entry 3669 (class 2606 OID 83414)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3670 (class 2606 OID 83419)
-- Name: default_client_scope fk_r_def_cli_scope_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 3649 (class 2606 OID 83367)
-- Name: client_scope fk_realm_cli_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.client_scope
    ADD CONSTRAINT fk_realm_cli_scope FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3643 (class 2606 OID 82766)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3677 (class 2606 OID 83495)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3678 (class 2606 OID 83510)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 3627 (class 2606 OID 82475)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3613 (class 2606 OID 82337)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES keycloak.user_federation_provider(id);


--
-- TOC entry 3647 (class 2606 OID 82842)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3655 (class 2606 OID 83026)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3626 (class 2606 OID 82455)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: keycloak; Owner: -
--

ALTER TABLE ONLY keycloak.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES keycloak.identity_provider(internal_id);


-- Completed on 2021-10-30 08:46:01

--
-- PostgreSQL database dump complete
--

