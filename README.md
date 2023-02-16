# distroless-base-image

A hardened distroless container base image

This project creates a distroless base container image

## How it was created

The Dockerfile was reduced to 2 sections:

1. Download and unpack necessary files from Debian rootfs - (distroless layer)
2. Copy unpacked files to new "image from scratch"
