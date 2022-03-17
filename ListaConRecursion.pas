program actividad7;
type
 lista = ^nodo;
 nodo = record
  dato:integer;
  sig:lista;
 end;

//PROCEDIMIENTOS
 procedure AgregarAlFinal(var pri, ult: lista; n:integer); 
 var  nue : lista;
 begin 
  new (nue);
  nue^.dato:= n;
  nue^.sig := nil;
  if (pri <> nil) then 
      ult^.sig := nue
  else 
      pri := nue;
  ult := nue;
 end;

 procedure generar(var l:lista);
 var
  n:integer;
  ult:lista;
 begin
  ult:= l;
  n:= random(100);
  while(n <> 0)do begin
   AgregarAlFinal(l,ult,n);
   n:= random(100);
  end;
 end;  
 
 procedure Imprimir(l:lista); //iterativo
 begin
  while(l <> nil)do begin
   writeln(l^.dato);
   l:= l^.sig;
  end;
 end;
 
 procedure ImprimirEnOrden(l:lista); //recursivo en orden
 begin
  if(l <> nil)then begin
   writeln(l^.dato);
   ImprimirEnOrden(l^.sig);
  end;
 end;
 
 procedure ImprimirOrdenInverso(l:lista); //recursivo en orden inverso
 begin
  if(l <> nil)then begin
   ImprimirOrdenInverso(l^.sig);
   writeln(l^.dato);
  end;
 end;
 
//PROGRAMA PRINCIPAL 
var
 l:lista;
BEGIN
 Randomize;
 generar(l);
 writeln('Imprimir la lista generada');
 Imprimir(l);
 writeln('Imprimir en orden');
 ImprimirEnOrden(l);
 writeln('Imprimir en orden inverso');
 ImprimirOrdenInverso(l);	
END.

