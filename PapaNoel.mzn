% Número de juguetes mayor que 0
int: m;
constraint assert(m > 0, "No hay suficientes juguetes");

% Número de niños mayor que 0
int: n; 
constraint assert(n > 0, "No hay suficientes niños");

% Mínimo de satisfacción
int: s;
constraint assert(s > 0, "No hay satisfacción suficiente");

%Disponibilidad de cada juguete
array [1..m] of int: disp;
constraint assert(forall (i in 1..m) ( disp[i] >= 0), "La disponibilidad de todos los juguetes tiene que ser mayor o igual que 0");

%Tipo de cada juguete
enum Tipo;

%Array del tipo de cada juguete
array[1..m] of Tipo: jTipo;

%Satisfacción de cada niño con cada juguete (puede ser negativo)
array[1..m,1..n] of int: jSat;

%Asignación de juguetes a cada niño(jug1,jug2)
array[1..n,1..2] of int: asig;

%No hay más de dos juguetes de un mismo tipo
constraint forall (i in 1..n) ( jTipo[asig[i,1]] != jTipo[asig[i,2]]);

%Los niños deben de tener un minimo de satisfaccion
constraint forall (i in 1..n) (sum(j in 1..2) ( jSat[i,asig[i,j]])  >= s);

%No se entregan más juguetes de los disponibles de cada tipo
constraint forall (i in 1..m) ( sum(j in 1..n, k in 1..2) (bool2int(asig[j,k] = i) ) <= (disp[i]));

%primer juguete menor valor, segundo juguete mayor valor
constraint forall (i in 1..n) ( asig[i,1] < asig[i,2]);

% Obtener solución
solve satisfy;

output [ "\(asig[i,1]-1) \(asig[i,2]-1) " | i in 1..n ]