program Act3Semana3;
const
 cant = 7;
type
 entrada = record
  codo:integer;
  monto:integer;
  dia:integer; //1...7
  asiento:integer;
 end;
 lista = ^nodo;
 nodo = record
  dato:entrada;
  sig:lista;
 end;
 vec = array[1..cant]of lista;

procedure inicializar(var v:vec);
var
 i:integer;
begin
 for i:=1 to 7 do
  v[i]:=nil;
end;

Procedure AgregarOrdenado(var l: lista; e:entrada);
var ant, nue, act: lista;
begin
 new (nue);
 nue^.dato := e;
 act := l;
 while (act <> nil) and (act^.dato.codo > e.codo) do begin
  ant := act;
  act := act^.sig;
 end;
 if (act = l)  then l := nue   
                 else ant^.sig := nue; 
 nue^.sig := act ;
end; 

procedure leer(var e:entrada);
begin
 writeln('Ingrese codigo de obra');
 readln(e.codo);
 if(e.codo <> 0)then begin
  writeln('Ingrese dia donde la obra se realiza(1..7)');
  readln(e.dia);
  writeln('Ingrese asiento de la obra');
  readln(e.asiento);
  writeln('Ingrese monto de la entrada');
  readln(e.monto);
 end;
end;

procedure generar(var v:vec);
var
 e:entrada;
begin
 leer(e);
 while(e.codo <> 0)do begin
  AgregarOrdenado(v[e.dia],e);
  leer(e);
 end;
end;

procedure determinarMinimo(var v:vec;var min:entrada);  
Var
 pos,i:integer;
Begin
 min.codo:= 9999;
 pos:=0;
 for i:=1 to 7 do begin
  if(v[i] <> nil)then begin
   if(v[i]^.dato.codo < min.codo)then begin
    min.codo:= v[i]^.dato.codo;
    pos:= i;
   end;
  end;
 end;
 if(min.codo <> 9999)then begin
  min:= v[pos]^.dato;
  v[pos]:=v[pos]^.sig;
 end;
end;

procedure copiar(var aux:entrada; total:integer; actual:integer);
begin
 aux.codo:= actual;
 aux.asiento:= total;
end;

procedure Merge(v:vec;var ln:lista;var min:entrada); 
var
 total,actual:integer;
 aux:entrada;
begin
 determinarMinimo(v,min);
 while(min.codo <> 9999)do begin
  actual:= min.codo;
  total:= 0;
  while((actual = min.codo)and(min.codo <> 9999))do begin
   total:= total + 1;
   determinarMinimo(v,min);
  end;
  copiar(aux,total,actual);
  AgregarOrdenado(ln,aux);
 end;
end;

procedure imprimir(ln:lista);
begin
 while(ln <> nil)do begin
  writeln('Codigo de obra: ',ln^.dato.codo);
  writeln('Cantidad de asientos vendidos: ',ln^.dato.asiento);
  writeln('--------------------------------------');
  ln:= ln^.sig;
 end;
end;

var
 v:vec;
 ln:lista;
 min:entrada;
BEGIN
 ln:= nil;
 inicializar(v);
 writeln('Bienvenido al programa,ingrese compra de entradas de obras.Con codigo de obra 0 deja de ingresar datos');
 generar(v);
 writeln('A continuacion se generara una lista con las obras y su entradas vendidas');
 Merge(v,ln,min);	
 writeln('Lista de obras y su cantidad de entradas vendidas - RESULTADOS');
 imprimir(ln);	
END.

