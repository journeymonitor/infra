# JourneyMonitor

## Environment variable management


## Naming schema

Component specific env vars (preferred!):

`JOURNEYMONITOR_<COMPONENT>_FOO`

e.g.: `JOURNEYMONITOR_ANALYZE_CASSANDRAURI=cassandra://localhost:9042/analyze`


App specific env vars:

`JOURNEYMONITOR_<COMPONENT>_<APPLICATION>_FOO`

e.g.: `JOURNEYMONITOR_ANALYZE_IMPORTER_CASSANDRAURI=cassandra://localhost:9042/analyze`
