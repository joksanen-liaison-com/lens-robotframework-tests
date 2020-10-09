*** Settings ***
Documentation
...  This test suite contains an example test how to use Data Mapping keywords from datamaplibrary.

# Every test case will be forced to have at least the test name as a tag. Any other parameters are optional
Force Tags  ExampleMapTest1
Library  base64
Library  OperatingSystem
Library  Remote  ${REMOTE_LIBRARY_URL}/datamaplibrary

*** Variables ***
${MAP_FILENAME}         XML_to_JSON_test.class
${INPUT_FILENAME}       input.xml
${EXPECTED_FILENAME}    expected.json

*** Test Cases ***
Run Contivo transform and validate output
    [Documentation]     This test case:
    ...                 1. Reads Contivo map (XML_to_JSON_test.class) from local file system.
    ...                 2. Base64 encodes the map content.
    ...                 3. Reads input.xml file from local file system.
    ...                 4. Runs Contivo transform using the Data Mapper Service in ${TEST_ENVIRONMENT}.
    ...                 5. Validates the transform output against expected.json file.

    ${MAP_BIN} =        Get Binary File  ${CURDIR}/${MAP_FILENAME}
    ${MAP} =            B 64 Encode  ${MAP_BIN}
    ${INPUT_XML} =      Get File  ${CURDIR}/${INPUT_FILENAME}

    ${OUTPUT} =         Contivo Run Transform  ${INPUT_XML}  ${MAP_FILENAME}  ${MAP}  ${TEST_ENVIRONMENT}

    ${EXPECTED_JSON} =   Get File  ${CURDIR}/${EXPECTED_FILENAME}

    Validator Validate  ${EXPECTED_JSON}  ${OUTPUT}
