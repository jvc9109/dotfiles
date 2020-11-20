function docker_list() {
  containers=$(docker ps | awk '{if (NR!=1) print $1 ": " $(NF)}')

  echo "👇 Containers 👇"
  echo $containers
}

function docker_connect() {
  if docker ps >/dev/null 2>&1; then
    container=$(docker ps | awk '{if (NR!=1) print $1 ": " $(NF)}' | fzf --height 40%)

    if [[ -n $container ]]; then
      container_id=$(echo $container | awk -F ': ' '{print $1}')

      docker exec -it $container_id /bin/bash || docker exec -it $container_id /bin/sh
    else
      echo "You haven't selected any container! ༼つ◕_◕༽つ"
    fi
  else
    echo "Docker daemon is not running! (ಠ_ಠ)"
  fi
}

function docker_clean() {
  if docker ps >/dev/null 2>&1; then
    echo "Cleaning unused volumes"
    docker volume rm $(docker volume ls -qf dangling=true)
    docker volume ls -qf dangling=true | xargs -r docker volume rm

    echo "Cleaning unused images"
    docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
    docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')
    
  else
    echo "Docker daemon is not running! (ಠ_ಠ)"
  fi
}