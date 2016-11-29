function drunner_setup()
  addvolume("drunner-${SERVICENAME}-data")
end

function start()
  result=drun("docker", "run", "-d", "-p", "8081:8080", "-p", "50000:50000",
    "--name", "drunner-${SERVICENAME}", "--restart=always", 
    "-v", "/etc/timezone:/etc/timezone:ro",
    "-v", "/var/run/docker.sock:/var/run/docker.sock",
    "-v", "drunner-${SERVICENAME}-data:/var/jenkins_home",
    "${IMAGENAME}")

  if result~=0 then
    print("Failed to start Jenkins.")
  end
end

function stop()
  dstop("drunner-${SERVICENAME}")
end

function update_start()
  if drunning("drunner-${SERVICENAME}") then
    dstop("drunner-${SERVICENAME}")
  end
end

function uninstall_start()
  if drunning("drunner-${SERVICENAME}") then
    dstop("drunner-${SERVICENAME}")
  end
end