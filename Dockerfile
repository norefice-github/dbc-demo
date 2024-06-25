FROM rust:1.77 AS builder
WORKDIR /src
COPY Cargo.toml Cargo.lock ./
RUN mkdir src && echo "fn main() {println!(\"if you see this, the build broke\")}" > src/main.rs
RUN cargo build --release
COPY . .
RUN --mount=type=cache,target=/usr/local/cargo/git \
    --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,sharing=private,target=/src/target \
    cargo install --path .

FROM debian:bookworm-slim
COPY --from=builder /usr/local/cargo/bin/dbc-demo /usr/local/bin/dbc-demo
ENV BIND_ADDR 0.0.0.0:3000
CMD ["dbc-demo"]
