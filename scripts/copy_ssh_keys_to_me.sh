tty -echo;
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

#first generate keys: ssh-keygen -t rsa

scp $HOST:/Users/faile/.ssh/id_rsa.pub ~/.ssh/temp.pub
cat ~/.ssh/temp.pub >> ~/.ssh/authorized_keys
rm ~/.ssh/temp.pub

echo "Finished job on $HOST"
	fi
done