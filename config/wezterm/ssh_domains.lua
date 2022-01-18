local ssh_domains = {}

if pcall(function () 
	ssh_domains = require '../../secret/wezterm_ssh_domains';
end) then
	return ssh_domains
else
	return ssh_domains
end
