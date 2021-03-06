#
# Copyright 2015-2016, Noah Kantrowitz
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


module PoiseBoiler
  autoload :Helpers, 'poise_boiler/helpers'
  autoload :Kitchen, 'poise_boiler/kitchen'

  # (see PoiseBoiler::Kitchen#kitchen)
  def self.kitchen(**options)
    # Alias in a top-level namespace to reduce typing.
    Kitchen.kitchen(**options)
  end
end
