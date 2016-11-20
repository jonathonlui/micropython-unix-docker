
.PHONY:
build:

	# Build the micropython binary
	docker build -t jonathonlui/micropython-build-binary -f Dockerfile.build-binary .

	# Copy out the micropython binary
	mkdir -p bin
	docker run --rm -v $(PWD)/bin:/root/bin jonathonlui/micropython-build-binary \
		cp /usr/local/bin/micropython /root/bin

	# Build the final micropython Docker image
	docker build -t jonathonlui/micropython -f Dockerfile .

	# Cleanup
	-rm -rf bin
	-docker rmi jonathonlui/micropython-build-binary
