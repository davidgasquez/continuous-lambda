resource "aws_kinesis_stream" "sample_stream" {
  name        = "sample_stream"
  shard_count = 1
}
