# Define o nome do arquivo docker-compose
COMPOSE_FILE=docker-compose.yml

# Define os targets
all: up

# Target para iniciar o container
up:
	docker-compose -f $(COMPOSE_FILE) up -d

# Target para parar o container
down:
	docker-compose -f $(COMPOSE_FILE) down

# Target para rebuildar o container
rebuild:
	docker-compose -f $(COMPOSE_FILE) build
	docker-compose -f $(COMPOSE_FILE) up -d

# Target para entrar no container
bash:
	docker-compose -f $(COMPOSE_FILE) run --rm app bash

# Target para mostrar os logs do container
logs:
	docker-compose -f $(COMPOSE_FILE) logs -f

# Target para remover os bind mounts
clean: down
	@rm -rf ./database/postgres/* 
	@rm -rf ./database/pgadmin/*

# Target para mostrar a ajuda
help:
	@echo "Uso: make [target]"
	@echo " "
	@echo "Targets disponíveis:"
	@echo "  all: Inicia o container."
	@echo "  down: Para o container."
	@echo "  rebuild: Reconstrói o container."
	@echo "  bash: Entra no container."
	@echo "  logs: Mostra os logs do container."
	@echo "  clean: Remove os containers."
	@echo "  help: Mostra o help."