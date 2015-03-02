all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build        - build the devbox image"
	@echo "   2. make start   - start devbox"
	@echo "   3. make stop         - stop devbox"
	@echo "   4. make logs         - view logs"
	@echo "   5. make purge        - stop and remove the container"

build:
	@docker build --rm --tag=${USER}/devbox .

start:
	@echo "Starting devbox..."
	@docker run --name='devbox' -d \
		-p 8181:8181 -p 3000:3000 -p 8000:8000 \
		-v -v ${USER}/workspace/:/workspace/ -v ${USER}/.ssh/:/root/.ssh/
		${USER}/devbox:latest >/dev/null
	@echo "Devbox will be available at http://localhost:8181"
	@echo "Type 'make logs' for the logs"

stop:
	@echo "Stopping devbox..."
	@docker stop devbox >/dev/null

purge: stop
	@echo "Removing stopped container..."
	@docker rm devbox >/dev/null

logs:
	@docker logs -f devbox
