# Unordered notes

Compiled for Scala 2.11

http://spark.apache.org/docs/latest/building-spark.html#building-for-scala-211
brew install maven

./dev/change-scala-version.sh 2.11
mvn -Pyarn -Phadoop-2.6 -Dscala-2.11 -DskipTests clean package

Creates assembly/target/scala-2.11/spark-assembly-1.5.1-hadoop2.6.0.jar

Java is official Oracle 1.8.0_25-b17

export JAVA_HOME=$(/usr/libexec/java_home)
mvn clean
./dev/change-scala-version.sh 2.11
./make-distribution.sh --name hadoop-2.6_scala-2.11 --tgz -Pyarn -Phadoop-2.6 -Dscala-2.11 -DskipTests

Creates spark-1.5.1-bin-hadoop-2.6_scala-2.11.tgz in project root folder.

Run locally:
./bin/spark-submit ~/spark-test/target/scala-2.11/spark-test_2.11-1.0.jar

Output goes to stdout

Run on cluster:
./sbin/start-master.sh --host 127.0.0.1
./sbin/start-slave.sh spark://127.0.0.1:7077
./bin/spark-submit --deploy-mode cluster --master spark://127.0.0.1:6066 ~/spark-test/target/scala-2.11/spark-test_2.11-1.0.jar

Output viewable on worker web ui, stdout log of Driver

7077 -> Master port for connecting workers
6066 -> Master port for submitting jobs
8080 -> Master port for web ui

slaves/workers can be started before master is running, they connect once it's up

PID files:
/tmp/spark-manuelkiessling-org.apache.spark.deploy.master.Master-1.pid
/tmp/spark-manuelkiessling-org.apache.spark.deploy.worker.Worker-1.pid

(could also simply start repeatedly, exit code is always 0)
