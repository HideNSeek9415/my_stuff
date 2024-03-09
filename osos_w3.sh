#!/bin/bash

#In so nguoi dung do he thong tao ra
echo "1-1. So nguoi dung do he thong tao ra: $(wc -l < /etc/passwd)"

#Tim user co ID = 100
userID_100=$(awk -F':' '$3 == 100 {print $1}' /etc/passwd)
if [ -z $userID_100 ];then
	echo "1-2. User voi ID 100 khong ton tai"
else
	echo "1-2. User voi ID 100 la: $userID_100"
fi
echo ""

#Tim tat ca cac user co ID = 100 va luu vao dsuser
mkdir -p baitap && touch baitap/duser && grep "x:100:0" /etc/passwd > baitap/dsuser
vi baitap/dsuser

vi /etc/group
#Sử dụng "!set nu" để hiển thị số dòng

#Them 3 group va 7 user vao cac group tuong ung
groupadd hocvien
groupadd admin
groupadd user
echo "4. Danh sach cac nhom da tao:"
cat /etc/group | grep "^hocvien:\|^admin:\|^user:"

pass="123456"
for i in {1..3}; do
	useradd -c"Hoc Vien $i" -d "/home/hv$i" -m -g hocvien "hv$i"
	echo "$pass" | passwd --stdin "hv$i"
done
for i in {1..3}; do
	useradd -c"Admin $i" -d "/home/adm$i" -m -g admin "adm$i"
	echo "$pass" | passwd --stdin "adm$i"
done
for i in {1..2}; do
	useradd -c"User $i" -d "/home/user$i" -m -g user "user$i"
	echo "$pass" | passwd --stdin "user$i"
done
echo ""

#in ra cac user vua tao
function shw_id {
	echo -n "Thong tin user $1$2: "
	id "$1$2"
}

for i in {1..8}; do
	if [ $i -lt 4 ]; then
		shw_id "hv" "$i" 
	elif [ $i -lt 7 ]; then
		shw_id "adm" "$(($i - 3))"
	else 
		shw_id "user" "$(($i - 6))"		
	fi
done
echo ""

usermod -u 0 -o adm1
usermod -u 0 -o adm2

#Xoa Hoc vien 3 khoi group hocvien
function del_user_in_grp {
	result=""
	if ! id -u $1 > /dev/null; then
		result="Nguoi dung $1 khong ton tai"
	elif ! grep -q "^$2:" /etc/group; then
		result="Group $2 khong ton tai"
	elif ! id -nG "$1" | grep -q "$2"; then
		result="Nguoi dung $1 khong ton tai trong group $2"
	else
		userdel -r "$1"
		result="Da xoa nguoi dung $1 khoi group $2"
	fi
	echo "$result"
}

del_user_in_grp hv3 hocvien
if grep -q "^hv3:" /etc/passwd; then
	echo "Hoc Vien 3 van ton tai"
else
	echo "Hoc Vien 3 da bi xoa"
fi
echo ""

des="Nguoi dung quan tri he thong"
usermod -c "$des" adm1
usermod -c "$des" adm2

#In thong tin 2 admin sau khi thay doi mota va uid
echo "Thong tin 2 admin sau thay doi: "
grep "^adm1:" /etc/passwd
grep "^adm2:" /etc/passwd
echo ""

usermod -g hocvien user1
passwd -l user1
passwd -l user2
passwd -u user1

#in thong tin cua user1 va user 2 sau thay doi
echo "Thong tin user1 va user2 sau thay doi: "
grep "^user1:" /etc/passwd
grep "^user1:" /etc/shadow
grep "^user2:" /etc/passwd
grep "^user2:" /etc/shadow
echo""

#Xoa user2
userdel user2
if grep -q "^user2:" /etc/passwd; then
	echo "user2 van ton tai"
else
	echo "user2 da bi xoa"
fi
echo ""

#Xem thong tin tep dsuser
cp /etc/passwd /data/dsuser
chmod 640 /data/dsuser
echo "Thong tin tep 'dsuser'"
ls -l /data | grep "dsuser$"
echo ""

#Xem thong tin thu muc baitap
chmod 740 baitap
echo "Thong tin thu muc 'baitap'"
ls -l | grep "baitap$"
echo ""

touch Desktop/before.txt
umask 026
touch Desktop/after.txt
umask 022

#Thong tin 2 file truoc va sau khi thay doi quyen mac dinh
echo "Thong tin 2 file vua tao"
ls -l Desktop | grep "before.txt\|after.txt"
echo ""

#Thong tin file truoc va sau khi doi chu so huu
echo "Truoc khi doi chu so huu /data/dsuser"
ls -l /data | grep "dsuser$"

chown hv1:hocvien /data/dsuser
echo "Sau khi doi chu so huu /data/dsuser"
ls -l /data | grep "dsuser$"

