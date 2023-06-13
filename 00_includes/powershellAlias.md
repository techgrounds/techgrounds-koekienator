
### Sources
https://betterprogramming.pub/a-step-by-step-walkthrough-to-create-your-first-ssh-config-file-f01267b4eacb
https://superuser.com/questions/1537763/location-of-openssh-configuration-file-on-windows

### Locate your profile
``Echo $profile``

If theres no profilefile yet create one.
``Create <Path/to/profile> Microsoft.PowerShell_profile.ps1``

Edit the file with the alias you want to make.
For a path, this one takes you to my documents:
``` 
Function goHome {
    Set-Location -Path "C:\Users\<username>\My Documenets\"
    }
Set-Alias -Name home -Value goHome
``` 