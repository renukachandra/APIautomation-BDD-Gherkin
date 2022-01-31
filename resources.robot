*** Settings ***
Library          RequestsLibrary

*** Variables ***
${BASE_URL}    https://petstore.swagger.io/v2

*** Keywords ***
Suite Setup
    Create Session  petstore  ${BASE_URL}
