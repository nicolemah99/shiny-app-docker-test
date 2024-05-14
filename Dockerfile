# Use a specific version of the rocker/shiny image that matches the R version in renv.lock
FROM rocker/shiny:4.4.0

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libxml2-dev \
    libssl-dev \
    pandoc \
    pandoc-citeproc

# Install renv package globally
RUN R -e "install.packages('renv', repos='https://cloud.r-project.org')"

# Copy the renv.lock file, renv directory, and the app code into the Docker image
COPY renv.lock /srv/shiny-server/example-app/renv.lock
COPY renv /srv/shiny-server/example-app/renv
COPY example-app /srv/shiny-server/example-app

# Set the working directory
WORKDIR /srv/shiny-server/example-app

# Restore R packages using renv
RUN R -e "renv::restore()"

# Expose the Shiny app port
EXPOSE 3838

# Start the Shiny server
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/example-app/app.R', host = '0.0.0.0', port = 3838)"]

