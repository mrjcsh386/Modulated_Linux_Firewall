# Modulated_Linux_Firewall

<<<<<<< HEAD
### Note:
As of current, this is me developing the 'paranoid' posture, as this is the continuation of my pet project for firewalling. So, stay tuned for different postures such as low, medium, high, and paranoid.

### Usage:
#### Protocol access:
As it stands so far, the rules laid out require the creation of a handful of user groups. In my personal environment, they are ssh-client, www-client, irc-client respectively, and the group dialout permits DNS inquiries.

The reasoning behind this strategy is to permit access to protocols outbound by way of a password. This allows a user on a subshell only basis to access the protocol across the wire, while denying other processes that haven't been authenticated that are in addition owned by the same user. Perhaps you're a power user, and are concerned about a exploitation pulling data off the internet? Granted it's more likely to be an issue if you're the one reaching, but we can discuss that in more detail if you'd like.

Add users to dialout that you want to permit access to the world wide interwebs. For this group, I haven't set a password for it.

Add users to www-data, issue `sudo gpasswd www-data` and grant a reasonably strong password to it.
After you have configured your target group, as www-data is just an example, use the `newgrp www-data` command to be granted a password prompt, enter the details you've given before to be dropped into a sub-shell with the privileges that that group has. Since it's a sub-shell, simply issue `exit` when you're done, and you'll return to the shell you issued newgrp under.

#### Performing system updates:
As much as it would be great to maintain an IPSet named garden-apt hosting all accessable IPs associated to a particular FQDN hostname, and granting control back to the round-robin, I've opted to make inqueries for resolving of hostnames during the time of issuing the commands to update the host to be done at the time. So, for now you'll have to call /usr/local/share/iptables/host-updates by hand, or as a component of a wrapper to permit access for apt repositories. If there is any one using any other operating system that handles this process where one can modify that script to permit updates on a PID, or [U|G]ID basis, I'd love to hear from you!
=======
>>>>>>> fb502ac (On branch main)
