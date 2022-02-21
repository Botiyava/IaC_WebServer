#!/bin/bash
apt -y update
apt -y install nginx

cat <<EOF > /var/www/html/index.html
<html>
<h2> This page is created by Terraform + AWS EC2 <font color="blue"></h2><br>
Owner ${name} ${surname} <br>

%{for x in names ~}
${name} like ${x}<br>
%{endfor ~}
</html>

EOF