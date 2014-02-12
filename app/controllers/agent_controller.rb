class AgentController < ApplicationController
  BASE_URL = 'http://localhost:8080'

  def install
    render text: <<-SCRIPT
import sys
import os
import socket
import urllib2
import json

print 'Installing Lighthouse Agent'
print '==========================='
print

hostname = socket.gethostname()
print "Hostname: " + hostname

ip = socket.gethostbyname(hostname)
print "IP: " + ip

platform = sys.platform
print "Platform: " + platform

data = { 'host': { 'hostname': hostname, 'ip': ip }}
req = urllib2.Request("#{BASE_URL + hosts_path}", json.dumps(data), {'Content-Type': 'application/json'})
f = urllib2.urlopen(req)
response = f.read()
f.close()

    SCRIPT
  end
end
