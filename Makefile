all: up

up:
	@mkdir -p /home/mleblanc/data/mariadb
	@mkdir -p /home/mleblanc/data/wordpress
	@docker-compose -f srcs/docker-compose.yml up -d

down:
	@docker-compose -f srcs/docker-compose.yml down

build:
	@docker-compose -f srcs/docker-compose.yml build

clean:
	@docker-compose -f srcs/docker-compose.yml down --rmi all

vclean:
	@docker volume rm $(shell docker volume ls -q)

fclean:	clean vclean

re: fclean all

.PHONY: all up down build clean vclean fclean re
