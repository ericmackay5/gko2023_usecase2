# --------------------------------------------------------
# MongoDB Sink Connector for customers
# --------------------------------------------------------

resource "confluent_connector" "mongo-db-sink-customers" {
  environment {
    id = confluent_environment.simple_env.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.simple_cluster.id
  }

  // Block for custom *sensitive* configuration properties that are labelled with "Type: password" under "Configuration Properties" section in the docs:
  // https://docs.confluent.io/cloud/current/connectors/cc-mongo-db-sink.html#configuration-properties
  config_sensitive = {
    "connection.password" = "***REDACTED***",
  }

  // Block for custom *nonsensitive* configuration properties that are *not* labelled with "Type: password" under "Configuration Properties" section in the docs:
  // https://docs.confluent.io/cloud/current/connectors/cc-mongo-db-sink.html#configuration-properties
  config_nonsensitive = {
    "connector.class"          = "MongoDbAtlasSink"
    "name"                     = "confluent-mongodb-sink"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = confluent_service_account.app_manager.id
    "connection.host"          = "<<hostname-for-bank-db>>"
    "connection.user"          = "confluentuser"
    "input.data.format"        = "JSON"
    "topics"                   = confluent_kafka_topic.customers.topic_name
    "max.num.retries"          = "3"
    "retries.defer.timeout"    = "5000"
    "max.batch.size"           = "0"
    "database"                 = "Bank"
    "collection"               = "customers"
    "tasks.max"                = "1"
  }
}

# --------------------------------------------------------
# MongoDB Sink Connector for customers
# --------------------------------------------------------

resource "confluent_connector" "mongo-db-sink-accounts" {
  environment {
    id = confluent_environment.simple_env.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.simple_cluster.id
  }

  // Block for custom *sensitive* configuration properties that are labelled with "Type: password" under "Configuration Properties" section in the docs:
  // https://docs.confluent.io/cloud/current/connectors/cc-mongo-db-sink.html#configuration-properties
  config_sensitive = {
    "connection.password" = "***REDACTED***",
  }

  // Block for custom *nonsensitive* configuration properties that are *not* labelled with "Type: password" under "Configuration Properties" section in the docs:
  // https://docs.confluent.io/cloud/current/connectors/cc-mongo-db-sink.html#configuration-properties
  config_nonsensitive = {
    "connector.class"          = "MongoDbAtlasSink"
    "name"                     = "confluent-mongodb-sink"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = confluent_service_account.app_manager.id
    "connection.host"          = "<<hostname-for-bank-db>>"
    "connection.user"          = "confluentuser"
    "input.data.format"        = "JSON"
    "topics"                   = confluent_kafka_topic.accounts.topic_name
    "max.num.retries"          = "3"
    "retries.defer.timeout"    = "5000"
    "max.batch.size"           = "0"
    "database"                 = "Bank"
    "collection"               = "accounts"
    "tasks.max"                = "1"
  }
}

# --------------------------------------------------------
# Oracle DB Sink Connector
# --------------------------------------------------------

resource "confluent_connector" "oracle-db-source" {
  environment {
    id = confluent_environment.simple_env.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.simple_cluster.id
  }

  // Block for custom *sensitive* configuration properties that are labelled with "Type: password" under "Configuration Properties" section in the docs:
  // https://docs.confluent.io/cloud/current/connectors/cc-mongo-db-sink.html#configuration-properties
  config_sensitive = {
    "connection.password" = "***REDACTED***",
  }

  // Block for custom *nonsensitive* configuration properties that are *not* labelled with "Type: password" under "Configuration Properties" section in the docs:
  // https://docs.confluent.io/cloud/current/connectors/cc-mongo-db-sink.html#configuration-properties
  config_nonsensitive = {
    "name" : "OracleDatabaseSource_0",
    "kafka.service.account.id" = confluent_service_account.app_manager.id,
    "connector.class": "OracleDatabaseSource",
    "kafka.auth.mode": "KAFKA_API_KEY",
    "kafka.api.key": "<my-kafka-api-key>",
    "kafka.api.secret" : "<my-kafka-api-secret>",
    "topic.prefix" : "oracle_",
    "connection.host" : "no",
    "connection.port" : "1521",
    "connection.user" : "<database-username>",
    "db.name": aws_db_instance.babu_gko_oracle_db.db_name,
    "table.whitelist": "accounts, customers",
    "timestamp.column.name": "created_at",
    "output.data.format": "JSON",
    "db.timezone": "UCT",
    "tasks.max" : "1"
}
}