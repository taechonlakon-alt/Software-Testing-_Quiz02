*** Settings ***
Library    SeleniumLibrary

Suite Setup       Open Browser    https://chiangmuan.igovapp.com/login    Chrome
Suite Teardown    Close Browser


*** Variables ***
${BASE}          https://chiangmuan.igovapp.com
${WAIT}          20s
${LOGIN_WAIT}    180s


*** Test Cases ***
LOGIN_LINE_THEN_GO_BY_PATH_Health_Diagnostic_Result

    Maximize Browser Window
    Wait Until Page Contains    เข้าสู่ระบบ    timeout=${WAIT}

    Log To Console    =========================
    Log To Console    🔵 กรุณาสแกน LINE QR เพื่อ Login
    Log To Console    ⏳ รอสูงสุด ${LOGIN_WAIT} ...
    Log To Console    =========================

    Wait Until Keyword Succeeds    ${LOGIN_WAIT}    2s    Login Should Be Completed
    Log To Console    ✅ Login สำเร็จ

    Go To    ${BASE}/health
    Wait Until Location Contains    /health    timeout=${WAIT}

    Click And Wait    xpath=//a[@role="button" and contains(@href,"/health/list")]
    Wait Until Location Contains    /health/list    timeout=${WAIT}

    Click And Wait    xpath=//a[contains(@href,"/health/diagnostic?id=")]
    Wait Until Location Contains    /health/diagnostic    timeout=${WAIT}

    Click And Wait    xpath=//a[contains(@href,"/health/form/result?id=")]
    Wait Until Location Contains    /health/form/result    timeout=${WAIT}

    Wait Until Page Contains    คำตอบของท่าน    timeout=${WAIT}


*** Keywords ***
Login Should Be Completed
    ${url}=    Get Location
    Should Contain        ${url}    chiangmuan.igovapp.com
    Should Not Contain    ${url}    access.line.me
    Should Not Contain    ${url}    /login

Click And Wait
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=${WAIT}
    Scroll Element Into View         ${locator}
    ${ok}=    Run Keyword And Return Status    Click Element    ${locator}
    IF    not ${ok}
        Execute Javascript    arguments[0].click();    Get WebElement    ${locator}
    END
    Sleep    0.5
