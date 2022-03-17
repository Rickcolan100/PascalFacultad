program actividad5;
type
 arbol = ^nodo;
 nodo = record
  elem: string;
  hi: arbol;
  hd: arbol;
 end;

//PROCEDIMIENTOS
 Procedure Insertar(var a:arbol; n:string);
 begin
  if(a = nil) then begin
     new(a);
     a^.elem:= n;
     a^.hi:=nil;
     a^.hd:=nil;
  end
  else begin
     if(a^.elem < n) then
        insertar(a^.hi,n)
     else if(n > a^.elem)then
        insertar(a^.hd,n);
  end;
 end;

 procedure generar(var a:arbol);
 var
  n:string;
 begin
  readln(n);
  while(n <> 'ZZZ')do begin
   Insertar(a,n);
   readln(n);
  end;
 end; 
 
 function Buscar(a:arbol;nom:string;var punt:arbol;var ok:boolean):arbol;
 begin
  if(a <> nil)then begin
   if(a^.elem = nom)then begin
    ok:= true;
    punt:= a;
    Buscar:= punt;
   end;
  end
  else begin
   if(a^.elem > nom)then
    Buscar:=Buscar(a^.hi,nom,punt,ok)
   else
    Buscar:=Buscar(a^.hd,nom,punt,ok);
   end;
   Buscar:= nil;
 end;

//PROGRAMA PRINCIPAL
var
 a,punt:arbol;
 ok:boolean;
 nom:string;
BEGIN
 generar(a);
 readln(nom);	
 buscar(a,nom,punt,ok);
 if(ok = true)then
  writeln('el nombre existe y su nombre es: ',punt^.elem)
 else
  writeln('el nombre no existe'); 
END.

