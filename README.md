# test-exercise-nginx
[![N|Solid](https://cdn-1.wp.nginx.com/wp-content/themes/nginx-theme/assets/img/logo.svg)](https://www.nginx.com)
[![N|Solid](https://puppet.com/themes/hoverboard/images/puppet-logo/puppet-logo-amber-white-lg.png)](https://www.nginx.com)
#### Table of Contents
1. [Description](#description)
2. [Setup requirements](#requirements)
3. [Limitations](#limitations)
4. [Setup](#setup)
5. [Usage](#usage)
6. [Classes](#classes)
7. [Comments](#comments)

## Description
This module has been generated and tested only on CentOS 7 and takes care of the following features:

  - Installs nginx from the repos
  - Generates (non-interactively) a self-signed certificate (if needed) for the web server
  - Configures SSL on nginx, using the aforementioned certificate
  - Once SSL has been configured, the module also creates the proper redirections, as per requested on the test exercise
  - Based on the value of a parameter, this module can also be instructed to generate (or remove if in place) a forward proxy (port 8080). Forward proxy logs are dumped to /var/log/nginx/fw-proxy.log file with the requested format.

## Requirements
This module takes care of installing all the required packages to set up the nginx server: epel-repo, openssl and nginx

## Limitations
  - Only tested on CentOS 7. Most likely it will flawlessly work also on Red Hat 7
  - Optional activity has not been carried out

## Setup
Simply grab the module and dump it to proper location on your puppet infrastructure.
## Usage
There is only one parameter to customize the module (I'd like to add a lot more) The rest of the settings are managed to file resources so:
### If you do want to implement the forward proxy
This is by default. Just set the parameter $setforwardproxy = 'true' in the config class.
### If you do NOT want the forward proxy in place
Just set the parameter $setforwardproxy = 'false' in the config class and the forward proxy configuration will be wiped from the server.

## Classes
 - Install.pp: installs the necessary packages
 - Config.pp: implements the desired functionalites
 - Service.pp: manages the nginx service

## Comments
> I would like to implement a lot more parameters in the config.pp module.
> For exemple, to set custom redirects or to choose the particular port where the proxy listens to. In my testing environment, the module 
> works just as expected :-)


	    