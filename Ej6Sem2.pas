program actividad5;
type
 alumno = record
  leg:integer;
  apynom:string;
  dni:integer;
  anoing:integer;
 end;
 arbol = ^nodo;
 nodo = record
  elem: alumno;
  hi: arbol;
  hd: arbol;
 end;

//PROCEDIMIENTOS
 Procedure Insertar(var a:arbol; al:alumno);
 begin
  if(a = nil) then begin
   new(a);
   a^.elem:= al;
   a^.hi:=nil;
   a^.hd:=nil;
  end
  else 
   if(a^.elem.leg < al.leg) then
    insertar(a^.hi,al)
   else 
    if(al.leg > a^.elem.leg)then
     insertar(a^.hd,al);
 end;
 
 procedure leer(var al:alumno);
 begin
  al.anoing:= random(2021);
  if(al.anoing >= 2000)then begin
   writeln('Ingrese nombre y apellido');
   readln(al.apynom);
   al.leg:= random(17000);
  end;
 end;

 procedure generar(var a:arbol);
 var 
  al:alumno;
 begin
  leer(al);
  while(al.anoing >= 2000)do begin
   insertar(a,al);
   leer(al); 
  end;
 end;
 
 procedure imprimirleg(a:arbol); 
 begin
  if(a <> nil)then begin
   if(a^.elem.leg >= 12803)then begin
    writeln('Nombre y apellido:   ',a^.elem.apynom);
    imprimirleg(a^.hi);
    imprimirleg(a^.hd);
   end;
  end;
 end; 
 
 procedure valrango(a:arbol; inf,sup:integer);
 begin
  if(a <> nil)then begin
   if(a^.elem.leg >= inf)then begin
    if(a^.elem.leg <= sup)then begin
      writeln('Nombre y apellido: ',a^.elem.apynom);
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

//PROGRAMA PRINCIPAL
var
 a:arbol;
 inf,sup:integer;
BEGIN
 Randomize;	
 inf:= 2803;
 sup:= 6982;
 writeln('Bienvenido al programa,se va a generar el listado de alumnos');
 generar(a);	
 writeln('Nombree y apellido de personas con legajo mayor a 12803: ');
 imprimirleg(a);
 writeln('Nombree y apellido de personas con legajo mayor a 2803 y menor a 6982: ');
 valrango(a,inf,sup);
END.

