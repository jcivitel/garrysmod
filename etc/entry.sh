#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true

# Download Updates

bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
				+login "anonymous" \
				+app_update "${STEAMAPPID}" \
				+quit

# Switch to server directory
cd "${STEAMAPPDIR}"

# Start Server
./srcds_run -game garrysmod \
	-port "${GM_PORT}" \
	-console \
	-usercon \
	-maxplayers "${GM_MAXPLAYERS}" \
	+sv_password "${GM_PW}" \
 	+hostname "${GM_SERVERNAME}" \
	+gamemode "${GM_GAMEMODE}" \
	+host_workshop_collection "${GM_WORKSHOP}" \
	+map "${GM_MAP}" \
	+sv_setsteamaccount "${GM_STEAMTOKEN}" \
    +sv_location "${GM_LOCATION}"