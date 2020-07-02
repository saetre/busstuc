echo "Set file rights..."
sudo chmod 775 /lhome/busstuc/busstuc/compile/extract_cut.sh

chgrp busstuc db/tables/*
chmod g+wx    db/tables/*
chgrp busstuc db/tables/*/*
chmod g+w    db/tables/*
