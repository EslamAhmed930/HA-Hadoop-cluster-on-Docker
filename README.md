
# Hadoop High Availability (HA) Cluster using Docker

This project sets up a Hadoop 3.x High Availability cluster using Docker containers. It includes multiple NameNodes, a ZooKeeper ensemble, and YARN ResourceManagers with automatic failover.

## Components

- **HDFS** with 3 NameNodes in HA mode
- **YARN** with 3 ResourceManagers in HA mode
- **ZooKeeper** ensemble for coordination
- **JournalNodes** for shared edit logs
- **DataNodes** and **NodeManagers** for storage and processing

## Directory Structure

```

.
├── Dockerfile
├── docker-compose.yml
├── core-site.xml
├── hdfs-site.xml
├── yarn-site.xml
├── mapred-site.xml
├── hadoop-env.sh
├── start.sh

````

## Configuration Details

### 1. HDFS HA

- **Nameservice**: `mycluster`
- **NameNodes**: `nn1` → `master1`, `nn2` → `master2`, `nn3` → `master3`
- **JournalNodes**: `master1`, `master2`, `master3`
- Automatic failover is enabled via ZooKeeper and `ZKFC`
- Shared edits are configured via `qjournal://`

### 2. YARN HA

- **ResourceManager Cluster ID**: `mycluster`
- **ResourceManagers**: `rm1` → `master1`, `rm2` → `master2`, `rm3` → `master3`
- Automatic ResourceManager failover enabled

### 3. ZooKeeper

- Quorum: `master1:2181`, `master2:2181`, `master3:2181`

## Environment Variables

- `JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64`

## Docker Setup

### Build and Run

```bash
docker-compose build
docker-compose up -d
````

### Container Initialization

Each master node runs:

* SSH service
* ZooKeeper server
* JournalNode
* NameNode or Standby bootstrapping based on hostname

Script: `start.sh`

## Port Mapping

* NameNode Web UIs: `9870`
* ResourceManager Web UIs: `8088`
* ZooKeeper: `2181`
* JournalNode: `8485`

## Notes

* Replication factor is set to 1 for demonstration.
* This setup is suitable for local development and testing purposes.
* Production deployments should consider persistent volumes and security configurations.

## License

This project is licensed under the Apache License 2.0.



