# TensorFlow for Lambda

This utility was created to assist the setup of various TensorFlow versions on lambda using the [serverless-ephemeral](https://github.com/Accenture/serverless-ephemeral) plugin for [serverless](https://serverless.com/).

This library simplifies the commands needed to build a slim version of TensorFlow that will allow your function to come in under the AWS Lambda 250MB limit.  This package includes experimental removals and can be modified as you need.  Please read the [ephemeral docs](https://github.com/Accenture/serverless-ephemeral/blob/master/docs/build-tensorflow-package.md) for more information.

### Build

Running this package is simple if you already have docker installed and running.  Just clone the repository, specify your TensorFlow version as an environment variable and run `make`.  It will output a zip file in the root directory that you can upload to S3 for your lambda function.

```bash
TENSORFLOW_VERSION=1.10.0 make
```

You can always specify other requirements in the `requirements.txt` for other libraries or specific versions of libraries.

### Deploy

Should you want to deploy the library you can upload it to S3 with whatever permissions you want:

```bash
aws s3 cp --acl=public-read *.zip s3://<BUCKET_NAME>/path/to/lib
```

Once it is up on S3 it's just a matter of adding the following to `serverless.yml`:

```yml
custom:
  ephemeral:
    libraries:
      - url: https://s3.<AWS_REGION>.amazonaws.com/<KEY_PATH>/tensorflow-1.10.0-cp27-none-linux_x86_64.zip
        directory: tfpackage
        nocache: true
```
