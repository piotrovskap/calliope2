---
source: DAS Confluence
page_id: 3474817026
title: eLead Set Up | CRM Process
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3474817026
type: confluence-doc
repulled: 2026-06-09
---

# Purpose

This document was written to describe how to turn on and ingest a new file for eLeads.

## Connect to Server

1.  Connect 32 & 33 server using respective IP using Remote Desktop Connection: 

    1.  33 Server : 10.254.210.33 

    2.  32 Server : 10.254.210.32 

 2. Login to AWS VPN

3.  Search for Remote Desktop Server 

    1.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3474817026/image-20250911-201746.png?api=v2" class="confluence-embedded-image image-center" width="106" alt="image-20250911-201746.png" /></span>

4.  Connect to 32 Server: 10.254.210.32 

    1.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3474817026/image-20250911-201736.png?api=v2" class="confluence-embedded-image image-center" width="290" alt="image-20250911-201736.png" /></span>

5.  Connect and Enter Password (Tiff has one – may need to get CAST a PW) 

    1.  YES 

6.  Then Search Windows for SQL Server Mangement Studio 

    1.  Login (PW in Last Pass) owned by Tiffany right now but will move to CAST folder after testing 

    2.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3474817026/image-20250911-201839.png?api=v2" class="confluence-embedded-image image-center" width="512" alt="image-20250911-201839.png" /></span>

 

### Update in Database Table (Analytics_Clients)

1.  Click New Query 

2.  Search boxes use EDW_target and hash 

3.  Copy and paste as plain text the following highlighted text – be sure to update these 4 areas with client specific details:  client ID, CRMUserName and CRMPassword, and ClientID: 

4.  <div class="code panel pdl">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    select * 
      from Analytics_Clients 
      where clientid=182567
    ```

    </div>

    </div>

5.  <div class="code panel pdl">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
     update analytics_clients 
    set 
      IsCRM=1, 
      IsInternal=1, 
      CRMUserName='mbcutlerbay@cat.dasclient.com',
      CRMPassword='D1g12023!'
    where ClientID=182567; 
    ```

    </div>

    </div>

6.  Click the blue check mark 

    1.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3474817026/image-20250911-201854.png?api=v2" class="confluence-embedded-image image-center" width="583" alt="image-20250911-201854.png" /></span>

7.  Connect to 33 Server: 10.254.210.33

    1.  May request laptop PIN number 

    2.  YES

8.  Then I used Tiffany Walker and put in my password for 3 Birds AWS VPN 

9.  Go to File Explorer \> This PC \>Local Disk (C:) \> CRM_Storage \> EL (for eLeads) 

10. Make New Content Grabber from existing by changing parameters in 33 Server: 

11. Save as new folder in --\> C:\Users\Public\Downloads\CG_CRM_Export\EL---(33 server) (for eLeads) 

12. Add transfer line in --\> C:\CRM_Storage\CG_CRM_Export.bat 

13. Create folder in --\> E:\Data\CRM\CG_CRM_Export\EL --(32 server) 

14. Add transfer line in --\> E:\Data\CRM\CG_CRM_Export_Copy.bat

15. Add renaming line in --\> E:\Data\CRM\RenameCRM.bat 

16. Add move renamed file line in --\> E:\Data\CRM\Move_RenamedFiles.bat --\> Store all files to E:\Data\CRM\CG_CRM_Export\EL\Daily Folder and eventually it will move files to staging folder. 

17. After this all process is general and another C# script will move all the files of all the clients to staging folder. 

18. SSIS will pick files from here and process it further. 

<div class="confluence-information-macro confluence-information-macro-note">

<span class="aui-icon aui-icon-small aui-iconfont-warning confluence-information-macro-icon"></span>

<div class="confluence-information-macro-body">

 NOTE : Be cautious while adding lines to .bat files for clientid, clientname, foldername. 

</div>

</div>

### Video Walkthrough

<a href="https://digitalairstrike.sharepoint.com/:v:/s/ApplicationSupport/EZwKGqjHMBZGsw3-dgEzFEYBT-a8mQOiIICXQ3S72cK1Kw?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D&amp;e=cnvdN8" class="external-link" data-card-appearance="inline" rel="nofollow">https://digitalairstrike.sharepoint.com/:v:/s/ApplicationSupport/EZwKGqjHMBZGsw3-dgEzFEYBT-a8mQOiIICXQ3S72cK1Kw?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D&amp;e=cnvdN8</a>
