# JourneyMonitor

## About the service

At http://journeymonitor.com, this project provides a software-as-a-service that allows users to upload Selenium
test scripts which are executed regularly and alert users if a test run resulted in an error. It also provides
ridiculously detailed performance metrics for each test run.

Think of it as a web-based cron for you Selenium tests.


## About the project

The full source code that powers the JourneyMonitor service is publicly available on GitHub. We would love to see
others joining the development effort.

As of now, the service is split into 3 repositories:

- **[infra](https://github.com/journeymonitor/infra)** provides the Puppet and Vagrant code that is used to set up
  development and production environments for the applications
- **[control](https://github.com/journeymonitor/control)** is a Symfony2 application that powers the web frontend at
  http://journeymonitor.com
- **[monitor](https://github.com/journeymonitor/monitor)** is a plain PHP application with Bash script additions that
  does the actual heavy-lifting of running the testcases against a Firefox/Selenium setup and collecting the performance
  metrics
