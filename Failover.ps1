# Import the SQL Server Module
Import-Module SQLPS -DisableNameChecking

# Get the available SQL cluster groups
$clusterGroups = Get-ClusterGroup | Where-Object {($_.Name -ne "Available Storage") -and ($_.Name -ne "Cluster Group")}

#Add Manual Option for 'All'
$clusterGroups += New-Object PSObject -Property @{Name = "All"}

# Display the available SQL Server Cluster groups
Write-Host "Available SQL Server Cluster Groups:"
for ($i = 0; $i -lt $clusterGroups.Count; $i++) {
    Write-Host "$($i + 1). $($clusterGroups[$i].Name)"
}

# Prompt the user to select a SQL Server Cluster Group
$selection = Read-Host "Enter the number corresponding to the SQL Server Cluster Group"

# Validate the user's selection
if ($selection -ge 1 -and $selection -le $clusterGroups.Count) {
    $selectedClusterGroup = $clusterGroups[$selection - 1].Name
    Write-Host "You selected: $selectedClusterGroup"
    } else {
        Write-Host "Invalid selection. Please enter a number between 1 and $($clusterGroups.Count)"
        }


# Get the available SQL cluster nodes
$clusterNodes = Get-ClusterNode

# Display the available SQL Server Cluster groups
Write-Host "Available SQL Server Cluster Nodes:"
for ($i = 0; $i -lt $clusterNodes.Count; $i++) {
    Write-Host "$($i + 1). $($clusterNodes[$i].Name)"
}

# Prompt the user to select a SQL Server Cluster Group
$Nodeselection = Read-Host "Enter the number corresponding to the SQL Server Cluster Node"

# Validate the user's selection
if ($Nodeselection -ge 1 -and $Nodeselection -le $clusterNodes.Count) {
    $selectedClusterNode = $clusterNodes[$Nodeselection - 1].Name
    Write-Host "You selected: $selectedClusterNode"
    } else {
        Write-Host "Invalid selection. Please enter a number between 1 and $($clusterNodes.Count)"
        }

Write-Host "Currently attempting to move $selectedClusterGroup to $SelectedClusterNode..."

#Move the Cluster Group to another Node Resource
Move-ClusterGroup -Name $selectedClusterGroup -Node $SelectedClusterNode
