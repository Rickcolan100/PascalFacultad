program ProgramaDos; 
CONST
 DIMF=20;
 CORTE=0;
type 
 jugador = record
  dni: integer;
  nombre: string;
  altura: real;
 end;
 lista = ^nodo;
 nodo = record
  dato: jugador;
  sig: lista;
 end;
 vector= array[1..DIMF] of jugador;
   
//MODULOS
procedure leerDatos(var J:jugador);
begin  
 writeln('Escriba el dni');  
 readln(j.dni);  
 if(J.dni <> CORTE)then begin    
  writeln('Escriba el nombre');    
  readln(j.nombre);    
  writeln('Escriba la altura');    
  readln(j.altura);  
 end;
end;

procedure AgregarAlFinal(var pri, ult: lista; dato: jugador); 
var  nue : lista;
begin 
 new (nue);
 nue^.dato:= dato;
 nue^.sig := NIL;
 if pri <> Nil then 
      ult^.sig := nue
 else 
      pri := nue;
 ult := nue;
end;

procedure  CargarListaAgregandoAtras(var l: lista; var promedio: real);
var
 dato: jugador; ult:lista; 
 total: integer;
begin
 l:= nil; 
 ult:=nil;
 leerDatos(dato);
 promedio:= 0; 
 total:=0;
 while (dato.dni <> CORTE) do begin
  promedio:= promedio + dato.altura; 
  total:= total+1;
  AgregarAlFinal( l, ult , dato);
  leerDatos(dato);
 end;
 promedio:= promedio / total;
end;

procedure mostrarDatos(j: jugador);
begin
  Writeln('DNI: ', j.dni, ' Nombre: ', j.nombre, ' Altura: ', j.altura:0:2);
end; 

procedure ImprimirLista(l: lista); 
begin
 while (l <> nil) do begin 
   mostrarDatos(l^.dato);
   l:= l^.sig;
 end;
end;

procedure CargarVector(var v: vector; var diml: integer;
						l: lista; promedio: real);
begin
  diml:=0;
  while (l <> nil) and (diml<DIMF) do begin 
	if (l^.dato.altura > promedio) then begin
		diml:= diml+1;
		v[diml]:= l^.dato;
	end;
	l:= l^.sig;	
  end;
end;


procedure ImprimirVector( v: vector;  diml: integer);
var
  i: integer;
begin
  for i:= 1 to diml do begin 
	mostrarDatos(v[i]);
  end;
  writeln;
end;

procedure OrdenarPorInsercion(var v: vector; diml: integer);
var
  i,j: integer;
  actual:jugador;
begin
  for i:=2 to diml do begin 
     actual:= v[i];    // Guardo elemento a ordenar
     j:= i-1; 
     while (j > 0) and (v[j].dni > actual.dni) do begin
        v[j+1]:= v[j];
        j:= j - 1;  
     end;
     v[j+1]:= actual;  // Guardar elemento en v[j+1]
  end;
end;

function BuscarElementoVO(v: vector; diml: integer; x: integer): integer;
var  
  pri,ult,medio,pos:integer;
begin  
  pri:=1;  
  ult:=diml;  
  medio:=(pri+ult)div 2;  
  while(pri<=ult)and(v[medio].dni <> x)do begin
      if(v[medio].dni < x)then  pri:=medio+1     
					  else      ult:=medio-1;    
      medio:=(pri+ult)div 2;   
  end;  
  if(pri<=ult) then 
	pos:= medio
  else 
    pos:=0;
  BuscarElementoVO:= pos;
end;

var
   l: lista;
   promedio: real;
   v: vector;
   diml: integer;
   abuscar, pos:integer;
begin
   CargarListaAgregandoAtras(l, promedio);
   Writeln('La lista tiene los siguientes datos ');
   ImprimirLista(l);
   Writeln('El promedio de alturas es: ', promedio:0:2);
   CargarVector(v, diml, l, promedio);
   Writeln('El vector tiene los siguientes datos ');
   ImprimirVector( v, diml);
   OrdenarPorInsercion(v,diml);
   Writeln('El vector tiene los siguientes datos (ORDENADO)');
   ImprimirVector( v, diml);
   Writeln('Ingrese el DNI a buscar ');
   readln(abuscar);
   pos:= BuscarElementoVO(v,diml,abuscar);
   if (pos <> 0) then 
    Writeln('El dato estaba en la posicion ', pos, ' y su altura es ', v[pos].altura:0:2)
   else
    Writeln('El dato NO existia');
   readln;
end. 

