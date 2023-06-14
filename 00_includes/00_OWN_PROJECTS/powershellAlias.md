
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
``` 

Improved the function. It now takes me to my repository I've set and shows me git status. 
```
function goRepository {
	# Needed to use variables in the function
    	param()

    	# Set the target directory path
    	$goDirectory = "SET/YOUR/OWN/DIRECTORY/HERE"
	
	# Check if directory exists
	if (!(Test-Path $goDirectory -PathType Container)) {
        	Write-Host "The target directory does not exist."
        	return
    	}

	# Set location to the specific path
	Set-Location -Path $goDirectory

	# Wait till changed to the path
	Out-Null

	# Get git status
    	git status

}
```
