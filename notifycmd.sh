#!/bin/bash
GROUP_ID={ Enter Telegram Group-ID inside here, eg. -100123456703 }
BOT_TOKEN={ Enter Telegram-Bot Token inside here, eg. 123456789:ABCDEfGHiJklmN_oPQRstUvwQyz }
NOW=$(date)
case "${NOTIFYTYPE}" in
    ONLINE|COMMOK)
        EMOJI=$'\xE2\x9C\x85' # white heavy check mark
        ;;
    ONBATT|COMMBAD|REPLBATT)
        EMOJI=$'\xE2\x9A\xA0' # warning sign
        ;;
    LOWBATT|FSD|NOCOMM|SHUTDOWN)
        EMOJI=$'\xF0\x9F\x86\x98' # squared sos
        ;;
    NOPARENT)
        EMOJI=$'\xF0\x9F\x94\x84' # anticlockwise downwards and upwards open circle arrows
        ;;
esac
EMOJI+=$'\xEF\xB8\x8F' # The emoji should be displayed with emoji presentation
MESSAGE="${EMOJI} UPS Notification%0A"
MESSAGE+="UPS Name: $UPSNAME %0ANotify type: $NOTIFYTYPE %0ANotify message: $*"
curl \
-s \
--data "parse_mode=HTML" \
--data "text=$MESSAGE" \
--data "chat_id=$GROUP_ID" 'https://api.telegram.org/bot'$BOT_TOKEN'/sendMessage' > /dev/null
