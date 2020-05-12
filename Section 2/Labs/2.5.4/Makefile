build:
	docker build . --tag thecrazyrussian/ra-demo:3

publish:
	docker push thecrazyrussian/ra-demo:3

deploy:
	kubectl apply -f deployment.yaml
