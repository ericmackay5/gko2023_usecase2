resource "confluent_kafka_topic" "accounts" {
  kafka_cluster {
    id = confluent_kafka_cluster.simple_cluster.id
  }
  topic_name         = "accounts"
  rest_endpoint      = confluent_kafka_cluster.simple_cluster.rest_endpoint
  credentials {
    key    = confluent_api_key.app_manager_kafka_cluster_key.id
    secret = confluent_api_key.app_manager_kafka_cluster_key.secret
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "confluent_kafka_topic" "customers" {
  kafka_cluster {
    id = confluent_kafka_cluster.simple_cluster.id
  }
  topic_name         = "customers"
  rest_endpoint      = confluent_kafka_cluster.simple_cluster.rest_endpoint
  credentials {
    key    = confluent_api_key.app_manager_kafka_cluster_key.id
    secret = confluent_api_key.app_manager_kafka_cluster_key.secret
  }

  lifecycle {
    prevent_destroy = false
  }
}