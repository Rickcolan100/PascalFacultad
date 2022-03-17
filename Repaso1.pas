program actrepaso1;
const
 cant = 6;
type
 //CARGA
 alumno = record
  nomyape:string;
  anio:integer;
  nota:integer;
 end;
 lista = ^nodo;
 nodo = record
  dato:alumno;
  sig:lista;
 end;
 vec = array[1..cant]of lista;
 //PROCESAMIENTO
 notas = record
  nota:integer;
  cantnotas:integer;
 end;
 arbol = ^nodoa;
 nodoa = record
  dato:notas;
  hi:arbol;
  hd:arbol;
 end;
 listan = ^nodon;
 nodon = record
  dato:notas;
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

Procedure AgregarOrdenado(var l: lista; a:alumno);
var ant, nue, act: lista;
begin
 new (nue);
 nue^.dato := a;
 act := l;
 while (act <> nil) and (act^.dato.nota > a.nota) do begin
  ant := act;
  act := act^.sig;
 end;
 if (act = l)  then l := nue   
                 else ant^.sig := nue; 
 nue^.sig := act ;
end;

procedure leer(var a:alumno);
begin
 a.anio:= random(6);
 if(a.anio <> 0)then begin
  writeln('Ingrese nombre y apellido: ');
  readln(a.nomyape);
  a.nota:= random(10);
 end;
end; 

procedure generar(var v:vec);
var
 a:alumno;
begin
 leer(a);
 while(a.anio <> 0)do begin
  AgregarOrdenado(v[a.anio],a);
  leer(a);
 end;
end; 

procedure determinarMaximo(var v:vec;var max:alumno);  
Var
 pos,i:integer;
Begin
 max.nota:= -1;
 pos:=0;
 for i:=1 to 6 do begin
  if(v[i] <> nil)then begin
   if(v[i]^.dato.nota > max.nota)then begin
    max:= v[i]^.dato;
    pos:= i;
   end;
  end;
 end;
 if(max.nota <> -1)then begin
  v[pos]:=v[pos]^.sig;
 end;
end;

Procedure Insertar(var a:arbol;n:notas);
begin
 if(a = nil) then begin
    new(a);
    a^.dato:= n;
    a^.hi:=nil;
    a^.hd:=nil;
 end
 else begin
  if(a^.dato.nota > n.nota)then
   insertar(a^.hi,n)
  else if(a^.dato.nota <= n.nota)then
   insertar(a^.hd,n);
  end;
end;
 
Procedure MergeAcumulador(v:vec; var a:arbol);
var
 max:alumno;
 n:notas;
begin
 determinarMaximo(v,max);
 while (max.nota <> -1) do begin
  n.nota:= max.nota;
  n.cantnotas:=0;
  while (n.nota = max.nota) do begin
   n.cantnotas:= n.cantnotas + 1;
   determinarMaximo(v,max);
  end;
  Insertar(a,n);  
 end;
end;
 
//calcular minimo y maximo con el marge del arbol
function varMin(a:arbol):arbol; 
begin
 if(a <> nil)then begin
  if(a^.hi <> nil)then
    varMin:= varMin(a^.hi) 
  else
   varMin:= a;
 end
 else
   varMin:= nil;
end;

function varMax(a:arbol):arbol; 
begin
 if(a <> nil)then begin
  if(a^.hd <> nil)then
    varMax:= varMax(a^.hd) 
  else
   varMax:= a;
 end
 else
   varMax:= nil;
end;

//crear una lista con el arbol
procedure AgregarAlFinal(var ln, ult: listan; n:notas); 
var  nue : listan;
begin 
 new (nue);
 nue^.dato:= n;
 nue^.sig := NIL;
 if (ln <> nil) then 
      ult^.sig := nue
 else 
      ln := nue;
 ult := nue;
end;

procedure crearnuevaestructura(a:arbol;var ln:listan;inf,sup:integer);
var
 ult:listan;
begin
 ult:= nil;
 if(a <> nil)then begin
  if(a^.dato.cantnotas >= inf)then begin
   if(a^.dato.cantnotas <= sup)then begin  
    AgregarAlFinal(ln,ult,a^.dato);
    crearnuevaestructura(a^.hi,ln,inf,sup);
    crearnuevaestructura(a^.hd,ln,inf,sup);
   end;
  end
  else
   crearnuevaestructura(a.^hd,ln,inf,sup)
 end
 else
  crearnuevaestructura(a.^hi,ln,inf,sup)
end;

procedure imprimir(var ln:listan);
begin
 if(ln <> nil)then begin
  writeln('*****************************************');
  writeln('Codigo de obra: ',ln^.dato.nota);
  writeln('Cantidad de entrada vendidas en la semana: ',ln^.dato.cantnotas);
  imprimir(ln^.sig);
 end;
end;

//PROGRAMA PRINCIPAL
var
 v:vec;
 a:arbol
 ln:listan;
 inf,sup:integer;
 min,max:arbol;
BEGIN
 ln:= nil;
 writeln('Bienvenido al programa,ingrese nombre y apellido y el resto de los datos se van a generar solos');
 generar(v);
 writeln('La estructura se ha generado,ahora se procesaran los datos');	
 MergeAcumulador(v,a);
 min:= varMin(a);
 max:= varMax(a);
 writeln('- PROCESAMIENTO COMPLETADO -');	
 writeln('La cantidad minima de aprobados con la nota ',min.nota,' es: ',min.cantnotas);
 writeln('La cantidad maxima de aprobados con la nota ',max.nota,'es: ',max.cantnotas);
 writeln('Ingrese valor inferior y superior para crear una estructira nueva');
 writeln('Valor inferior en la cantidad de notas: ');		
 readln(inf);
 writeln('Valor valor superior en la cantidad de notas: ');
 readln(sup);
 crearnuevaestructura(a,ln,inf,sup);
 writeln('- PROCESAMIENTO COMPLETADO -');	
 writeln('Lista creada a partir de la busqueda entre ',inf,' y ',sup,': ');
 imprimir(ln);	
END.

