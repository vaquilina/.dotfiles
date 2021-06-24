#!/bin/sh

STATUS=$(nordvpn status | grep Status | tr -d ' ' | cut -d ':' -f2)

if [ "$STATUS" = "Connected" ]; then
	    echo "%{F#82E0AA}%{A1:nordvpn d:}$(nordvpn status | grep City | cut -d ':' -f2)%{A}%{F-} 嬨  "
    else
	        echo "%{F#800}%{A1:nordvpn c:} %{A}%{F-} 嬨  "
fi
