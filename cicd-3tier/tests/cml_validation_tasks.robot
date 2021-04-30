# Demo Script to verify sanity of network

*** Settings ***
# Importing test libraries, resource files and variable files.
Library        ats.robot.pyATSRobot
Library        genie.libs.robot.GenieRobot
Library        unicon.robot.UniconRobot


# Genie Libraries to use
${trigger_datafile}     /pyats/genie_yamls/iosxe/trigger_datafile_iosxe.yaml
${verification_datafile}     /pyats/genie_yamls/iosxe/verification_datafile_iosxe.yaml

*** Test Cases ***
# Creating test cases from available keywords.

Initialize
    # Initializes the pyATS/Genie Testbed
    # pyATS Testbed can be used within pyATS/Genie
    use genie testbed "${testbed}"
    connect to devices "dist-rtr01"
    connect to devices "dist-rtr02"

Common Setup
  run testcase    reachability.pyats_loopback_reachability.common_setup

Capture Configuration
    execute "show running-config" on device "dist-rtr01"

Ping
    run testcase     reachability.pyats_loopback_reachability.PingTestcase    device=dist-rtr01
    run testcase     reachability.pyats_loopback_reachability.PingTestcase    device=dist-rtr02

# Verify OSPF neighbor counts
Verify Ospf neighbors dist-rtr01
    verify count "6" "ospf neighbors" on device "dist-rtr01"
Verify Ospf neighbors dist-rtr02
    verify count "6" "ospf neighbors" on device "dist-rtr02"

# Verify Interfaces
Verify Interface dist-rtr01
    verify count "5" "interface up" on device "dist-rtr01"
Verify Interface dist-rtr02
    verify count "5" "interface up" on device "dist-rtr02"

Terminate
    run testcase "reachability.pyats_loopback_reachability.common_cleanup"
