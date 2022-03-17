program actrepaso2;
type
 voto = record
  nom:string;
  lis:lista;
 end;
 lista = ^nodo;
 nodo = record
  topico:string;
  cantvotos:integer;
  sig:lista;
 end;
 arbol = ^nodoa;
 nodoa = record
  dato:voto;
  hi:arbol;
  hd:arbol;
 end;

//PROCEDIMIENTOS
Procedure AgregarOrdenado(var lis: lista; topico:string);
var ant, nue, act: lista;
begin
 new (nue);
 nue^.topico := topico;
 nue^.cantvotos:= nue^.cantvotos + 1;
 act := lis;
 while (act <> nil) and (act^.dato.topico < topico) do begin
  ant := act;
  act := act^.sig;
 end;
 if (act = lis)  then l := nue   
                 else ant^.sig := nue; 
 nue^.sig := act ;
end; 

procedure leer(var v:voto);
var
 topico:string;
begin
 readln(v.nom);
 if(v.nom <> 'zzz')then begin
   readln(topico);
   AgregarOrdenado(v.lis,topico);
 end;
end;

Procedure Insertar(var a:arbol;v:voto);
begin
 if(a = nil) then begin
    new(a);
    a^.dato:= v;
    a^.hi:=nil;
    a^.hd:=nil;
 end
 else begin
  if(a^.dato.lis^.dato.topico > v.lis^.topico)then
   insertar(a^.hi,n)
  else if(a^.dato.lis^.topico <= v.lis^.topico)then
   insertar(a^.hd,n);
  end;
end;

procedure generar(var a:arbol);
var
 v:voto;
begin
 v.lis:= nil; 
 leer(v);
 while(v.nom <> 'zzz')do begin
  Insertar(a,v);
  leer(v);
 end;
end;
 

var
 a:arbol; 
BEGIN
 generar(a);
	
	
END.

