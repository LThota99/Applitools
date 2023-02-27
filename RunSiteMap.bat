@echo off 
cd C:\Applitools\SiteMapDEV
@REM curl https://www.phs.org/sitemap.xml -o proper-sitemap.xml

@REM curl https://presbyterian-hospital.phs.org/sitemap.xml -o presbyterian-sitemap.xml

@REM curl https://kaseman-hospital.phs.org/sitemap.xml -o kaseman-sitemap.xml

@REM curl https://rust-medical-center.phs.org/sitemap.xml -o rust-sitemap.xml

@REM curl https://espanola-hospital.phs.org/sitemap.xml -o espanola-sitemap.xml

@REM curl https://danctrigg-memorial-hospital.phs.org/sitemap.xml -o danctrigg-sitemap.xml

@REM curl https://socorro-general-hospital.phs.org/sitemap.xml -o socorro-sitemap.xml

@REM curl https://lincoln-county-medical-center.phs.org/sitemap.xml -o lincoln-sitemap.xml

@REM curl https://plains-regional-medical-center.phs.org/sitemap.xml -o plains-sitemap.xml

@REM curl https://santa-fe-medical-center.phs.org/sitemap.xml -o santafe-sitemap.xml

set env=%1
set batchName=%2
set appName=%2
set runType=%3
set compareEnv=%4
set YYYYMMDD=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%
set HHMM=%time:~0,2%%time:~3,2%
set batchID=%YYYYMMDD%-%HHMM%
set batchID=%batchID: =%
set protocol=https://
set url=.phs.org
set config=chromeGrid
set baselineBranch=prod
set saveFailTests=true
set APPLITOOLS_API_KEY=NZudHQ103Pfmo5k50wIQN1011027C3M6y57S5rcl3XwYAcjLw110

if %env%==dev-07 (
    set protocol=http://
    set url=-07.phs.org
    set config=dev
    if %runType%==baseline (
        set baselineBranch=%env%
    )
    if %runType%==compare (
        set batchName=%batchName%-Compare
        if [%compareEnv%]==[] ( set baselineBranch=prod ) else ( set baselineBranch=%compareEnv% )
    )
)
if %env%==prod (
    set protocol=https://
    set url=.phs.org
    set config=prod
    if %runType%==baseline (
        set saveFailTests=true
    )
    if %runType%==compare (
        set batchName=%batchName%-Compare
        set saveFailTests=false
    )
)
if %env%==test (
    set protocol=https://
    set url=-test.phs.org
    set config=test
    if %runType%==baseline (
        set baselineBranch=%env%
    )
    if %runType%==compare (
        set batchName=%batchName%-Compare
        if [%compareEnv%]==[] ( set baselineBranch=prod ) else ( set baselineBranch=%compareEnv% )
    )
) else (
    echo "Please enter prod or test or dev-07 only"
)

echo %env%
echo %batchName%
echo %protocol%
echo %url%
echo %config%
echo %baselineBranch%
echo %batchID%

@REM Java -jar ApplitoolsSimpleTestRunner.jar job-sitemap.xml "-var[batchName,%batchName%]" "-var[batchId,%batchID%]" "-var[appName,%appName%-proper]" "-var[sitemapUrl,proper-sitemap.xml]" "-var[protocol,%protocol%]" "-var[urlString,%url%]" "-var[configName,%config%]" "-var[envName,%env%]" "-var[siteUrl,%protocol%www%url%]" "-var[prodUrl,https://www.phs.org]" "-var[baselineBranch,%baselineBranch%]" "-var[saveFailedTests,%saveFailTests%]"
Java -jar ApplitoolsSimpleTestRunner.jar job-sitemap.xml "-var[batchName,%batchName%]" "-var[batchId,%batchID%]" "-var[appName,presbyterian-hospital]" "-var[sitemapUrl,presbyterian-sitemap.xml]" "-var[protocol,%protocol%]" "-var[urlString,%url%]" "-var[configName,%config%]" "-var[envName,%env%]" "-var[siteUrl,%protocol%presbyterian-hospital%url%]" "-var[prodUrl,https://presbyterian-hospital.phs.org]" "-var[baselineBranch,%baselineBranch%]" "-var[saveFailedTests,%saveFailTests%]"
@REM Java -jar ApplitoolsSimpleTestRunner.jar job-sitemap.xml "-var[batchName,%batchName%]" "-var[batchId,%batchID%]" "-var[appName,kaseman-hospital]" "-var[sitemapUrl,kaseman-sitemap.xml]" "-var[protocol,%protocol%]" "-var[urlString,%url%]" "-var[configName,%config%]" "-var[envName,%env%]" "-var[siteUrl,%protocol%kaseman-hospital%url%]" "-var[prodUrl,https://kaseman-hospital.phs.org]" "-var[baselineBranch,%baselineBranch%]" "-var[saveFailedTests,%saveFailTests%]"

set APPLITOOLS_SERVER_URL=https://eyesapi.applitools.com
echo %batchID%
curl -v --location --request DELETE "%APPLITOOLS_SERVER_URL%/api/sessions/batches/%batchID%/close/bypointerid?apiKey=NZudHQ103Pfmo5k50wIQN1011027C3M6y57S5rcl3XwYAcjLw110"