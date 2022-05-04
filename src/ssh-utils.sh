function ssh-agent-attach-or-start {
  test -z $SSH_AGENT_PID || return 0

  local socket_home=$HOME/.local/var/ssh
  local agent_socket=$socket_home/ssh-agent-socket

  SSH_AGENT_PID=`ps -ef | awk '$8 ~ "ssh-agent"  {print $2}'`
  if [[ $SSH_AGENT_PID =~ [0-9]+ ]]; then
    SSH_AUTH_SOCK=$agent_socket

    export SSH_AGENT_PID
    export SSH_AUTH_SOCK

    return 0
  fi

  test -e $agent_socket && rm $agent_socket
  test -d $socket_home || mkdir -p $socket_home

  eval `ssh-agent -s -a $agent_socket`
}
