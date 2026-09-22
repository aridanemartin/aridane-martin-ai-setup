---
name: send-whatsapp-to-aridane
description: Send a WhatsApp message to Aridane via the CallMeBot API. Use when the user wants to send a notification, reminder, or message to themselves on WhatsApp.
license: MIT
metadata:
  author: aridane-martin
  version: "1.0"
  scope: root
---

# Send WhatsApp to Aridane

Sends a WhatsApp message to Aridane's phone using the CallMeBot free API.

## When to Use

- "Send me a WhatsApp saying X"
- "Notify me on WhatsApp when X is done"
- "WhatsApp me: [message]"
- End of a long task: proactively offer to send a WhatsApp summary

## Setup Required

The skill reads the API key from the `CALLMEBOT_APIKEY` environment variable.

If the variable is not set, tell the user:
> Set your CallMeBot API key: `export CALLMEBOT_APIKEY=your_key_here` (add to ~/.zshrc to persist it).
> Get your key by sending "I allow callmebot to send me messages" to +34 644 59 87 82 on WhatsApp.

## How to Send

Run this Bash command (one line):

```bash
curl -s "https://api.callmebot.com/whatsapp.php?phone=${CALLMEBOT_PHONE}&text=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "<MESSAGE>"  )&apikey=$CALLMEBOT_APIKEY"
```

Or use this equivalent approach with URLSearchParams-style encoding via curl's `--data-urlencode`:

```bash
curl -sG "https://api.callmebot.com/whatsapp.php" \
  --data-urlencode "phone=${CALLMEBOT_PHONE}" \
  --data-urlencode "text=<MESSAGE>" \
  --data-urlencode "apikey=$CALLMEBOT_APIKEY"
```

## Steps

1. Check that `$CALLMEBOT_APIKEY` is set. If not, show the setup instructions above and stop.
2. Compose the message text — use the user's exact wording, or a concise summary if sending a task result.
3. Run the curl command substituting `<MESSAGE>` with the actual message.
4. Report the API response to the user:
   - `Message Sent` → success
   - Any error → show the raw response and suggest checking the API key or phone registration.

## Notes

- Phone is always `${CALLMEBOT_PHONE}` (Aridane's number, Spain +34).
- The API is free but rate-limited — avoid sending more than one message per second.
- Messages are delivered via WhatsApp from the CallMeBot contact.
