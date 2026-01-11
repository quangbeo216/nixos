{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "acb" ''
      docker compose up -d
    '')
    (writeShellScriptBin "dlog" ''
      docker logs -f $1
    '')
    (writeShellScriptBin "cls" ''
      clear
    '')
    (writeShellScriptBin "dc" ''
      echo "xxxxx"
      echo "select"
      echo "0 stop all, 1 start, 2 stop, 3 exec workspace, 4 up -d, 5 exec webserver, 6 exec ggf, * exit"

      echo -n "Select option: "
      read r

      case "$r" in 
        0)
          echo "Stopping all containers..."
          docker stop $(docker ps -q)
          echo "Starting portainer..."
          docker start portainer
          ;;
        1)
          docker-compose up -d apache2 mysql phpmyadmin workspace
          ;;
        2)
          docker-compose stop
          ;;
        3)
          docker-compose exec workspace bash
          ;;
        4)
          docker-compose up -d
          ;;
        5)
          docker-compose exec webserver bash
          ;;
        6)
          docker-compose up -d apache2 workspace
          ;;
        *)
          echo "Exit"
          exit 0
          ;;
      esac
    '')
  ];
}