FROM --platform=linux/amd64 debian:bullseye-slim

# Install necessary packages and dependencies
RUN apt-get update && \
    apt-get install -y curl unzip wget ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and extract the Minecraft Bedrock server
ARG BEDROCK_SERVER_VERSION=1.21.20.21
RUN mkdir -p /bedrock-server
WORKDIR /bedrock-server
RUN curl -L -o bedrock-server.zip https://minecraft.azureedge.net/bin-linux/bedrock-server-1.21.1.03.zip     && \
    unzip bedrock-server.zip && \
    rm bedrock-server.zip

# Set up environment variables (adjust as needed)
ENV EULA=TRUE \
    SERVER_NAME="GamersPro Bedrock Server" \
    LEVEL_NAME="Bedrock Level" \
    GAMEMODE=survival \
    DIFFICULTY=easy \
    ALLOW_CHEATS=true \
    MAX_PLAYERS=10 \
    TZ="Europe/Athens" \
    MODS_FILE=/extras/mods.txt \
    REMOVE_OLD_MODS=true

# Create the permissions file and accept the EULA
RUN echo "eula=$EULA" > eula.txt

# Expose the necessary port
EXPOSE 19132/udp

# Start the Minecraft Bedrock server
CMD ["./bedrock_server"]
