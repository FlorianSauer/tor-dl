if [ -z "$exit_nodes" ]; then
	echo "Please set \$exit_nodes"
    exit 1
else
    echo "ExitNodes" $exit_nodes >> /etc/tor/torrc
fi

if ! pgrep -x "tor" > /dev/null
then
    service tor start
fi
