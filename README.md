# TensorFlow for Lambda

This utility was created to assist the setup of various TensorFlow versions on lambda using the [serverless-ephemeral](https://github.com/Accenture/serverless-ephemeral) plugin for [serverless](https://serverless.com/).

This library simplifies the commands needed to build a slim version of TensorFlow that will allow your function to come in under the AWS Lambda 250MB limit.  This package includes experimental removals and can be modified as you need.  Please read the [ephemeral docs](https://github.com/Accenture/serverless-ephemeral/blob/master/docs/build-tensorflow-package.md) for more information.

### Execute

Running this package is simple if you already have docker installed and running.  Just clone the repository, specify your TensorFlow version as an environment variable and run `make`.  It will output a zip file in the root directory that you can upload to S3 for your lambda function.

```bash
TENSORFLOW_VERSION=1.10.0 make
```
