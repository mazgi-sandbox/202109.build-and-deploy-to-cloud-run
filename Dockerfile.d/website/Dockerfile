# ================================
# Begin builder stage
FROM ghcr.io/mazgi/hugo-static-website as builder
COPY rootfs/workspace /workspace
WORKDIR /workspace

RUN hugo
# End builder stage
# ================================

# ================================
# Begin runner stage
FROM nginx:alpine as runner
COPY --from=builder /workspace/public /usr/share/nginx/html
# ================================
