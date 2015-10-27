# OpenStack Triggers

## Description

OpenStack Triggers provides a set of SQL scripts for
[OpenStack](www.openstack.org) that permit to log additionnal
information in the database.

The project provides the following script:
* neutron-triggers.sql: A set of triggers that log floating ips
association to a VM. It permits to known which floating floating ips
was associated to a VM and when.


## Installation

To install the triggers, enter a console:

    mysql -uroot -p < neutron-triggers.sql


## License

OpenStack Triggers is free software; it is licensed under the Apache License,
Version 2.0 (the "License"); you may not use this file except in
compliance with the License. You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
