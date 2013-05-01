#!/bin/sh
#only pts
[[ $(echo $TTY|cut -c 6-8) == "tty" ]] && exit 0
# envfile
envfile="${HOME}/.gnupg/gpg-agent.env"
# test if already running
if test -f "$envfile" && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
	eval "$(cat "$envfile")"
	eval $(cut -d= -f1 $envfile|xargs echo export)
else
    #else start it
	eval "$(gpg-agent -s --enable-ssh-support --daemon --write-env-file "$envfile")"
fi
