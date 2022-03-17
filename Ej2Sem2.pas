program actividad2;
type
 vec = array[1..20]of integer;
 
//PROCEDIMIENTOS
 procedure cargar(var v:vec);
 var
  n,i:integer;
 begin
  for i:= 1 to 20 do begin
   n:= random(200);
   v[i]:= n;
  end;
 end; 
 
 procedure imprimir(v:vec);
 var
  i:integer;
 begin
  for i:= 1 to 20 do
   write(v[i],' ');
 end; 

 procedure maximo(v:vec;i:integer;var max:integer);
 begin
  if(i <= 20)then begin
   if(v[i] > max)then
    max:= v[i];
   maximo(v,i+1,max);
  end;
 end; 
 
 procedure suma(v:vec;i:integer;var total:integer);
 begin
  if(i <= 20)then begin
   total:= total + v[i];
   suma(v,i+1,total);
  end;
 end; 
 
 procedure OrdenadoPorInsercion(var v:vec);
 var
  i,j:integer;
  aux:integer ;
 begin
  for i:=2 to 20 do begin
   aux:= v[i];
   j:=i-1;
   while(j > 0)and(v[j] > aux)do begin 
    v[j+1]:=v[j];
    j:= j - 1;
   end;
   v[j+1]:=aux;
  end;
 end;
 
 procedure BusquedaDicotomica(v:vec;ini,fin,num:integer;var pos:integer); 
 var
  medio:integer;
 begin
  if(ini > fin)then  
   pos:= -1 
  else begin
   medio:= (ini + fin) div 2;
   if(v[medio] = num)then
    pos:= medio 
   else begin
    if(v[medio] < num)then 
     BusquedaDicotomica(v,ini,medio-1,v[medio],pos) 
    else if(v[medio] > num) then
     BusquedaDicotomica(v,medio+1,fin,v[medio],pos); 
   end; 
  end;
 end; 

//PROGRAMA PRINCIPAL
var
 v:vec;
 max,total,i,n,ini,fin,pos:integer;
BEGIN
 i:= 0;
 total:= 0;
 max:= -1;
 Randomize;	
 writeln('A continuacion se va a generar el vector de numeros');
 cargar(v);
 writeln('Vector de mumeros');
 imprimir(v);
 writeln;
 write('Calculo de numero maximo con recursion');
 maximo(v,i,max);
 writeln('El numero maximo es: ',max);
 writeln('Suma de numeros');
 suma(v,i,total);	
 writeln('La suma de los elementos del vector es: ',total);
 OrdenadoPorInsercion(v);
 ini:= 1;
 fin:= 20;
 writeln('Ingrese numero a buscar mediante busqueda dicotomica');
 read(n);
 BusquedaDicotomica(v,ini,fin,n,pos);
 if(pos = n)then
  writeln('El numero se encuentra en la posicion: ',pos) 
 else
  writeln('No existe el numero');
END.

