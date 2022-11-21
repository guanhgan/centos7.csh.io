systemctl stop firewalld
systemctl disable firewalld
setenforce 0
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

swapoff -a
sed -i '/swap/s/^/#/g' /etc/fstab
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
yum clean all && yum makecache
mkdir /backup
cp /etc/security/limits.conf /backup
cat >> /etc/security/limits.conf <<EOF
*  soft  nofile  65535
*  hard  nofile  65535
*  soft  nproc  65535
*  hard  nproc  65535
EOF

ping www.baidu.com -c 1
reboot
