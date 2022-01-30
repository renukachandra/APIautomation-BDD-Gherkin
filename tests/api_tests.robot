*** Settings ***
Resource         ../steps/main.robot
Resource         ../steps/store.robot
Suite Setup      Suite Setup

*** Test Cases ***
GET verify get all pets from store
    WHEN get pets with "available" status
    THEN Verify response OK status

POST verify a new pet added to store
    WHEN add a new pet to the store
    THEN Verify pet id in response

PUT verify a pet status changed in store
    WHEN Update pet status to sold from available
    THEN Verify pet status in response

DELETE verify a pet deleted from store successfully
    WHEN delete a pet by id
    THEN Verify response OK status