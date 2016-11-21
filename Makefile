
.PHONY:
build:

	# Build the micropython binary
	docker build -t jonathonlui/micropython-build-binary -f Dockerfile.build-binary .

	# Copy out the micropython binary
	mkdir -p temp
	docker run --rm -v $(PWD)/temp:/root/temp jonathonlui/micropython-build-binary \
		cp /usr/local/bin/micropython /root/temp
	docker run --rm -v $(PWD)/temp:/root/temp jonathonlui/micropython-build-binary \
		cp -a /root/.micropython /root/temp/micropython-lib

	# Build the final micropython Docker image
	docker build -t jonathonlui/micropython -f Dockerfile .

	# Cleanup
	-rm -rf temp
	-docker rmi jonathonlui/micropython-build-binary
