#Crear OUs del primer nivel
samba-tool ou create "OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"
samba-tool ou create "OU=ServiceAccounts,DC=nf-tipy-uy,DC=duckdns,DC=org"
samba-tool ou create "OU=Equipos,DC=nf-tipy-uy,DC=duckdns,DC=org"
samba-tool ou create "OU=Grupos,DC=nf-tipy-uy,DC=duckdns,DC=org"

#Crear OUs del segundo nivel

#-.-.-.-Usuarios-.-.-.-.-
samba-tool ou create "OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"
samba-tool ou create "OU=Proveedores,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"
samba-tool ou create "OU=Ex-Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

#-.-.-.-Equipos-.-.-.-.-
samba-tool ou create "OU=Desktops,OU=Equipos,DC=nf-tipy-uy,DC=duckdns,DC=org"
samba-tool ou create "OU=Servers,OU=Equipos,DC=nf-tipy-uy,DC=duckdns,DC=org"

#-.-.-.-Grupos-.-.-.-.-
samba-tool ou create "OU=Grupos de seguridad,OU=Grupos,DC=nf-tipy-uy,DC=duckdns,DC=org"
samba-tool ou create "OU=Grupos Distribuidos,OU=Grupos,DC=nf-tipy-uy,DC=duckdns,DC=org"


#Crear OUs del tercer nivel
samba-tool ou create "OU=Sistemas,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"
samba-tool ou create "OU=RRHH,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

#Crear OUs del cuarto nivel
samba-tool ou create "OU=Sysadmins,OU=Sistemas,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"
samba-tool ou create "OU=Devs,OU=Sistemas,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

#-.-.-.-.-.-.-.-.-.Crear usuarios.-.-.-.-.-.-.-.-.-.-.-

# Sysadmins
samba-tool user create "carlos.martinez" "G72556FWuYVwQHnC" --given-name="Carlos" --surname="Martínez" --uid-number=10000 --gid-number=10000 
samba-tool user move "carlos.martinez" "OU=Sysadmins,OU=Sistemas,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

samba-tool user create "laura.lopez" "G72556FWuYVwQHnC" --given-name="Laura" --surname="López"  --uid-number=10004 --gid-number=10004 
samba-tool user move "laura.lopez" "OU=Sysadmins,OU=Sistemas,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

samba-tool user create "juan.hernandez" "G72556FWuYVwQHnC" --given-name="Juan" --surname="Hernández"  --uid-number=10003 --gid-number=10003 
samba-tool user move "juan.hernandez" "OU=Sysadmins,OU=Sistemas,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

samba-tool user create "jesus.guibert" "G72556FWuYVwQHnC" --given-name="Jesus" --surname="Guibert"  --uid-number=10002 --gid-number=10002 
samba-tool user move "jesus.guibert" "OU=Sysadmins,OU=Sistemas,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

samba-tool user create "nicolas.ferreira" "G72556FWuYVwQHnC" --given-name="Nicolas" --surname="Ferreira"  --uid-number=10001 --gid-number=10001 
samba-tool user move "nicolas.ferreira" "OU=Sysadmins,OU=Sistemas,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

# Devs
samba-tool user create "david.gomez" "G72556FWuYVwQHnC" --given-name="David" --surname="Gómez"  --uid-number=10005 --gid-number=10005 
samba-tool user move "david.gomez" "OU=Devs,OU=Sistemas,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

samba-tool user create "sandra.ramirez" "G72556FWuYVwQHnC" --given-name="Sandra" --surname="Ramírez"  --uid-number=10006 --gid-number=10006 
samba-tool user move "sandra.ramirez" "OU=Devs,OU=Sistemas,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

samba-tool user create "alejandro.torres" "G72556FWuYVwQHnC" --given-name="Alejandro" --surname="Torres"  --uid-number=10007 --gid-number=10007 
samba-tool user move "alejandro.torres" "OU=Devs,OU=Sistemas,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

samba-tool user create "patricia.morales" "G72556FWuYVwQHnC" --given-name="Patricia" --surname="Morales"  --uid-number=10008 --gid-number=10008 
samba-tool user move "patricia.morales" "OU=Devs,OU=Sistemas,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

# RRHH
samba-tool user create "beatriz.navarro" "G72556FWuYVwQHnC" --given-name="Beatriz" --surname="Navarro"  --uid-number=10009 --gid-number=10009 
samba-tool user move "beatriz.navarro" "OU=RRHH,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

samba-tool user create "raul.gil" "G72556FWuYVwQHnC" --given-name="Raúl" --surname="Gil"  --uid-number=10010 --gid-number=10010 
samba-tool user move "raul.gil" "OU=RRHH,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

samba-tool user create "maria.soto" "G72556FWuYVwQHnC" --given-name="María" --surname="Soto"  --uid-number=10011 --gid-number=10011 
samba-tool user move "maria.soto" "OU=RRHH,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

samba-tool user create "antonio.castro" "G72556FWuYVwQHnC" --given-name="Antonio" --surname="Castro"  --uid-number=10012 --gid-number=10012
samba-tool user move "antonio.castro" "OU=RRHH,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

samba-tool user create "isabel.ramos" "G72556FWuYVwQHnC" --given-name="Isabel" --surname="Ramos"  --uid-number=10013 --gid-number=10013 
samba-tool user move "isabel.ramos" "OU=RRHH,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"

samba-tool user create "jorge.vega" "G72556FWuYVwQHnC" --given-name="Jorge" --surname="Vega"  --uid-number=10014 --gid-number=10014 
samba-tool user move "jorge.vega" "OU=RRHH,OU=Empleados,OU=Usuarios,DC=nf-tipy-uy,DC=duckdns,DC=org"


#-.-.-.-.-.-.-.-.-.Crear grupos y asignar usuarios.-.-.-.-.-.-.-.-.-.-.-

samba-tool group add "Sysadmins"
samba-tool group add "Devs"
samba-tool group add "RRHH"
samba-tool group add "proxmox-admins"

samba-tool group addmembers "Sysadmins" "carlos.martinez"
samba-tool group addmembers "Sysadmins" "laura.lopez"
samba-tool group addmembers "Sysadmins" "juan.hernandez"
samba-tool group addmembers "Sysadmins" "jesus.guibert"
samba-tool group addmembers "Sysadmins" "nicolas.ferreira"

samba-tool group addmembers "Devs" "david.gomez"
samba-tool group addmembers "Devs" "sandra.ramirez"
samba-tool group addmembers "Devs" "alejandro.torres"
samba-tool group addmembers "Devs" "patricia.morales"

samba-tool group addmembers "RRHH" "beatriz.navarro"
samba-tool group addmembers "RRHH" "raul.gil"
samba-tool group addmembers "RRHH" "maria.soto"
samba-tool group addmembers "RRHH" "antonio.castro"
samba-tool group addmembers "RRHH" "isabel.ramos"
samba-tool group addmembers "RRHH" "jorge.vega"