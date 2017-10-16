# Patcher

## Description

The idea behind this tool is to define a workflow for patching systems. This workflow consists of 3 steps:

 * Scan a system with InSpec Patch Baseline
 * Approve the patches and generate a patch policy
 * Apply those with any configuration management tool

At this point, the workflow is supported with

 * [DevSec Linux Patch Baseline](https://github.com/dev-sec/linux-patch-baseline)
 * [Atomic111 Linux Patch Cookbook](https://github.com/atomic111/chef-update-linux)

## Platform

* Ubuntu > 12.04

## Usage

```
$ patcher extract examples/ubuntu-16.04_default_inspec.json
Load examples/ubuntu-16.04_default_inspec.json
+------------------------------+--------------------------------------------+
| Package                      | Version                                    |
+------------------------------+--------------------------------------------+
| apparmor                     | 2.10.95-0ubuntu2.7                         |
| apport                       | 2.20.1-0ubuntu2.10                         |
| apt                          | 1.2.24                                     |
| apt-transport-https          | 1.2.24                                     |
| apt-utils                    | 1.2.24                                     |
| base-files                   | 9.4ubuntu4.5                               |
| bash                         | 4.3-14ubuntu1.2                            |
| bind9-host                   | 1:9.10.3.dfsg.P4-8ubuntu1.8                |
| binutils                     | 2.26.1-1ubuntu1~16.04.5                    |
| bsdutils                     | 1:2.27.1-6ubuntu3.3                        |
| btrfs-tools                  | 4.4-1ubuntu1                               |
| ca-certificates              | 20170717~16.04.1                           |
| cloud-initramfs-copymods     | 0.27ubuntu1.4                              |
| cloud-initramfs-dyn-netconf  | 0.27ubuntu1.4                              |
| coreutils                    | 8.25-2ubuntu3~16.04                        |
| cpp-5                        | 5.4.0-6ubuntu1~16.04.5                     |
| cryptsetup                   | 2:1.6.6-5ubuntu2.1                         |
| cryptsetup-bin               | 2:1.6.6-5ubuntu2.1                         |
| curl                         | 7.47.0-1ubuntu2.3                          |
| distro-info-data             | 0.28ubuntu0.3                              |
| dnsmasq-base                 | 2.75-1ubuntu0.16.04.3                      |
...
```

```
# scan
inspec exec ./ -t ssh://ubuntu@<dns-name> --key-files=<keyfile> --sudo --format=json > ubuntu-16.04-inspec.json

# extract patch
patcher extract ubuntu-16.04-inspec.json --format json --output chef-update-linux/data_bags/packagelist/update.json

# run chef-update-linux cookbook
chef-client
```

## Kudos

This tool is based on the initial idea from [Patrick Münch](https://github.com/atomic111) who created the [chef-update-linux](https://github.com/atomic111/chef-update-linux) cookbook.

## License and Author

* Author:: Christoph Hartmann <chris@lollyrock.com>
* Author:: Patrick Münch <patrick.muench1111@gmail.com>
* Author:: Dominik Richter <dominik.richter@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
