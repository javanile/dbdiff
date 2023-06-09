

up:
	@docker-compose up -d

build:
	@chmod +x docker-entrypoint.sh
	@docker compose build dbdiff

release:
	@date > tests/RELEASE
	@git add .
	@git commit -am "New release!"
	@git push
	@docker login -u javanile
	@docker build -t "javanile/dbdiff:latest" .
	@docker push "javanile/dbdiff:latest"

## ====
## Test
## ====

test-version: build
	@docker compose run dbdiff --version

test-diff-table: build up
	@docker compose run dbdiff bash /tests/fixtures/diff-table.sh demo_table

