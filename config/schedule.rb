set :output, '/var/aminets/log/bp_dialer/cron.log'

every 1.minutes do
  command "cd /Users/scb/Ruby Source Code/bp_dialer && RACK_ENV=production diamo log recover --silent"
end
