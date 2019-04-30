load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "gocd --yaml returns OK when file is valid" {
  run /bin/bash -c "dojo -c Dojofile-yaml \"cd yaml-example && gocd configrepo --yaml syntax ci.gocd.yaml\""
  assert_output --partial "OK"
  refute_output --partial "Downloading"
  assert_equal "$status" 0
}
