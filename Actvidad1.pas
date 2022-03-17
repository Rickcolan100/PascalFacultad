program mergecomun;
const
 cant = 4;
type
 venta = record
  codv:integer;
  codp:integer;
  cantv:integer;
 end;
 lista = ^nodo;
 nodo = record
  dato:venta;
  sig:lista;
 end;
 vec = array[1..cant]of lista;

//PROCEDIMIENTOS

procedure inicializar(var v:vec);
var
 i:integer;
begin
 for i:=1 to 4 do
  v[i]:=nil;
end;

Procedure AgregarOrdenado(var l: lista; ve:venta);
var ant, nue, act: lista;
begin
 new (nue);
 nue^.dato := ve;
 act := l;
 while (act <> nil) and (act^.dato.codp < ve.codp) do begin
  ant := act;
  act := act^.sig;
 end;
 if (act = l)  then l := nue   
                 else ant^.sig := nue; 
 nue^.sig := act ;
end; 

procedure leer(var ve:venta);
begin
 ve.codv:= random(10);
 if(ve.codv <> 0)then begin
  ve.codp:= random(15);
  ve.cantv:= random(100);
 end;
end;

procedure CrearLista(var l:lista);
var
 ve:venta;
begin
  leer(ve);
  while(ve.codp <> 0)do begin
   AgregarOrdenado(l,ve);
   leer(ve);
  end;
end; 

procedure CrearVectorDeListas(var v:vec);
var
 i:integer;
begin
 for i:= 1 to 4 do begin
  CrearLista(v[i])
 end;
end;

procedure ImprimirVectorDeListas(v:vec);
var
 i:integer;
begin
 for i:= 1 to 4 do begin
  writeln('Ventas en sucursal: ',i);
  writeln('----------------------------------------');
  while(v[i] <> nil)do begin
   writeln('Codigo de producto: ',v[i]^.dato.codp);
   writeln('Codigo de venta: ',v[i]^.dato.codv);
   writeln('Cantidad de ventas: ',v[i]^.dato.cantv);
   writeln('***************************************');
   v[i]:= v[i]^.sig;
  end;
  writeln('----------------------------------------');
 end;
end;

procedure determinarMinimo(var v:vec;var min:venta);  
Var
 pos,i:integer;
Begin
 min.codp:= 9999;
 pos:=0;
 for i:=1 to 4 do begin
  if(v[i] <> nil)then begin
   if(v[i]^.dato.codp < min.codp)then begin
    min:= v[i]^.dato;
    pos:= i;
   end;
  end;
 end;
 if(min.codp <> 9999)then begin
  v[pos]:=v[pos]^.sig;
 end;
end;

procedure AgregarAlFinal(var pri, ult: lista; min:venta); 
var  nue : lista;
begin 
 new (nue);
 nue^.dato:= min;
 nue^.sig := NIL;
 if (pri <> nil) then 
      ult^.sig := nue
 else 
      pri := nue;
 ult := nue;
end;

procedure Merge(v:vec;var ln:lista;min:venta);
var
 ult:lista; 
begin
 ln:= nil;
 ult:= ln;
 determinarMinimo(v,min);
 while(min.codp <> 9999)do begin
  AgregarAlFinal(ln,ult,min);
  determinarMinimo(v,min);
 end;
end;

procedure ImprimirListaNueva(var ln:lista);
begin
 if(ln <> nil)then begin
  writeln('*****************************************');
  writeln('Codigo de producto: ',ln^.dato.codv);
  writeln('Cantidad vendida: ',ln^.dato.cantv);
  ImprimirListaNueva(ln^.sig);
 end;
end;

//PROGRAMA PRINCIPAL
var
 v:vec;
 ln:lista;
 min:venta;
BEGIN
 Randomize;
 inicializar(v);
 writeln('A continuacion se va a generar las sucursales');
 CrearVectorDeListas(v);
 writeln('Lista de sucursales');
 ImprimirVectorDeListas(v);
 writeln('Unificando listas con merge');
 Merge(v,ln,min);	
 writeln('Lista nueva con todas las sucursales');
 ImprimirListaNueva(ln);	
END.

