#
# Copyright 2015, Noah Kantrowitz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'

describe 'poise_boiler/kitchen', :focus do
  context 'with defaults' do
    file '.kitchen.yml', <<-EOH
---
#<% require 'poise_boiler' %>
<%= PoiseBoiler.kitchen %>

suites:
- name: default
EOH
    context 'kitchen list' do
      command 'kitchen list'
      its(:stdout) { is_expected.to match(/default-ubuntu-1404\s+Vagrant\s+ChefSolo\s+<Not Created>/) }
    end # /context kitchen list
  end # /context with defaults

  context 'with a platform alias' do
    file '.kitchen.yml', <<-EOH
---
#<% require 'poise_boiler' %>
<%= PoiseBoiler.kitchen(platforms: 'linux') %>

suites:
- name: default
EOH
    context 'kitchen list' do
      command 'kitchen list'
      its(:stdout) { is_expected.to match(/default-ubuntu-1404\s+Vagrant\s+ChefSolo\s+<Not Created>/) }
      its(:stdout) { is_expected.to match(/default-ubuntu-1204\s+Vagrant\s+ChefSolo\s+<Not Created>/) }
      its(:stdout) { is_expected.to match(/default-centos-65\s+Vagrant\s+ChefSolo\s+<Not Created>/) }
      its(:stdout) { is_expected.to match(/default-centos-7\s+Vagrant\s+ChefSolo\s+<Not Created>/) }
    end # /context kitchen list
  end # /context with a platform alias
end
