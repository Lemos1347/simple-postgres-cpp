FROM nixos/nix:latest

WORKDIR /app
COPY . .

# Enable flakes
RUN mkdir -p ~/.config/nix && \
  echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Build the application
RUN nix build

CMD ["nix", "run"]
