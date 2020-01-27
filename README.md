# Racktables v0.22.0 with Nginx and PHP-FPM on Docker Alpine Linux Image
The complete project had the image is only +/- 34MB large.

Repository: https://github.com/revolutionsystem/racktables


* Racktables is downloaded directly from the repository, always guaranteeing the most updated version
* Built on the lightweight and secure Alpine Linux distribution v3.10
* Very small Docker image size (+/-34MB)
* Uses PHP 7.3 for better performance, lower cpu usage & memory footprint
* Optimized for 100 concurrent users
* Optimized to only use resources when there's traffic (by using PHP-FPM's ondemand PM)


[![Docker Pulls](https://img.shields.io/docker/pulls/revolutionsystem/racktables.svg)](https://hub.docker.com/r/revolutionsystem/racktables)
[![Docker image layers](https://images.microbadger.com/badges/image/revolutionsystem/racktables.svg)](https://microbadger.com/images/revolutionsystem/racktables)
![nginx 1.16.1](https://img.shields.io/badge/nginx-1.16-brightgreen.svg)
![php 7.3](https://img.shields.io/badge/php-7.3-brightgreen.svg)
![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

## Requirement for installation

* Virtualization: Docker, Kubernetes, OpenShift or Rancher
* Database: MySQL Server or MariaDB 5.5+ 

## Usage

Start the Docker container:

    docker run -p 80:80 revolutionsystem/racktables

To start an installation call the url in your browser http://localhost/?module=installer

Or mount your own code to be served by Racktables

    docker run -p 80:80 -v ~/my-codebase:/var/www/html revolutionsystem/racktables

## Configuration
Follow the instructions on the installation page. 
