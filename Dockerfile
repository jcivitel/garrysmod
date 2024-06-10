###########################################################
# Dockerfile that builds a Garry's Mod Gameserver
###########################################################
FROM cm2network/steamcmd:root as build_stage

MAINTAINER jan@civitelli.de

ENV STEAMAPPID 4020
ENV STEAMAPP gm
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

COPY etc/entry.sh "${HOMEDIR}/entry.sh"

RUN set -x \
	# Install, update & upgrade packages
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget \
		ca-certificates \
		lib32z1 \
	&& mkdir -p "${STEAMAPPDIR}" \
	# Add entry script
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	# Clean up
	&& rm -rf /var/lib/apt/lists/* 

FROM build_stage AS bullseye-base

ENV GM_SERVERNAME="New \"${STEAMAPP}\" Server" \
    GM_PORT=27015 \
    GM_PW="changeme" \
	GM_MAXPLAYERS=10 \
    GM_LOCATION="eu" \
	GM_GAMEMODE="terrortown" \
	GM_WORKSHOP="" \
	GM_MAP="" \
    GM_STEAMTOKEN="changeme"


# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# 27015/udp = game traffic
# 27015/tcp = rcon traffic
EXPOSE 27015/tcp \
	27015/udp