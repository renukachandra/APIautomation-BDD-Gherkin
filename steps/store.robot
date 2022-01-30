*** Settings ***
Library          RequestsLibrary
Library          OperatingSystem
Library          json
Library          Collections

*** Variables ***
${BASE_URL}    https://petstore.swagger.io/v2
${POST_JSON}   requests/post_pet.json
${UPDATE_JSON}   requests/update_pet.json

*** Keywords ***
get pets with "available" status
    ${response}=    GET on session  petstore  ${BASE_URL}/pet/findByStatus  params=status=available  expected_status=any
    Set Test Variable   ${response}

Verify response OK status
    Should be equal   ${response.reason}   OK

add a new pet to the store
    ${data_as_string} =    Get File   ${POST_JSON}
    ${data_as_json} =    json.loads    ${data_as_string}
    ${response}=    POST On Session   petstore   ${BASE_URL}/pet  json=${data_as_json}  expected_status=any
    Set Test Variable   ${response}
    Set Test Variable   ${data_as_json}

Verify pet id in response
    ${value1}   Get From Dictionary   ${data_as_json}  id
    ${value2}   Get From Dictionary   ${response.json()}  id
    Should be equal   ${value1}   ${value2}

Update pet status to sold from available
    ${data_as_string} =    Get File    ${UPDATE_JSON}
    ${data_as_json} =    json.loads    ${data_as_string}
    ${response}=    PUT On Session   petstore   ${BASE_URL}/pet  json=${data_as_json}  expected_status=any
    Set Test Variable   ${response}
    Set Test Variable   ${data_as_json}

Verify pet status in response
    ${value1}   Get From Dictionary   ${data_as_json}  status
    ${value2}   Get From Dictionary   ${response.json()}  status
    Should be equal   ${value1}   ${value2}

delete a pet by id
    ${pet_id}=   set variable   123
    ${response}=    DELETE On Session   petstore    ${BASE_URL}/pet/${pet_id}   params=api_key=special-key  expected_status=any
    Set Test Variable   ${response}