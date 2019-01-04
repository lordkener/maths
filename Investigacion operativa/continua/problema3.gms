* Una refiner�a utiliza dos tipos de petr�leo, A y B,
* que compra a un precio de 300 y 200 euros por tonelada, respectivamente.
* Por cada tonelada de petr�leo de tipo A que refina
* obtiene 0.35 toneladas de gasolina y 0.2 de fuel-oil.
* Por cada tonelada de petr�leo de tipo B que refina,
* obtiene 0.2 toneladas de gasolina y 0.45 de fuel-oil.
* Para cubrir sus necesidades, necesita al menos 15 toneladas de gasolina
* y 15 toneladas de fuel-oil.
* Por cuestiones de capacidad, no puede comprar m�s de 120 toneladas de petr�leo.
* Calcular la cantidad de petr�leo de cada tipo debe comprar la refiner�a
* para cubrir sus necesidades a coste m�nimo coste? Obtener dicho m�nimo.

Sets
         i petroleo  /A, B/
         j producto /gasolina, fuel_oil/
;

Parameters
         precio(i) precio de petroleo de tipo i
                 / A             300
                   B             200/

         demanda(j) demanda de cada producto
                 / gasolina      15
                   fuel_oil      15/
;

Table
         refina(i,j) recursos necesarios
                         gasolina     fuel_oil
         A               0.35         0.2
         B               0.2          0.45
;

Free Variables
         z   coste para cubrir sus necesidades
;

Positive Variables
         x(i) toneladas de petroleo tipo i comprado
;

Equations
         obj
         r_demanda(j) satisfacer la demanda
;
         obj.. z =e= sum(i, x(i) * precio(i));
         r_demanda(j).. sum(i, x(i) * refina(i,j)) =g= demanda(j);

* coding area
Model  ex1 /All/;
Solve ex1 using LP minimizing z;
