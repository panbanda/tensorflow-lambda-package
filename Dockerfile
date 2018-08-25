FROM amazonlinux:2

# Create a virtual environment
RUN yum -y install epel-release zip \
  gcc gcc-c++ python-pip python-devel atlas \
  atlas-devel gcc-gfortran openssl-devel libffi-devel \
    && pip install --upgrade virtualenv

ARG TENSORFLOW_VERSION=1.10.0

WORKDIR /build

# Work in virtual env
RUN virtualenv ~/venvs/tensorflow && \
  source ~/venvs/tensorflow/bin/activate && \
  pip install --upgrade pip

# Install TensorFlow
RUN pip install --upgrade --ignore-installed --no-cache-dir https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-${TENSORFLOW_VERSION}-cp27-none-linux_x86_64.whl \
  && touch $VIRTUAL_ENV/lib64/python2.7/site-packages/google/__init__.py

# Install any requirements if present
COPY requirements.txt .
RUN pip install -r requirements.txt

# Show all the versions of the software for verification
RUN pip freeze

# Warning: this is an experimental step. Removing libraries is used to better
# comply with the AWS Lambda (unzipped) max size of 250 MB. The final product
# was tested versus several examples, but it doesn't ensure it will work with
# all implementations. If your final file size is not compromised, skip this step.
RUN cd $VIRTUAL_ENV/lib/python2.7/site-packages \
  && rm -rf easy_install* pip* setup_tools* wheel* \
  && find $VIRTUAL_ENV/{lib,lib64}/python2.7/site-packages -name "*.so" | xargs strip

# Zip the package for distribution
RUN cd $VIRTUAL_ENV/lib/python2.7/site-packages/ \
  && zip -r9q --exclude \*.pyc /build/tensorflow-${TENSORFLOW_VERSION}-cp27-none-linux_x86_64.zip *

CMD ["python"]
