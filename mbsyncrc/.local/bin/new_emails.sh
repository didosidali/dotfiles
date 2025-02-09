#!/bin/bash
mbsync -Va #1>/dev/null 2>&1 &

MAILDIR="$HOME/.local/share/mail/*/"
PROCESSED_FILE="$HOME/.cache/processed_emails.txt"

touch "$PROCESSED_FILE"

for MAIL_ACCOUNT in $MAILDIR; do
    MAIL_ACCOUNT=${MAIL_ACCOUNT%*/}
    NEW_MAIL_DIR="${MAIL_ACCOUNT}/INBOX/new"
    for email_file in "$NEW_MAIL_DIR"/*; do
        if grep -q "$(basename "$email_file")" "$PROCESSED_FILE"; then
            continue
        fi

        subject=$(grep -m 1 "^Subject:" "$email_file" | sed 's/^Subject: //; s/^[ \t]*//; s/[ \t]*$//')

        subject=$(echo "$subject" | perl -MEncode -ne 'print decode("MIME-Header", $_)')

        notify-send "$(basename "$MAIL_ACCOUNT"):" "$subject" -i $HOME/.icons/Email.png

        echo "$(basename "$email_file")" >> "$PROCESSED_FILE"
    done
done
