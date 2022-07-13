hosts=(hornet cricket newt termite python cicada bumblebee cobra frog tick turtle aphid ladybug chameleon rattlesnake scorpion perch dolphin kangaroo hippo swan gator jaguar rhino grizzly macaw monkey cardinal peacock lion hare raven tiger hawk woodpecker zebra giraffe)

if [ "$#" -lt 1 ]; then
  printf "Usage:\t sh check_ssh.sh [proc_name]\n"
  echo "or"
  printf "\t\tsh check_ssh.sh [proc_name] [hosts]\n"
  echo "sshs over all hosts to find instances of proc name for current user"
elif [ "$#" -eq 1 ]; then
  for i in "${hosts[@]}"; do
    output=$(ssh "$i" ps aux -u "$USER" | grep "$1" | grep "$USER")
    if [ -n "$output" ]; then
      echo "host: $i"
      echo "$output"
      echo "---------"
    fi
  done
else
  for i in "${@:1}"; do
    output=$(ssh "$i" ps aux -u "$USER" | grep "$1"| grep "$USER")
    if [ -n "$output" ]; then
      echo "host: $i"
      echo "$output"
      echo "---------"
    fi
  done
fi
