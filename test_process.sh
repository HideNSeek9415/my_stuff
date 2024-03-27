#!/bin/bash

echo "Xem PID của tiến trình init."
ps -ax | more
ps -ax | grep init
read -p "Nhấn Enter để tiếp tục"
clear

echo "Xem PID và PPID của tiến trình login."
ps -ef | more
ps -ef | grep login
read -p "Nhấn Enter để tiếp tục"
clear

echo "Xem trong hệ thống có những tiến trình nào đang hoạt động."
ps -ax | more
read -p "Nhấn Enter để tiếp tục"
clear

echo "Xem cấu trúc cây tiến trình, cho biết chức năng của tiến trình init."
pstree -np | more
read -p "Nhấn Enter để tiếp tục"
clear

echo "Đếm xem có bao nhiêu tiến trình đang hoạt động trong hệ thống."
ps -ax | more
ps -ax | wc -l
read -p "Nhấn Enter để tiếp tục"
clear

echo "Khởi tạo tiến trình có tên named và sendmail."
service named start
service sendmail start
read -p "Nhấn Enter để tiếp tục"
clear

echo "Xem PID của tiến trình named và sendmail."
ps -ax | grep named
ps -ax | grep sendmail
read -p "Nhấn Enter để tiếp tục"
clear

echo "Kiểm tra xem tiến trình named có đang hoạt động và cho biết PID."
ps -ax | grep named
read -p "Nhấn Enter để tiếp tục"
clear

echo "Hủy tiến trình named và sendmail sau đó kiểm tra."
pkill named
pkill sendmail
ps -ax | grep -E "name|sendmail"
read -p "Nhấn Enter để tiếp tục"
clear

echo "Kiểm tra xem user có tên hv1 đang sử dụng những chương trình nào."
ps -au hv1
read -p "Nhấn Enter để tiếp tục"
clear

echo "Thực hiện hai thao tác sau để tạo tiến trình tiền cảnh (foreground process):"
echo "Kích hoạt tiện ích mc"
echo "Tìm tập tin pass bằng lệnh"
find / -name pass
read -p "Nhấn Enter để tiếp tục"
clear

echo "Thực hiện các thao tác sau để tạo tiến trình hậu cảnh (background process):"
echo "Khởi tạo tiến tình hậu cảnh bằng lệnh"
find / -name abc.txt &
read -p "Nhấn Enter để tiếp tục"
clear

echo "Khởi tạo dịch vụ named"
service named restart
read -p "Nhấn Enter để tiếp tục"
clear

echo "Xem tiến trình hậu cảnh find và named."
jobs
read -p "Nhấn Enter để tiếp tục"
clear

echo "Thống kê thông suất hệ thống."
echo "Xem tài nguyên hệ thống"
top
