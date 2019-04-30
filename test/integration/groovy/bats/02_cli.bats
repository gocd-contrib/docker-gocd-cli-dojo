load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "gocd --groovy returns OK when file is valid" {
  run /bin/bash -c "dojo -c Dojofile-groovy \"gocd configrepo --groovy syntax groovy-example/build.gocd.groovy\""
  assert_output --partial "OK"
  refute_output --partial "Downloading"
  assert_equal "$status" 0
}
