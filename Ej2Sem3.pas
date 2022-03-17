program merge2;
const
 cant = 7;
type
 //REGISTROS DE CARGA DE DATOS
 entrada = record
  codo:integer;
  asiento:integer;
  mont:integer;
 end;
 lista = ^nodo;
 nodo = record
  dato:entrada;
  sig:lista;
 end;
 vec = array[1..cant]of lista;
 //REGISTROS PARA REALIZAR EL MERGE ACUMULADOR
 obratotal = record
  cante:integer;
  codobra:integer;
 end;
 listan = ^nodoa;
 nodoa = record
  dato:obratotal;
  sig:listan;
 end;
 
//PROCEDIMIENTOS
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
 while (act <> nil) and (act^.dato.codo < e.codo) do begin
  ant := act;
  act := act^.sig;
 end;
 if (act = l)  then l := nue   
                 else ant^.sig := nue; 
 nue^.sig := act ;
end; 

procedure leer(var e:entrada;var dia:integer);
begin
 dia:= random(7); //LA POSICION DEL VECTOR VA COMO REGISTRO APARTE
 if(dia <> 0)then begin
  e.codo:= random(5);
  e.asiento:= random(40);
  e.mont:= random(100);
 end;
end;

procedure generar(var v:vec);
var
 e:entrada;
 dia:integer;
begin
  leer(e,dia);
  while(dia <> 0)do begin
   AgregarOrdenado(v[dia],e);
   leer(e,dia);
  end;
end; 

procedure ImprimirVectorDeListas(v:vec);
var
 i:integer;
begin
 for i:= 1 to 7 do begin
  writeln('DIA DE LA SEMANA: ',i);
  writeln('----------------------------------------');
  while(v[i] <> nil)do begin
   writeln('Codigo de obra: ',v[i]^.dato.codo);
   writeln('Asiento reservado: ',v[i]^.dato.asiento);
   writeln('Monto de la entrada: ',v[i]^.dato.mont);
   writeln('***************************************');
   v[i]:= v[i]^.sig;
  end;
  writeln('----------------------------------------');
 end;
end;

procedure AgregarAlFinal(var pri, ult: listan; actual:obratotal); 
var  nue : listan;
begin 
 new (nue);
 nue^.dato:= actual;
 nue^.sig := NIL;
 if (pri <> nil) then 
      ult^.sig := nue
 else 
      pri := nue;
 ult := nue;
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
    min:= v[i]^.dato;
    pos:= i;
   end;
  end;
 end;
 if(min.codo <> 9999)then begin
  v[pos]:=v[pos]^.sig;
 end;
end;

Procedure MergeAcumulador(v:vec; var ln:listan);
var
 min:entrada;
 actual:obratotal;
 ult:listan;
begin
 ult:= nil;
 determinarMinimo(v,min);
 while (min.codo <> 9999) do begin
  actual.codobra:= min.codo;
  actual.cante:=0;
  while (actual.codobra = min.codo) do begin
   actual.cante:= actual.cante + 1;
   determinarMinimo(v,min);
  end;
  AgregarAlFinal(ln,ult,actual);  //SI VIENE ORDERNADO PREVIAMENTE AGREGO UN AGREGAR AL FINAL SOLAMENTE
 end;
end;

procedure ImprimirListaNueva(var ln:listan);
begin
 if(ln <> nil)then begin
  writeln('*****************************************');
  writeln('Codigo de obra: ',ln^.dato.codobra);
  writeln('Cantidad de entrada vendidas en la semana: ',ln^.dato.cante);
  ImprimirListaNueva(ln^.sig);
 end;
end;

//PROGRAMA PRINCIPAL
var
 v:vec;
 ln:listan;
BEGIN
 Randomize;
 ln:= nil;
 inicializar(v);	
 writeln('A continuacion se va a generar las obras que se realizaron en los 7 dias del teatro');
 generar(v);
 writeln('-- LISTA DE OBRRAS GENERADAS --');
 ImprimirVectorDeListas(v);
 writeln('En segundos se totalizara la cantidad de entradas vendidas en cada obra');
 MergeAcumulador(v,ln);
 writeln('-- LISTA DE OBRAS Y CANTIDAD DE ENTRADAS VENDIDAS --');
 ImprimirListaNueva(ln);	
 writeln('El programa ha finalizado sus calculos');
END.

