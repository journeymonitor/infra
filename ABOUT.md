# JourneyMonitor

## About the service

At http://journeymonitor.com, this project provides a software-as-a-service that allows users to upload Selenium
test scripts which are executed regularly and alert users if a test run resulted in an error. It also provides
ridiculously detailed performance metrics for each test run.

Think of it as a web-based cron for you Selenium tests.


## About the project

The full source code that powers the JourneyMonitor service is publicly available on GitHub. We would love to see
others joining the development effort.


### Nomenclature

The architecture of the JourneyMonitor service is modularized on different levels.

On the highest level, there are currently four modules, which are called *Compartments*:

- **[INFRA](https://github.com/journeymonitor/infra)** provides the Puppet and Vagrant code that is used to set up
  development and production environments for the applications of the other compartments
- **[CONTROL](https://github.com/journeymonitor/control)** contains a Symfony2 application that powers the web frontend
  at http://journeymonitor.com
- **[MONITOR](https://github.com/journeymonitor/monitor)** contains a plain PHP application with Bash script additions
  that does the actual heavy-lifting of running the testcases against a Firefox/Selenium setup and collecting the
  results
- **[ANALYZE](https://github.com/journeymonitor/anaylze)** contains, among others, a Scala/Spark application that
  extracts interesting metrics from the testcase runs

All four compartments form the fully featured JourneyMonitor system. The independence of the compartments is *high*:
They do not share code, and they do not share any data. Each compartment has a technological stack that best fits its
needs. The code for each compartment lives in its own repository.

A compartment can be modularized, too. At this level, modules are called *Applications*. For example, the *ANALYZE*
compartment currently contains two applications: *importer* takes care of consuming and persisting testresults from the
*MONITOR* compartment, and the *spark* application then operates on this data in order to calculate statistics.

As compartments don't share data, they need to exchange data. This happens via RESTful interfaces on top of HTTP. In
this sense, applications can provide *RESTful APIs*, but this is not part of the modularization.

Of course, applications are modularized, too. This, however, is implementation-specific (packages, classes, etc.).

Thus, the following modularization hierarchy is practiced:

                                The complete system
                                       |
                                       |
                                       | consists of multiple Compartments
                                       |
                                       |
                        |--------------|--------------|
                  a Compartment   a Compartment    a Compartment
                        |
                        |
                        | consists of one or more Applications
                        |
                        |
        |---------------|---------------|
      an Application  an Application  an Application


### The Big Pictures

#### Compartments diagram with data flow

                                       User
                                        +
                                        | interacts
                                        | with
                                        | Control
                                  +-----v-----+
              +-------------------+           |
              |                   |  CONTROL  <--------------+
              |    +-------------->           |              |reads
              |    | reads        +-----------+              |statistics
        reads |    | testresults  - manages                  |from
    testcases |    | from           testcases                |Analyze
         from |    | Monitor      - views                    |
      Control |    |                testresults              |
             +v----+-----+        * Symfony2           +-----+-----+
             |           |        * sqlite3            |           |
             |  MONITOR  |                             |  ANALYZE  |
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
                                      |   INFRA   |
                                      |           |
                                      +-----------+
                                      - manages
                                        configuration
                                        of systems
                                      * Puppet
                                      * Vagrant
