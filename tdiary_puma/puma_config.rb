#!/usr/bin/env puma

application_path = "#{File.expand_path('../', __FILE__)}"
environment        "production"
state_path         "#{application_path}/tmp/puma.state"
pidfile            "#{application_path}/tmp/pids/puma.pid"
stdout_redirect    "#{application_path}/tmp/logs/puma.stdout.log", "#{application_path}/tmp/logs/puma.stderr.log"
bind               "unix://#{application_path}/tmp/sockets/puma.sock"
threads 0, 10
