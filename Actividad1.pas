program actividad1;
const
 dimf = 20;
type
 vec = array[1..dimf]of integer;
 lista = ^nodo;
 nodo = record
  dato:integer;
  sig:lista;
 end;

procedure cargar(var v:vec;var diml:integer);  //1
var
 num:integer;
begin
 writeln('Ingrese un numero: ');
 readln(num);
 while(num <> 0)and(diml < 20)do begin
  diml:= diml + 1;
  v[diml]:= num;
  writeln('Ingrese un numero: ');
  readln(num);
 end;
end;

procedure imprimir(v:vec ; diml:integer); //2
var
 i:integer;
begin
 for i:= 1 to 20 do 
  writeln(v[i]);
end;

procedure busqueda(v:vec ; diml:integer; num:integer;var ok:boolean;var pos:integer);
var
 i:integer;
begin
 i:= 1;
 while(i < diml)and(v[i] <> num)do begin
  if(num = v[i])then begin
   pos:= i;
   ok := true;
  end
  else
   i:= i + 1;
 end;
end;

procedure borrar(var v:vec; diml:integer; pos:integer); //3
var
 i:integer;
begin
 for i:= pos to diml-1 do 
  v[i]:= v[i + 1];
 diml:= diml - 1;
end;

procedure AgregarAtras (var l, ult: lista; num:integer); 
var  
 nue : lista;
begin 
 new (nue);
 nue^.dato:= num;
 nue^.sig := nil;
 if (l <> nil) then 
  ult^.sig := nue
 else 
  l := nue;
 ult := nue;
end;

procedure generarl(var l:lista);
var
 ult:lista;
 num:integer;
begin
 ult:= l;
 num:= random(15);
 while(num <> 15)do begin
  AgregarAtras(l,ult,num);
  num:= random(15);
 end;
end;

procedure imprimirl(l:lista);
begin
 while(l <> nil)do begin
  writeln('numero: ', l^.dato);
  l:= l^.sig;
 end;
end;
   
var 
 v:vec;
 diml,num,pos:integer;
 ok:boolean;
 l:lista;
BEGIN
 Randomize;
 l:= nil;
 diml:= 0;
 pos:= 0;
 ok := false;
 writeln('Bienvenido al programa,ingrese 20 numeros o con 0 deje de ingresar elementos');
 cargar(v,diml);
 writeln('Items almacenados en el vector');
 imprimir(v,diml);
 writeln('Ingrese un elemento a borrar del vector: ');
 readln(num);
 busqueda(v,diml,num,ok,pos);
 borrar(v,diml,pos);
 if(ok)then
  writeln('El numero fue borrado')
 else
  writeln('El numero ', num, ' no existe en el arreglo');
 writeln('A continuacion se generara una lista y se va a imprimir');
 generarl(l);
 imprimirl(l);	
END.

