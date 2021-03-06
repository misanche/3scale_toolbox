## Import API definition to 3scale from OpenAPI definition

Features:

* OpenAPI __2.0__ specification (f.k.a. __swagger__)
* Create a new service. New service name will be taken from openapi definition `info.title` field.
* Update existing service, providing `system_name` optional parameter. If service with that `system_name` does not exist, create it first.
`system_name` can be passed as option parameter and defaults to *info.title* field from openapi spec.
* Create methods in the 'Definition' section. Method names are taken from `operation.operationId` field.
* Attach newly created methods to the *Hits* metric.
* All existing *mapping rules* are deleted before importing new API definition. Methods not deleted if exist before running the command.
* Create mapping rules and show them under `API > Integration`.
* Perform schema validation.
* OpenAPI definition resource can be provided by one of the following channels:
  * *Filename* in the available path.
  * *URL* format. Toolbox will try to download from given address.
  * Read from *stdin* standard input stream.
* Applied strict matching on mapping rule patterns

### Usage

```shell
NAME
    openapi - Import API defintion in OpenAPI specification

USAGE
    3scale import openapi [opts] -d <dst> <spec>

DESCRIPTION
    Using an API definition format like OpenAPI, import to your 3scale API

OPTIONS
    -d --destination=<value>             3scale target instance. Format:
                                         "http[s]://<authentication>@3scale_domain"
    -t --target_system_name=<value>      Target system name

OPTIONS FOR IMPORT
    -c --config-file=<value>             3scale toolbox configuration file
                                         (default:
                                         /home/eguzki/.3scalerc.yaml)
    -h --help                            show help for this command
    -k --insecure                        Proceed and operate even for server
                                         connections otherwise considered
                                         insecure
    -v --version                         Prints the version of this command
```

### Create new service

```shell
$ 3scale import openapi -d <destination> <openapi_resource>
```

### Update existing service

```shell
$ 3scale import openapi --target_system_name <TARGET_SYSTEM_NAME> -d <destination> <openapi_resource>
```

### OpenAPI definition from filename in path

Allowed formats are `json` and `yaml`. Format is automatically detected from filename __extension__.

```shell
$ 3scale import openapi -d <destination> /path/to/your/spec/file.[json|yaml|yml]
```

### OpenAPI definition from URI

Allowed formats are `json` and `yaml`. Format is automatically detected from URL's path __extension__.

```shell
$ 3scale import openapi -d <destination> http[s]://domain/resource/path.[json|yaml|yml]
```

### OpenAPI definition from stdin

Command line parameter for the openapi resource is `-`.

Allowed formats are `json` and `yaml`. Format is automatically detected internally with parsers.

```shell
$ tool_to_read_openapi_from_source | 3scale import openapi -d <destination> -
```
