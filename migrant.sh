#!/bin/bash

cat << EOF
                                                        

          "                                  m
 mmmmm  mmm     mmmm   m mm   mmm   m mm   mm#mm
 # # #    #    #" "#   #"  " "   #  #"  #    #
 # # #    #    #   #   #     m"""#  #   #    #
 # # #  mm#mm  "#m"#   #     "mm"#  #   #    "mm
                m  #
                 ""
                                                                                                                 
EOF

echo -n "Введите имя пользователя, которого хотите проверить: "
read user_
if grep $user_ /etc/passwd ; then
	echo "========================"
	read -p "Данный пользователь существует. Что Вы хотите с ним сделать? Удалить, переименовать, выдать рут-права или просто узнать наличие (d/rn/rt/ctrl + c)?" action_ 
	if [ $action_ == "d" ]; then
		sudo deluser $user_
		echo "Пользователь удалён"
	elif [ $action_ == "rn" ]; then
		read -p "Введите новое имя пользователя: " new_name_
		sudo usermod -l $new_name_ -d /home/$new_name_ -m $user_
		sudo groupmod -n $new_name_ $user_
		sudo ln -s /home/$new_name_ /home/$user_
		echo "Пользователь переименован"
	elif [ $action_ == "rt" ]; then
		sudo adduser $user_ sudo
	    echo "Рут-права выданы"
    fi
else
	read -p "Такого пользователя нет. Хотите его создать (y/n)?" new_action_
	if [ $new_action_ ==  "y" ]; then
	    sudo adduser $user_
	    read -p "Пользователь создан. Дать ему рут-права (y/n)?" root_
	    if [ $root_ == "y" ]; then
	    	sudo adduser $user_ sudo
	    	echo "Рут-права выданы"
	    elif [ $root_ == "n" ]; then
	    	exit
	    fi
	elif [ $new_action_ == "n" ]; then
		exit
	fi
fi
