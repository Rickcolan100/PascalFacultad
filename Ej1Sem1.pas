program ejercicio1;
type
 oficina = record
  id:integer;
  dni:integer;
  vexpensas:integer;
 end;
 vec = array[1..300]of oficina;
 
//PROCEDIMIENTOS
procedure generardatos(var o:oficina);
begin
 o.id:= random(300);
 if(o.dni <> 0)then begin
  o.dni:= random(300);
  o.vexpensas:= random(1000);
 end; 
end;

procedure generar(var v:vec;var diml:integer);
var
 o:oficina;
begin
 generardatos(o);
 while(o.dni <> 0)and(diml < 300)do begin
  diml:= diml + 1;
  v[diml]:= o;
  generardatos(o);
 end;
end; 
 
procedure OrdenadoPorInsercion(var v:vec;diml:integer); 
var
 i,j:integer;
 aux:oficina;
begin
 for i:=2 to diml do begin
  aux:= v[i];
  j:=i-1;
  while(j > 0)and(v[j].id > aux.id)do begin
   v[j+1]:=v[j];
   j:= j - 1;
  end;
  v[j+1]:=aux;
 end;
end; 

procedure imprimir(v:vec; diml:integer);
var
 i:integer;
begin
 for i:= 1 to diml do begin
  writeln('ID: ',v[i].id);
  writeln('DNI: ',v[i].dni);
  writeln('Valor de las expensas: ',v[i].vexpensas);
  writeln('-----------------------------------------------');
 end;    
end; 
 
//PROGRAMA PRINCIPAL 
var
 v:vec;
 diml:integer;
BEGIN
 Randomize;
 diml:= 0;
 writeln('A continuacion se generara oficinas');
 generar(v,diml);
 writeln('Lista de oficinas generadas');
 imprimir(v,diml);
 writeln('Se ordenaran las oficinas por codigo de identificacion');
 OrdenadoPorInsercion(v,diml);
 writeln('Lista de oficinas generadas ordenadas');
 imprimir(v,diml);
 readln;		
END.

