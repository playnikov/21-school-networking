$rules = "Block_http_conn","Allow_rdp_conn","Block_ftp_conn","Block_ping_conn"

$result = foreach ($r in $rules) {
	Get-NetFirewallRule -DisplayName $r | Select-Object DisplayName, Enabled, Direction, Action, Profile,
	@{Name="Protocol";Expression={
		(Get-NetFireWallPortFilter -AssociatedNetFirewallRule $_).Protocol
	}}, @{Name="LocalPort";Expression={
		(Get-NetFirewallPortFilter -AssociatedNetFirewallRule $_).LocalPort
	}}, @{Name="RemotePort";Expression={
		(Get-NetFirewallPortFilter -AssociatedNetFirewallRule $_).RemotePort
	}}
}

$result | Format-Table -AutoSize