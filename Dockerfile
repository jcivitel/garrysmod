###########################################################
# Dockerfile that builds a Garry's Mod Gameserver
###########################################################
FROM cm2network/steamcmd:root as build_stage

LABEL maintainer="jan@civitelli.de"

ENV STEAMAPPID 4020
ENV STEAMAPP GM
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

COPY etc/entry.sh "${HOMEDIR}/entry.sh"

RUN set -x \
	# Install, update & upgrade packages
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.21-1+deb11u1 \
		ca-certificates=20210119 \
		lib32z1=1:1.2.11.dfsg-2+deb11u2 \
	&& mkdir -p "${STEAMAPPDIR}" \
	# Add entry script
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	# Clean up
	&& rm -rf /var/lib/apt/lists/* 

FROM build_stage AS bullseye-base

ENV GM_SERVERNAME="New \"${STEAMAPP}\" Server" \
    GM2_PORT=27015 \
    GM_PW="changeme" \
    GM_LOCATION="eu" \
    GM_STEAMTOKEN="changeme"


# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# 27015/udp = game traffic
# 27015/tcp = rcon traffic
EXPOSE 27015/tcp \
	27015/udp