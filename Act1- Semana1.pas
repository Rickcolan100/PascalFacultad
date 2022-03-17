program Ej1Semana1Imp;
const
 dimf = 300;
type
 oficina = record
  cod:integer;
  dni:integer;
  valor:integer;
 end;
 vec = array[1..dimf]of oficina;
 
procedure leer(var o:oficina);
begin
 writeln('Ingrese codigo del oficina: ');
 readln(o.cod);
 if(o.cod <> -1)then begin
  writeln('Ingrese dni del propietario');
  readln(o.dni);
  writeln('Ingrese valor de la expensa');
  readln(o.valor);
 end;
end; 
 
procedure cargar(var v:vec;var diml:integer);  //1
var
 o:oficina;
begin
 leer(o);
 while(o.cod <> -1)and(diml < 300)do begin
  diml:= diml + 1;
  v[diml]:= o;
  leer(o);
 end;
end;

procedure imprimir(v:vec ; diml:integer);
var
 i:integer;
begin
 for i:= 1 to diml do begin
  writeln('Codigo de oficina: ',v[i].cod);
  writeln('DNI del propietario: ',v[i].dni);
  writeln('Valor de la expensa: ',v[i].valor);
 end;
end;

procedure OrdenadoInsercion(var v:vec; diml:integer); 
var
 i,j:integer;
 aux:oficina;
begin
 for i:=2 to diml do begin
  aux:= v[i];
  j:=i-1;
  while(j > 0)and(v[j].cod > aux.cod)do begin
   v[j+1]:=v[j];
   j:= j - 1;
  end;
  v[j+1]:=aux;
 end;
end;

var
 v:vec;
 diml:integer;
BEGIN
 diml:= 0;
 writeln('Bienvenido al programa,ingrese a lo sumo 300 propietarios o deje de ingresarlos con -1');
 cargar(v,diml);
 writeln('Lista de propietarios');
 imprimir(v,diml);
 writeln('Lista de propietarios ordenadana');
 OrdenadoInsercion(v,diml);
 imprimir(v,diml);	
END.

