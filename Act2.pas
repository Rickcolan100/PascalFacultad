program VectorNumAleatorio;
const
 cant = 20;
type
 vec = array[1..cant]of integer;

procedure CargarVector(var v:vec;var diml:integer);
var
 num:integer;
begin
 num:= random(100);
 while(num <> 0)and(diml < 20)do begin
  diml:= diml + 1;
  v[diml]:= num;
  num:= random(100);
 end;
end;
  
procedure ImprimirVector(v:vec; diml:integer);
var
 i:integer;
begin
 for i:= 1 to diml do
  write(v[i],'|');
 writeln;    
end; 

function BuscarElementoVD(v:vec;diml:integer;num:integer):integer;
var
 i:integer;
begin
 i:= 1;
 while(i <= diml)and(num <> v[i])do 
  i:= i + 1;
 if(i > diml)then
  i:= 0;
 BuscarElementoVD:= i;  
end;

procedure OrdenadoPorInsercion(var v:vec;diml:integer); //ordena todo el contenido NO MODIFICAR
var
 i,j:integer;
 aux:integer;
begin
 for i:=2 to diml do begin
  aux:= v[i];
  j:=i-1;
  while(j > 0)and(v[j] > aux)do begin
   v[j+1]:=v[j];
   j:= j - 1;
  end;
  v[j+1]:=aux;
 end;
end; 

function BuscarElementoVO(v:vec;diml:integer;dato:integer):integer; 
var
 medio,ini,fin,pos:integer;
begin
 ini:= 1;
 fin:= diml;
 medio:=(ini + fin) div 2;
 while(ini <= fin)and(v[medio] <> dato)do begin
  if(v[medio] < dato)then
   ini:= medio + 1
  else
   fin:= medio - 1;
  medio:=(ini + fin) div 2;
 end;
 if(ini < fin)then
  pos:= medio
 else   
  pos:= 0;
 BuscarElementoVO:= pos;
end;
        
var
 v:vec;
 diml,num,dato,pos:integer; 
BEGIN
 Randomize;
 diml:= 0;
 writeln('Se cargara el vector con numeros aleatorios');
 CargarVector(v,diml);
 writeln('Se imprira el vector con numeros aleatorios - DESORDENADO');
 ImprimirVector(v,diml);
 writeln('Ingrese numero a buscar en el vector desordenado');
 readln(num);
 pos:= BuscarElementoVD(v,diml,num);
 if(pos <> 0)then
  writeln('El dato esta en la posicion:',pos)
 else
  writeln(0);
 writeln('Se ordenara el vector');
 OrdenadoPorInsercion(v,diml);
 writeln('Se imprira el vector con numeros aleatorios - ORDENADO');
 ImprimirVector(v,diml);
 writeln('Ingrese numero a buscar en el vector ordenado:');
 readln(dato);
 pos:= BuscarElementoVO(v,diml,dato);
 if(pos <> 0)then
  writeln('El dato esta en la posicion:',pos)
 else
  writeln(0);
 readln; 
END.

