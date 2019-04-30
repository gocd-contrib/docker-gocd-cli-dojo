load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "gocd --json returns OK when file is valid" {
  run /bin/bash -c "dojo -c Dojofile-json \"cd json-example && gocd configrepo --json syntax allmaterials.gopipeline.json\""
  assert_output --partial "OK"
  refute_output --partial "Downloading"
  assert_equal "$status" 0
}
