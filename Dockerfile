# Alpine linux with Robot framework.
# Complete run instructions can be found in the ALLOY E2E Testing using Robot Framework Confluence page:
# https://confluence.liaison.tech/display/ARCH/ALLOY+E2E+Testing+using+Robot+Framework

FROM registry-ci.at4d.liacloud.com/robotframework-tests:1.0.3
LABEL MAINTAINER "https://github.com/mnieminen-liaison-com"

ENV testFolder tests

COPY tests/robot/map $testFolder/map
COPY tests/robot/integration $testFolder/integration

# Run the selected tests using Gradle task 'runRobotTests'
CMD ["sh", "-c", "gradle --offline -PtestFolder=$testFolder -PjsonLogging=true -PtestEnvironment=$TEST_ENVIRONMENT -PremoteUrl=$REMOTE_LIBRARY_URL -PincludeGroups=$INCLUDE_GROUPS -PexcludeGroups=$EXCLUDE_GROUPS -Pdryrun=$DRY_RUN runRobotTests consolidateResults uploadResults"]