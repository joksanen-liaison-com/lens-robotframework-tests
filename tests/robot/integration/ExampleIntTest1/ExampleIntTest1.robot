*** Settings ***
Documentation
...  This an example integration test.

Force Tags  Integration


Library     OperatingSystem

*** Variables ***


*** Test Cases ***

Log message to console
    [Documentation]     This test case:
    ...                 1. Logs a message to console

    LOG To Console      "Log this message to console"
