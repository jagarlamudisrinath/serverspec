require 'spec_helper'

describe command('ls /usr/bin/java') do
	its(:exit_status) { should eq 0 }
end

describe file('/usr/bin/java') do
  it { should exist }
  it { should be_symlink }
  it { should be_linked_to '/etc/alternatives/java' }
end

describe package('ca-certificates') do
  it { should be_installed }
end

describe command('/usr/bin/java -version') do
  let(:disable_sudo) { true }
  its(:stderr) { should match /OpenJDK 64-Bit Server VM/ }
  its(:stderr) { should match /build 1.8.0/ }
end

describe package('openjdk-8-jdk'), :if => ['debian', 'ubuntu'].include?(os[:family]) do
  it { should be_installed }
end

describe package('java-1.8.0-openjdk'), :if => ['redhat', 'centos'].include?(os[:family]) do
  it { should be_installed }
end
describe user('vagrant') do
  it { should exist }
end