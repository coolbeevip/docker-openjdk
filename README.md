# OPENJDK

## BASE

* openjdk:8-jre-alpine

## SYSTEM

* en_US.UTF-8
* Asia/Shanghai

## DEFAULT JVM

* -Xms256m
* -Xmx1g
* -Xss256k
* -XX:MetaspaceSize=128m
* -XX:MaxMetaspaceSize=512m
* -XX:+UseConcMarkSweepGC
* -XX:+UseParNewGC
* -XX:MaxTenuringThreshold=15
* -XX:+ExplicitGCInvokesConcurrent
* -XX:+CMSParallelRemarkEnabled
* -XX:SurvivorRatio=8 -XX:+UseCompressedOops
* SW_AGENT_ENABLED

## TOOLS

* bash
* tzdata
* openssh
* su-exec
* unzip
* libzmq
* ttf-dejavu
* curl
* shadow
* glibc
* jattach

## Integration Skywalking Agent 8.1.0

environment variable

* SW_AGENT_ENABLED=false

  Use `-javaagent:/skywalking/agent/skywalking-agent.jar` when SW_AGENT_ENABLED = true

* SW_AGENT_COLLECTOR_BACKEND_SERVICES

  Skywalking OAP address. e.g. `127.0.​0.1:11800`

* SW_AGENT_NAME  

  Your application name. e.g. `my-service`
