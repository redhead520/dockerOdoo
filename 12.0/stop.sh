echo 'stop odoo'
ps -ef|grep odoo-bin|grep -v grep|awk '{print $2}'|xargs kill -9
echo 'stop odoo complete !'