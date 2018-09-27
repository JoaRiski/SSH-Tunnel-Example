# SSH Tunnel Example

## Scenario

In this configuration, we have 3 different containers:
1. MySQL server
2. VPN
3. MySQL client

We also have two networks, being:
1. MySQL server <-> VPN
2. VPN <-> MySQL client

The MySQL client and MySQL server do not share a direct network together, but instead the
MySQL client must hop through the VPN to connect to the MySQL server.

## Instructions

1. First open a bash on the MySQL container by doing `docker exec -it sshte-mysql-client bash`
2. In the VPN container, run `ssh -4 -L 3306:sshte-mysql-server:3306 root@sshte-vpn -N` to open the SSH tunnel.
	* Password for the SSH user is `root`
	* Leave the SSH tunnel running
4. Fire up another bash on the MySQL client container (`docker exec -it sshte-mysql-client`)
5. You can now connect to the MySQL server from the MySQL client
	* `mysql -u root -proot -h 127.0.0.1 -P 3306`


## Notes

In an actual real world use case, you would want to use SSH keys instead of a password, and to
automate the tunnel creation entirely.

This could be achieved by:
- Creating a `ssh` folder in the project that will house developer ssh keys
	* Make sure the actual contents are in .gitignore
- Instruct on how to use `ssh-keygen` to generate a new ssh key inside that folder
- Instruct developers to use `ssh-copy-id <username>@<VPN>` to authenticate their new ssh key
- With docker-compose, mount the `ssh` folder to the tunnel container

It is also a good idea to have the tunnel in an entirely separate container, rather than the
same as what is using it. The tunnel and client containers should share the same network. Adapted
to this example, such a configuration would look like `MySQL client -> Tunnel container -> VPN -> MySQL server`.
