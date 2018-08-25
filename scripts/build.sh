#!/bin/bash

echo "Building TensorFlow v${TENSORFLOW_VERSION}"

docker build -t tensorflow-lambda .
docker run --rm -it -d tensorflow-lambda /bin/bash

CID=$(docker container ls --latest -q)
docker cp $CID:/build/tensorflow-${TENSORFLOW_VERSION}-cp27-none-linux_x86_64.zip .

docker kill $CID
