# script <device path> - <mount path> - <file system> - <nas name> - <smb usename> - <smb passwd>

apt install nfs-server samba -y
echo "$1 $2 $3 defaults 0 2" >> /etc/fstab
echo "$2 192.168.1.0/24(rw,no_root_squash)" >> /etc/exports
exportfs -a

echo "[$4]" >> /etc/samba/smb.conf
echo "comment = Data" >> /etc/samba/smb.conf
echo "browseable = yes" >> /etc/samba/smb.conf
echo "path = $2" >> /etc/samba/smb.conf
echo "guest ok = no" >> /etc/samba/smb.conf
echo "read only = no" >> /etc/samba/smb.conf
echo "create mask = 0700" >> /etc/samba/smb.conf

newusername=$5
newpasswd=$6
(echo $newpasswd; echo $newpasswd) | smbpasswd -s -a $newusername

# Copied from: https://askubuntu.com/questions/1266/how-to-set-up-ubuntu-server-as-a-nas
