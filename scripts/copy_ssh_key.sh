tty -echo;
read -s -p "Input password:" A;
stty echo;
echo;
ip_address_list=ip_address_list.txt

for HOST in `cat $ip_address_list`
do
	if [[ $HOST == \#* ]] || [ ${#HOST} -eq 0 ]
	then
		: # ignore line
	else
echo "Connecting to $HOST"

expect -c "set timeout -1;\
spawn ssh -o StrictHostKeyChecking=no $HOST \"mkdir -p ~/.ssh\";\
match_max 100000;\
expect *Password:*;\
send $A;\
send \n;\
interact;"

expect -c "set timeout -1;\
spawn scp -o StrictHostKeyChecking=no $HOME/.ssh/id_rsa.pub $HOST:~/.ssh/temp.pub;\
match_max 100000;\
expect *Password:*;\
send $A;\
send \n;\
interact;"

expect -c "set timeout -1;\
spawn ssh -o StrictHostKeyChecking=no $HOST \"cat ~/.ssh/temp.pub >> ~/.ssh/authorized_keys\";\
match_max 100000;\
expect *Password:*;\
send $A;\
send \n;\
interact;"

echo "Finished job on $HOST"
	fi
done