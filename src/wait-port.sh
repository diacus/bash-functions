function wait_port () {
  local port=$1

  nc -vz localhost $port 2> /dev/null
  while [[ $? -ne 0 ]]
  do
    sleep 1
    nc -vz localhost $port 2> /dev/null
  done
}
