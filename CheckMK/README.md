# NOTAS
Crea 4 sites del sistema CheckMK 1.6.0.p10 simulando un entorno de produccion de monitorizacion.
Vagrantfile + instalacion.sh crea 4 Sites de CheckMK (diferentes instancias).

Al final de la ejecución de "vagrant up" aparecerá un menú indicando la IP bridge de tu red y contexto web:

"============================================================="
"========================= INFORMACION ======================="
"============================================================="
"Versión CheckMK:                                    1.6.0.p10"
"Usuario de acceso web:                               cmkadmin"
"Para acceder a PRO: http://$eth1ip/PRO . Contraseña: PRO"
"Para acceder a PRE: http://$eth1ip/PRE . Contraseña: PRE"
"Para acceder a DES: http://$eth1ip/DES . Contraseña: DES"
"Para acceder a TST: http://$eth1ip/TST . Contraseña: TST"
"Más información de la instalación en:          /home/vagrant/"
"============================================================="