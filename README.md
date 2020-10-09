Robot Framework tests for Lens
This is a shared repository for Robot Framework tests targeting different Lens sub-systems.

Conventions
Robot test cases in this repository shall be placed and categorized by Lens sub-system or domain under the tests directory:

Lens
 -- lens-api
 -- lens-error-publisher-service
 -- lens-metadata-publisher-service
 -- lens-publishing-api
 -- lens-web

The robot test files shall be placed next to the common directory into separate sub-directories. Tests from different sub-directories can be grouped into suites by utilizing tags in the robot files.

See also: examples

Documentation
ALLOY Robot Framework library documentation (Confluence)
Executing test
Using robotrunner

$ robotrunner $TEST_FOLDER --processes <parallel-process-count> --test-environment <environment> --remote-library <remote-library-url> --include <tags> --exclude <tags> --verbose 
See the complete robotrunner documentation for Robot Framework tests from: robotframework-runner

Related projects
ALLOY Robot Framework Library
robotrunner for Robot Framework Tests
