program Act6Semana2;
type
 cont = 1..14000;
 alumno = record
  leg:cont;
  nom:string;
  ape:string;
  anoing:integer
 end;
 arbol = ^nodo;
 nodo = record
   elem: alumno;
   hi: arbol;
   hd: arbol;
 end;

procedure Insertar(var a:arbol; alu:alumno);
begin
 if(a = nil) then begin
  new(a);
  a^.elem:= alu;
  a^.hi:= nil;
  a^.hd:= nil;
 end
 else begin
  if(alu.leg < a^.elem.leg) then
   insertar(a^.hi,alu)
  else if(alu.leg < a^.elem.leg)then
   insertar(a^.hd,alu);
  end;
end;

procedure leer(var alu:alumno);
begin
 writeln('Ingrese año de ingreso');
 readln(alu.anoing);
 if(alu.anoing > 2000)then begin
  writeln('Ingrese nombre');
  readln(alu.nom);
  writeln('Ingrese apellido');
  readln(alu.ape);
  writeln('Ingrese numero de legajo');
  readln(alu.leg);
 end;
end;

procedure generar(var a:arbol);
var 
 alu:alumno;
begin
 leer(alu);
 while(alu.anoing > 2000)do begin
  insertar(a,alu);
  leer(alu); 
 end;
end;    

procedure imprimirvalleg(a:arbol); 
begin
 if(a <> nil)then begin
  if(a^.elem.leg >= 12803)then begin
   writeln('Nombre:   ',a^.elem.nom);
   writeln('Apellido: ',a^.elem.ape);
   imprimirvalleg(a^.hi);
   imprimirvalleg(a^.hd);
  end;
 end;
end;

procedure valrango(a:arbol; inf,sup:integer);
begin
 if(a <> nil)then begin
  if(a^.elem.leg >= inf)then begin
   if(a^.elem.leg <= sup)then begin
     writeln('Nombre:   ',a^.elem.nom);
     writeln('Apellido: ',a^.elem.ape);
     valrango(a^.hi,inf,sup);
     valrango(a^.hd,inf,sup);
    end
    else
     valrango(a^.hi,inf,sup)
  end
  else
   valrango(a^.hd,inf,sup);
 end;
end;
 
var
 a:arbol;
 inf,sup:integer;
BEGIN
 inf:= 2803;
 sup:= 6982;
 writeln('Bienvenido al programa,Ingrese alumnos con año de ingreso mayor a 2000');
 generar(a);
 writeln('Alumnos con numero de legajo mayor o igual a 12803');
 imprimirvalleg(a);
 writeln('Alumnos con legajo entre numeros 2083-6983');
 valrango(a,inf,sup); 		
END.

