
# txAdmin Installation Script

This is a script for the automatic installation of **txAdmin** and everything needed to run a game server supported by **txAdmin**. The script installs **Apache2** (web server) and **PHP**, which are required to run **phpMyAdmin** — a tool to manage your server's database. Additionally, it installs **MariaDB** to create the database and automatically creates a user for it.

## Help and Support

If you have any questions or need assistance, you can join our Discord server for support and additional questions. [Join our Discord](https://discord.gg/Q7A7RPDSDQ) 🎮

## Supported Installations

| Operating System     | Version | Supported   |
|----------------------|---------|-------------|
| **Ubuntu**           | 14.04   | 🔴          |
|                      | 16.04   | 🔴          |
|                      | 18.04   | 🔴          |
|                      | 20.04   | ✅          |
|                      | 22.04   | ✅          |
|                      | 24.04   | ✅          |
| **Debian**           | 8       | 🔴          |
|                      | 9       | 🔴          |
|                      | 10      | ✅          |
|                      | 11      | ✅          |
|                      | 12      | ✅          |
| **CentOS**           | 6       | 🔴          |
|                      | 7       | 🔴          |
|                      | 8       | 🔴          |
| **Rocky Linux**      | 8       | 🔴          |
|                      | 9       | 🔴          |
| **AlmaLinux**        | 8       | 🔴          |
|                      | 9       | 🔴          |

*Expect improvements and support for more versions soon.* 🚀

## Using the Installation Scripts

To automatically install the script, use the following command:

```bash
bash <(curl -s https://fixar.host/script/txadmin.sh)
```

This command will download and start the script, which will install **MariaDB**, **Apache2**, **PHP**, and configure **txAdmin** and **MySQL users**.

### Verification Code Check

To verify the four-digit verification code, use the command:

```bash
nano /root/fivem/txadmin_output.log
```
![](https://fixarhost.com/script/txadmin-pin.png)

This command will open the log file where you can see the login code. This procedure is executed only once after installation.

### Exiting nano

To exit the **nano** editor, press **Ctrl + X** and then **N** (No) to avoid saving any changes.

## Accessing txAdmin and phpMyAdmin

After installation, you can access the following services:

- **txAdmin** at the following address:  
  `http://<Your_IP>:<Port>` 🌐

- **phpMyAdmin** at the following address:  
  `http://<Your_IP>/phpmyadmin` 🔑

## Contributors

**Copyright © 2024-2025 [FixarHost Ltd](https://find-and-update.company-information.service.gov.uk/company/15980077). Company number: [15980077](https://find-and-update.company-information.service.gov.uk/company/15980077)**

**Created by: [Aleksandar Ivanov](https://github.com/NekotinaX)**

**Maintained by:** the team at **FixarHost**



