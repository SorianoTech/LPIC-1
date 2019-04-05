# Tabla de contenido a revisar de la version 4 a la 5 del **Examen 101**

- [101: System Architecture](#101-system-architecture)
- 

The following changes constitute the update of exam 101 from version 4.0 to version 5.0:

# 101: System Architecture

## 101.1 Determine and configure hardware settings
Removed 'Configure systems with or without external peripherals such as keyboards.'
Removed 'Know the differences between coldplug and hotplug devices.'

## 101.2 Boot the system
Added coverage of UEFI (equal to BIOS coverage) and journalctl (with respect to boot events)

## 101.3 Change runlevels / boot targets and shutdown or reboot system
Added awareness of acpid

# 102: Linux Installation and Package Management

## 102.1 Design hard disk layout
Added EFI System Partition (ESP)

## 102.2 Install a boot manager
(no changes)

## 102.3 Manage shared libraries
(no changes)

## 102.4 Use Debian package management
Removed aptitude
Added awareness of apt.

## 102.5 Use RPM and YUM package management
Removed yumdownloader
Added Zypper (equal to YUM)
Added awareness of dnf
102.6 Linux as a virtualization guest
New objective (weight: 1)
Added specialties of running Linux in a virtual machines and containers on premise and in the cloud

# 103: GNU and Unix Commands

103.1 Work on the command line
Added quoting
Added type and which

103.2 Process text streams using filters
Decreased weight from 3 to 2
Removed expand, fmt, join, pr and unexpand
Added bzcat, md5sum, sha256sum, sha512sum, xzcat and zcat

103.3 Perform basic file management
Added bunzip2 and unxz

103.4 Use streams, pipes and redirects
(no changes)

103.5 Create, monitor and kill processes
Added watch and tmux

103.6 Modify process execution priorities
(no changes)

103.7 Search text files using regular expressions
Increased weight from 2 to 3
Added understanding of the differences between basic and extended regular expressions
Added understanding of the concepts of special characters, character classes, quantifiers and anchors
Added use of regular expressions to delete, change and substitute text

103.8 Basic file editing
Renamed from 'Perform basic file editing operations using vi' to ' Basic file editing'
Clarified wording of 'Understand and use vi modes.'
Removed vi commands c and :e!
Added awareness of other common editors (Emacs, nano and vim) and setting the default editor (EDITOR environment variable)

104: Devices, Linux Filesystems, Filesystem Hierarchy Standard
104.1 Create partitions and filesystems
Removed awareness of ReiserFS
Added GPT partition tables
Added exFAT
Changed awareness of Btrfs to 'Basic feature knowledge of Btrfs, including multi-device filesystems, compression and subvolumes.'

104.2 Maintain the integrity of filesystems
Removed debugfs and dumpe2fs
Changed 'XFS tools (such as xfs_metadump and xfs_info)' to coverage of xfs_repair, xfs_fsr and xfs_db

104.3 Control mounting and unmounting of filesystems
Added use of labels and UUIDs for identifying and mounting file systems
Added awareness of systemd mount units
Added blkid and lsblk

104.4 Manage disk quotas
Removed objective (former weight: 1)

104.5 Manage file permissions and ownership
(no changes)

104.6 Create and change hard and symbolic links
(no changes)

104.7 Find system files and place files in the correct location
(no changes)