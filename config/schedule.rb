every 1.minute do
  runner "FetchArticlesJob.perform_later"
  command "echo 'Heartbeat check at #{Time.now}'"
end
