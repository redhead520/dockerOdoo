echo 'start odoo server'
/etc/init.d/postgresql restart
python /odoo/odoo-bin -c /opt/odoo.conf &