# gocd-cli in docker

A [Dojo](https://github.com/ai-traders/dojo) docker image featuring:
 * [gocd-cli](https://github.com/gocd-contrib/gocd-cli)
 * [gocd yaml config plugin](https://github.com/tomzo/gocd-yaml-config-plugin)
 * [gocd json config plugin](https://github.com/tomzo/gocd-json-config-plugin)
 * [gocd groovy config plugin](https://github.com/gocd-contrib/gocd-groovy-dsl-config-plugin)

The primary use case of this image is to help with validating GoCD config repos before pushing changes to the source control.

## Setup

1. [Install docker](https://docs.docker.com/install/), if you haven't already.
2. [Install Dojo](https://github.com/ai-traders/dojo#installation), it is a self-contained binary, so just place it somewhere on the `PATH`.
On **Linux**:
```bash
DOJO_VERSION=0.4.1
wget -O dojo https://github.com/ai-traders/dojo/releases/download/${DOJO_VERSION}/dojo_linux_amd64
sudo mv dojo /usr/local/bin
sudo chmod +x /usr/local/bin/dojo
```

## Usage

1. `cd` into project which has GoCD configuration files.
1. [Configure access](#configuration) to the GoCD server.
1. The quickest way to start is to run the docker container
```bash
dojo --image=kudulab/gocd-cli-dojo
```
1. Then you can execute `gocd` CLI, for example to validate GoCD configuration files
```
gocd configrepo preflight -r my-repo-id --yaml ci.gocd.yaml
```

Please refer to [gocd-cli](https://github.com/gocd-contrib/gocd-cli) documentation to find out more about usage.

# Configuration

You must configure access to your GoCD in order to execute the preflight checks.
There are 2 ways to do it:
 * setup a [settings.yaml file](#settings-file)
 * use [environment variables](#environment-variables)

## settings file

In your home directory create a file `.gocd/settings.yaml` with following content:
```yaml
auth:
  password: ***
  type: basic
  user: my_gocd_username
config_version: 1
server:
  url: http://go.mydomain.com/go
```

## environment variables

Before running `dojo` you can export following variables:

Required variables to set:
 * `GOCDCLI_SERVER_URL=https://your-gocd-host/go`

To use **basic authentication**:
 * `GOCDCLI_AUTH_TYPE=basic`
 * `GOCDCLI_AUTH_USER=myuser`
 * `GOCDCLI_AUTH_PASSWORD=mysupersecretpasswd`

To use **token-based authentication**:
* `GOCDCLI_AUTH_TOKEN=secrettoken`

To skip authentication setup:
 * `GOCDCLI_SKIP_AUTH` set to any value to avoid authentication setup.
