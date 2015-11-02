#
# Cookbook Name:: scpr-transcoder
# Recipe:: default
#
# Copyright 2015 Southern California Public Radio
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -- Install Dependencies -- #

include_recipe "scpr-tools::ffmpeg"
include_recipe "runit"
include_recipe "nodejs"
include_recipe "scpr-consul"

# -- Install Transcoder -- #

user node.scpr_transcoder.user do
  action  :create
  home    node.scpr_transcoder.dir
  system  true
end

directory node.scpr_transcoder.dir do
  action    :create
  owner     node.scpr_transcoder.user
  recursive true
  mode      0755
end

["public","tmp"].each do |d|
  directory "#{node.scpr_transcoder.dir}/#{d}" do
    action  :create
    owner   node.scpr_transcoder.user
    mode    0755
  end
end

template "#{node.scpr_transcoder.dir}/transcoder-cmd" do
  action  :create
  owner   node.scpr_transcoder.user
  mode    0755
end

nodejs_npm "sm-transcoder" do
  action    :install
  version   node.scpr_transcoder.version
  path      node.scpr_transcoder.dir
  user      "transcoder"
  notifies  :restart, "service[transcoder]"
end

# -- Set up transcoder service -- #

runit_service "transcoder" do
  default_logger true
  run_template_name "sm-transcoder"
  options({
    dir:    node.scpr_transcoder.dir,
    user:   node.scpr_transcoder.user,
    port:   node.scpr_transcoder.port,
  })
end

consul_service_def node.scpr_transcoder.consul_service do
  action    [:create]
  port      node.scpr_transcoder.port
  notifies  :reload, "service[consul]"
end


