# Use the official Keycloak image as the base
FROM quay.io/keycloak/keycloak:25.0 AS builder

# Configure build options
ARG IMAGE_BUILD_TIMESTAMP
ENV IMAGE_BUILD_TIMESTAMP=${IMAGE_BUILD_TIMESTAMP}
RUN echo IMAGE_BUILD_TIMESTAMP=${IMAGE_BUILD_TIMESTAMP}

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build --health-enabled=true --metrics-enabled=true

FROM quay.io/keycloak/keycloak:25.0
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV TZ="Australia/Sydney"

# Set the entrypoint to start Keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

# Start Keycloak with custom options
CMD ["start", "--https-port=8443", "--http-enabled=false", "--optimized", "--import-realm"]