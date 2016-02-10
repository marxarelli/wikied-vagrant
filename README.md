# Wiki Ed Vagrant

A Vagrant environment for developers of the [Wiki Education Foundation's dashboard](https://github.com/WikiEducationFoundation/WikiEduDashboard), this setup starts with a Debian jessie VirtualBox image, installs all necessary deb/npm/bower/gem dependencies, installs development and test databases, and executes all database migrations.

## Install

You'll of course still need to install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html) if you don't have them already. Oh the irony of Vagrant. :)

## Setup

Clone this repo, change to the directory, copy `hiera/local.yaml.example` to `hiera/local.yaml` o
and:

 1. Fork the [dashboard project](https://github.com/WikiEducationFoundation/WikiEduDashboard)
 2. Clone this repo
 3. Copy `hiera/local.yaml.example` to `hiera/local.yaml`
 4. Edit the file and configure your Git and GitHub details
 5. `vagrant up`

You'll be left about [here](https://github.com/WikiEducationFoundation/WikiEduDashboard/blob/master/docs/setup.md#seed-data-optional-this-could-take-a-very-long-time) in the setup process, meaning you sill need to set up OAuth and add the credentials to your `config/application.yml` before firing up the Rails app.
