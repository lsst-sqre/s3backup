all: build

build:
	docker build -t lsstsqre/s3backup:latest .
