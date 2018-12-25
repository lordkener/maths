* Los gestores de recursos de un centro de procesamiento de datos
* son componentes de software centralizados que gestionan
* la ejecuci�n de un gran n�mero de servicios.
* La colocaci�n de m�ltiples servicios en una m�quina
* podr�a degradar el rendimiento y,
* por lo tanto, es cr�tico para el gestor de recursos
* utilizar la informaci�n sobre los servicios y las m�quinas
* para asignar efectivamente los recursos de la m�quina.
* El problema consiste en determinar la mejor asignaci�n
* de los servicios en los servidores para que,
* por un lado, se cumplan las necesidades en los recursos de los servicios,
* y, por otro lado, se respeten los acuerdos de nivel de servicio (ANS).
* Adem�s, el centro de procesamiento de datos quiere optimizar el n�mero de ordenadores involucrados.
* Cada servicio tiene las necesidades de recursos como CPU y RAM requeridos,
* y cada servidor tiene ciertos recursos de cada tipo para ofrecer.
* En las tablas de la parte inferior se indican las caracter�sticas
* tanto de los servidores, como de los servicios.
* El centro de procesamiento de datos dispone de tres tipos de servidores,
* v�ase Tabla 1.

* Tipo        N�mero de servidores        CPU (GIPS) por servidor        RAM(GB)
* por servidor
* 1        1        6        12
* 2        2        4        10
* 3        2        3        8
* Tabla 1. Tipos de servidores, su n�mero y sus caracter�sticas.

* Por otro lado, hay tres tipos de servicios, cada tipo con su demanda de recursos, v�ase Tabla 2.

* Tipo        N�mero de servicios        Uso de CPU (GIPS) por servicio        Uso de RAM (GB) por servicio
* 1        3        1,7        2
* 2        3        1,5        3
* 3        3        1        4
* Tabla 2. Tipos de servicios, n�mero de servicios de cada tipo, y sus requisitos.

* Se supone que cada servicio debe asignarse a un �nico servidor.
* Los acuerdos de nivel de servicio (SLA) implican que
* la carga de los ordenadores debe estar equilibrada.
* Este requisito se plasma en el siguiente objetivo:
* se requiere minimizar la m�xima ocupaci�n relativa de cada recurso
* en cada m�quina. Por la ocupaci�n relativa de un recurso en una maquina
* se entiende la ratio de la ocupaci�n del recurso en la m�quina
* entre la disponibilidad m�xima del mismo.
* El segundo objetivo del centro de procesamiento es
* minimizar el n�mero de ordenadores que se ocupan por indicados servicios.
* Aproximad la frontera de Pareto.

Sets
         num /1*1000/
         i tipos de servidores /ServidorTipo1, ServidorTipo2, ServidorTipo3/
         j tipos de servicios /ServicioTipo1, ServicioTipo2, ServicioTipo3/
         p(i, num) servidores
         q(j, num) servicios
         r tipos de recursos /CPU, RAM/
;

Parameters
         n(i) numero de servidores /ServidorTipo1 1, ServidorTipo2 2, ServidorTipo3 2/
         m(j) numero de servicios /ServicioTipo1 3, ServicioTipo2 3, ServicioTipo3 3/
         pr(i, num, r)  recurso r proporcionada por servidor p
         qr(j, num, r)  la demanda de recurso r por el servicio q
;

Table L(i, r) recurso r proporcionada por servidor de tipo i
                         CPU   RAM
         ServidorTipo1   6       12
         ServidorTipo2   4       10
         ServidorTipo3   3       8
;

Table D(j, r) la demanda de recurso r por el servicio de tipo j
                         CPU     RAM
         ServicioTipo1   1.7     2
         ServicioTipo2   1.5     3
         ServicioTipo3   1       4
;

loop(i,
         p(i, num)$(ord(num) <= n(i)) = yes;
         pr(p(i, num), r) = L(i, r);
);

loop(j,
         q(j, num)$(ord(num) <= m(j)) = yes;
         qr(q(j, num), r) = D(j, r);
);

Free Variables
         nServidores n�mero de ordenadores involucrados
         maxRelOcc la m�xima ocupaci�n relativa de cada recurso en cada m�quina
;

Binary Variables
         e(i, num) servidor encendido 1 si 0 no
         A(i, num, j, num) asignamos servicio j al servidor i
;

Equations
         numeroDeServidores numero de servidores involucrados
         ANS(i, num, r) la capacidad de servidor se cumplan las necesidades en los recursos de los servicios
         servicio(j, num) cada servicio debe asignarse a un �nico servidor
         SLA(i, num, r) la m�xima ocupaci�n relativa
;

* coding area
         ANS(p, r).. sum(q, A(p, q)*qr(q, r)) =l= e(p) * pr(p, r);
         servicio(q).. sum(p, A(p, q)) =e= 1;
         numeroDeServidores.. nServidores =e= sum(p, e(p));
         SLA(p, r).. maxRelOcc =g= sum(q, A(p, q) * qr(q, r))/pr(p, r);

display p;
display q;
display pr;
display qr;

Model practica3 /ALL/;
* The GAMS default for OPTCR is 0.1
practica3.OPTCR = 0;

file output /pareto.txt/;
put output;
put 'pareto points:'/;
put 'num de servidores   maximo nivel de servicio'/;

scalar servidoresTotal, counter;
servidoresTotal = sum(i, n(i));
FOR (counter = 0 TO servidoresTotal,
         nServidores.fx = counter;
         solve practica3 using MIP minimizing maxRelOcc;
         put counter;
         If(practica3.Modelstat > %ModelStat.Optimal%,
                 put practica3.Tmodstat;
         else
                 put maxRelOcc.l;
         );
         put /;
);
