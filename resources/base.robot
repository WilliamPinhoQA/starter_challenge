**Settings**
Documentation   Base Hooks
Library         Browser
Library         String
Resource       actions.robot

**Variables**
${BASE_URL}         https://nbank.vercel.app
@{BROWSER}          chromium        firefox         webkit

**Keywords**
Start Session
    New Browser     ${browser[0]}       #headless=False  slowMo=00:00:02
    New Page        ${BASE_URL}  

End Session
    Take Screenshot