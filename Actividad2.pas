program actividad2;
const
 dimf = 20;
type
 participante = record
  cod:integer;
  edad:integer;
 end;
 vec = array[1..dimf]of participante;
 lista = ^nodo;
 nodo = record
  dato:participante;
  sig:lista;
 end;
 
procedure leer(var p:participante);
begin
 writeln('Ingrese codigo del participante: ');
 readln(p.cod);
 if(p.cod <> -1)then begin
  writeln('Ingrese edad del paticipante');
  readln(p.edad);
 end;
end; 
 
procedure cargar(var v:vec;var diml:integer);  //1
var
 p:participante;
begin
 leer(p);
 while(p.cod <> -1)and(diml < 20)do begin
  diml:= diml + 1;
  v[diml]:= p;
  leer(p);
 end;
end;

procedure OrdenadoInsercion(var v:vec; diml:integer); 
var
 i,j:integer;
 aux:participante;
begin
 for i:=2 to dimL do begin
  aux:= v[i];
  j:=i-1;
  while(j > 0)and(v[j].edad > aux.edad)do begin
   v[j+1]:=v[j];
   j:= j - 1;
  end;
  v[j+1]:=aux;
 end;
end;

procedure buscar(v:vec ; diml:integer;var pos:integer);
var
 i:integer;
begin
 i:= 1;
 while(i < diml)do begin
  if((v[i].edad >= 20)and(v[i].edad <= 22))then
   pos := i
  else
   i:= i + 1;
 end;
end;

procedure borrar(var v:vec; diml:integer; pos:integer);
var
 i:integer;
begin
 for i:= pos downto diml-1 do 
  v[i]:= v[i + 1];
 diml:= diml - 1;
end;
  
procedure imprimir(v:vec; diml:integer);
var
 i:integer;
begin
 for i:= 1 to diml do begin
  writeln('Codigo: ', v[i].cod);
  writeln('Edad: ', v[i].edad);
 end;
end;

procedure AgregarOrdenado(var l: lista; p:participante);
var ant, nue, act: lista;
begin
 new (nue);
 nue^.dato := p;
 act := l;
 while (act<>NIL) and (act^.dato.edad < p.edad) do begin
  ant := act;
  act := act^.sig ;
 end;
 if (act = l)  then l := nue   
                 else ant^.sig := nue; 
 nue^.sig := act ;
end;

procedure generarl(var l:lista; v:vec; diml:integer);
var
 i:integer;
begin
 for i:= 1 to diml do
  AgregarOrdenado(l,v[i]);
end;

procedure imprimirlista(l:lista);
begin
 while(l <> nil)do begin
  writeln('Codigo del participante: ',l^.dato.cod);
  writeln('Edad del participante: ',l^.dato.edad);
  l:= l^.sig;
 end;
end;    
 
var 
 v:vec;
 l:lista;
 diml,pos:integer;
BEGIN
 writeln('Bienvenido al programa,ingrese 20 participantes o deje de ingresarlos con -1');
 cargar(v,diml);
 writeln('Lista de participantes');
 imprimir(v,diml);
 writeln('A continuacion se ordenara los participantes en base a su edad');
 OrdenadoInsercion(v,diml);
 writeln('Lista de participantes ordenados');
 imprimir(v,diml);
 writeln('A continuacion se eliminara el/los participantes con edad de 20 a 22');
 buscar(v,diml,pos);
 borrar(v,diml,pos);
 writeln('Lista de participantes sin participantes con edad entre el rango de 20 a 22');
 imprimir(v,diml);;
 writeln('A continuacion se creara una lista ordenada en base al trabajo anterior');
 l:= nil;
 generarl(l,v,diml);
 writeln('Lista ordenada en base al criterio anterior');
 imprimirlista(l); 	
END.

