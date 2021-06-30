# Specify the base image that our container image will be based on and
# define the maintainer.
FROM registry.redhat.io/ubi8/ubi
MAINTAINER Example User <user@example.com>

# Copy the `entrypoint.sh` file on the host as `/sbin/entrypoint.sh` in the
# container.
COPY entrypoint.sh /sbin/entrypoint.sh

# Apply the proper permissions for `entrypoint.sh` so it can be executed as
# a shell script. Then, update the base system, install Ruby and its
# package manager, then clean up after the `yum install`. Finally, install
# the `asciidoctor` and `asciidoctor-pdf` Ruby gems.
RUN chmod 755 /sbin/entrypoint.sh && \
    yum update -y && \
    yum install -y ruby rubygems && \
    yum clean all && \
    gem install asciidoctor asciidoctor-pdf --pre

# Mount the `/docs` directory as a volume to allow files into and out of
# the container. On the command line, we must specify a host directory to
# be mounted to `/docs` in the container with `-v <host_directory>:/docs`.
VOLUME /docs
WORKDIR /docs

# Run the commands in this Containerfile as `root` in the container.
USER root

# Use the `entrypoint.sh` file as our default entrypoint. This allows us
# to use the script to switch output formats based on the initial argument
# given to the container from the command line (`html` or `pdf`).
ENTRYPOINT ["entrypoint.sh"]
