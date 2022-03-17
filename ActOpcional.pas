program actopcional;
Type
 cliente = record
  apeynom:string;
  dni:integer;
  categoria:integer;
 end;
 lista = ^nodo;
 nodo = record
  dato:cliente;
  sig:lista;
 end; 
 arbol= ^nodoA;
 nodoA= record
  dato: cliente;
  HI:arbol;
  HD:arbol;
 end;
 
procedure leerCliente (var cli:cliente);
begin
 writeln('Ingrese nombre y apellido:');
 readln(cli.apeynom);
 if(cli.apeynom <> 'ZZZ')then begin
  writeln('Ingrese DNI:');
  readln(cli.dni);
  writeln('Ingrese categoria:');
  readln(cli.categoria);
 end;
end;    

procedure cargarLista(var L:lista);
var
 cli:cliente;
 aux:lista;
begin
 leerCliente(cli);
 while (cli.apeynom <> 'ZZZ') do
  begin
   if (L= nil) then
    begin
     new(L);
     L^.dato:= cli;
     L^.sig:= nil 
    end
   else begin
    new(aux);
    aux^.sig:= L;
    L:=aux;
   end; 
   leerCliente(cli);
 end;
end;

procedure agregarEnArbol(var A:arbol; c:cliente);
begin    
 if (A = nil) then 
  begin
   new(A);
   A^.dato:= c;
   A^.HI:= nil;
   A^.HD:= nil;
  end
 else 
  if (c.dni < A^.dato.dni) then 
   agregarEnArbol(A^.HI,c)
  else
   agregarEnArbol(A^.HD,c); 
end;

procedure generarArbol(L:lista; var A:arbol);
begin
 while (L <> nil)do
  begin
   agregarEnArbol(A, L^.dato);
   L:= L^.sig;
  end;
end;

procedure mostrarDNI(A:arbol);
begin    
 if (A <> nil) then 
  begin
   mostrarDNI(A^.HI);
   writeln (A^.dato.dni);
   mostrarDNI(A^.HD);
  end;
end;

procedure mayorCategoria(A:arbol; var c:cliente);
begin
 if (A <> nil) then
 begin
    mayorCategoria (A^.HI,c);
    if(A^.dato.categoria > c.categoria)then
     c:= A^.dato;
    mayorCategoria (A^.HD,c);
 end   
end;

VAR
 L:lista;
 A: arbol;
 c:cliente;
 
BEGIN
 writeln('Bienvenido al programa,por favor ingrese clientes.Puede dejar de ingresarlos poniendo ZZZ en apellido y nombre:');
 cargarLista (L);
 generarArbol(L,A);	
 writeln('Muestro los dni ordenados de menor a mayor');
 mostrarDNI(A);
 writeln;
 writeln;
 mayorCategoria(A,c); 	
 write('El cliente ',c.apeynom,' es el de mayor categorIa');
 readln;
END.

