# JourneyMonitor

## About the service

At http://journeymonitor.com, this project provides a software-as-a-service that allows users to upload Selenium
test scripts which are executed regularly and alert users if a test run resulted in an error. It also provides
ridiculously detailed performance metrics for each test run.

Think of it as a web-based cron for you Selenium tests.


## About the project

The full source code that powers the JourneyMonitor service is publicly available on GitHub. We would love to see
others joining the development effort.

As of now, the service is split into 4 repositories:

- **[infra](https://github.com/journeymonitor/infra)** provides the Puppet and Vagrant code that is used to set up
  development and production environments for the applications
- **[control](https://github.com/journeymonitor/control)** is a Symfony2 application that powers the web frontend at
  http://journeymonitor.com
- **[monitor](https://github.com/journeymonitor/monitor)** is a plain PHP application with Bash script additions that
  does the actual heavy-lifting of running the testcases against a Firefox/Selenium setup and collecting the results
- **[analyze](https://github.com/journeymonitor/anaylze)** is a Scala/Spark application that extracts interesting
  metrics from the testcase runs


## The Big Pictures

### Components diagram

                                       User
                                        +
                                        | interacts
                                        | with
                                        | Control
                                  +-----v-----+
              +-------------------+           |
              |                   |  Control  <--------------+
              |    +-------------->           |              |reads
              |    | reads        +-----------+              |statistics
        reads |    | testresults  - manages                  |from
    testcases |    | from           testcases                |Analyze
         from |    | Monitor      - views                    |
      Control |    |                testresults              |
             +v----+-----+        * Symfony2           +-----+-----+
             |           |        * sqlite3            |           |
             |  Monitor  |                             |  Analyze  |
             |           +----------------------------->           |
             +-----------+              reads          +-----------+
             - executes                 testresults    - generates
               testcases                from             statistics
             - collects                 Monitor          from
               testresults                               testresults
             * Plain PHP                               * Spark
             * sqlite3                                 * Scala
             * selenese-runner                         * Cassandra
             * browsermob-proxy
                                      +-----------+
                                      |           |
                                      |   Infra   |
                                      |           |
                                      +-----------+
                                      - manages
                                        configuration
                                        of systems
                                      * Puppet
                                      * Vagrant
