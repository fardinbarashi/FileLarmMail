Start-Transcript -Path $PSScriptRoot\Transscriptlog.txt -Force

# SMTP Settings
 $MailSubject = "Type MailTitle"
 $MailBody =  "Type MailBody Text , Unc $FileReport"
 $MailTo = "User@Company.com"
 $MailFrom = "larm@Company.com"
 $SmtpServer = ""

# Timespan Setttngs
$TimeSpanDays = "0"
$TimeSpanHours = "0"
$TimeSpanMins = "0"

# FileType Settings
$Filetypes = "*.xml"

# Path To monitor
$FilePath = ""

Try 
 { # Start Try
   # 
   $CheckFiles = @(get-childitem $FilePath -force | where {($_.Creationtime -lt (Get-Date).AddDays(-$TimeSpanDays).AddHours(-$TimeSpanHours).AddMinutes(-$TimeSpanMins)) -and ($_.psIsContainer -eq $false)})
   
   Function GenerateMailForEachFile 
    { # Start Function GenerateMailForEachFile 
      # Send Mail 
      Send-MailMessage -To "$MailTo" -from "$MailFrom" -Subject $MailSubject -Body $MailBody -SmtpServer $SmtpServer -Encoding ([System.Text.Encoding]::UTF8)
    } # End Function GenerateMailForEachFile 

    if ($CheckFiles -ne $NULL)
    { # Start If
     For ($Idx = 0; $Idx -lt $CheckFiles.Length; $Idx++)
      { # Start 
        $Files = $CheckFiles[$Idx]
        $FileReport = $Files
        # Generate a mail for each file
        GenerateMailForEachFile
       } # End 
    } # End If

 } # End Try

Catch
 { # Start Try
  Write-Warning -Message "Warning, Script could not start"
  Write-Warning $Error[0]
 } # End Try

Stop-Transcript



