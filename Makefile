IMAGE  := flames-restaurant
CONTAINER := flames-restaurant
PORT   := 3000

.PHONY: build run stop restart logs clean open

build:
	docker build -t $(IMAGE) .

run: build
	@echo "Serving at http://localhost:$(PORT) (Ctrl+C to stop)"
	docker run --rm --name $(CONTAINER) -p $(PORT):80 $(IMAGE)

stop:
	docker stop $(CONTAINER) && docker rm $(CONTAINER)

restart: stop run

logs:
	docker logs -f $(CONTAINER)

clean:
	-docker stop $(CONTAINER) 2>/dev/null; docker rm $(CONTAINER) 2>/dev/null
	docker rmi $(IMAGE)

open:
	xdg-open http://localhost:$(PORT) 2>/dev/null || open http://localhost:$(PORT)
