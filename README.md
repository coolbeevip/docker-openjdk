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

## ENVIRONMENT

* SW_AGENT_ENABLED=false

  Integration Skywalking Agent 8.1.0

  Use `-javaagent:/skywalking/agent/skywalking-agent.jar` when SW_AGENT_ENABLED = true
