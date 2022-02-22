#!/bin/bash
apt -y update
apt -y install nginx

cat <<EOF > /var/www/html/index.html
<html>
<h2> <font color="blue"> This page is created by Terraform + AWS EC2</font> </h2><br>
Owner ${name}  <br>

%{for x in names ~}
<h3>${name} like ${x}</h3><br>
%{endfor ~}

</html>

EOF