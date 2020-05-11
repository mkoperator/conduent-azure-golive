build:
	docker build . --tag thecrazyrussian/ra-demo2:2.6.5.1

publish:
	docker push thecrazyrussian/ra-demo2:2.6.5.1

deploy:
	kubectl apply -f deployment.yaml
