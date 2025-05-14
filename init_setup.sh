#!/bin/bash

# Ruta al archivo .env.docker
ENV_FILE="./docker/.env.docker"

# Detectar UID y GID del usuario actual
USER_ID=$(id -u)
GROUP_ID=$(id -g)

# Crear o actualizar .env.docker
echo "Generando ${ENV_FILE} con UID=${USER_ID} y GID=${GROUP_ID}"

cat > "$ENV_FILE" <<EOF
APP_PORT=8000

DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=root
DB_ROOT_PASSWORD=root
DB_PORT=3306

USER_ID=${USER_ID}
GROUP_ID=${GROUP_ID}
EOF

# Construir y levantar los contenedores
echo "Levantando contenedores con Docker Compose..."
docker-compose --env-file "$ENV_FILE" up -d --build

echo ""
echo "Contenedores levantados. Laravel estará disponible en http://localhost:8000"
echo ""
echo "Para acceder a la base de datos MySQL, usa los siguientes datos:"
echo "  - Host: localhost"
echo "  - Puerto: 3306"
echo "  - Usuario: laravel"
echo "  - Contraseña: root"
echo "  - Base de datos: laravel"
echo ""
echo "Para acceder a phpMyAdmin, usa los siguientes datos:"
echo "  - URL: http://localhost:8080"
echo "  - Usuario: laravel"
echo "  - Contraseña: root"
echo ""
echo "Para acceder al servicio de mailpit, usa los siguientes datos:"
echo "  - URL: http://localhost:8025"
echo ""
echo "Para detener los contenedores, usa: docker-compose down"
echo "Para eliminar los contenedores y volúmenes, usa: docker-compose down -v"
echo "Para eliminar la red, usa: docker network rm laravel-docker-network"
echo "Para eliminar la imagen, usa: docker rmi laravel-docker"
echo "Para eliminar el contenedor, usa: docker rm -f laravel-docker"