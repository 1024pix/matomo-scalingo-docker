# This image is based on Scalingo v18 image
FROM scalingo/scalingo-18

# Buildpacks `compile` script expects 3 parameters:
# - build dir
# - cache dir
# - environment dir
# These 3 directories are especially used by Scalingo php-buildpack
RUN mkdir -p /cache /env

# Add matomo-buildpack and matomo-deploy content into the Docker image
COPY deploy /build

# Reproduce .buildpacks #1 https://github.com/1024pix/matomo-buildpack#v3.14.1
COPY buildpack /buildpack
RUN cd /buildpack && ./bin/compile /build

# Reproduce .buildpacks #1 https://github.com/Scalingo/php-buildpack
RUN git clone https://github.com/Scalingo/php-buildpack
RUN /php-buildpack/bin/compile /build /cache /env

# Reproduce Scalingo behaviour before running Procfile
RUN rm -rf /app && mv /build /app

# All Scalingo apps define a listening port
ENV PORT=3000

# The default Scalingo app Docker image directory is /app
WORKDIR /app

# Scalingo Docker image defines a user `appsdeck` that is used during execution
RUN chown -R appsdeck: /app
USER appsdeck

# Reproduce Scalingo execution of Procfile
CMD ["/bin/bash", "-c", "source .profile.d/php.sh && exec ./bin/start-matomo.sh"]
