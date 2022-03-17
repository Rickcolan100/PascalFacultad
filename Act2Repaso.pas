program Actrepa2;
const
 dimf = 300;
type
 oficina = record
  id:integer;
  dni:integer;
  valex:integer;
 end;  
 vec = array[1..dimf]of oficina;
 
procedure leer(var o:oficina);
begin
 writeln('Ingrese numero de indentificacion: ');
 readln(o.id);
 if(o.id <> -1)then begin
  writeln('Ingrese DNI: ');
  readln(o.dni);
  writeln('Ingrese valor de expensas: ');
  readln(o.valex);
 end; 
end;

procedure cargar(var v:vec ; var diml:integer);
var
 o:oficina;
begin
 leer(o);
 while(o.id <> -1)and(diml < 300)do begin
  diml:= diml + 1;
  v[diml]:= o;
  leer(o);
 end; 
end;

procedure OrdenadoPorInsercion(var v:vec;diml:integer); //ordena todo el contenido NO MODIFICAR
var
 i,j:integer;
 aux:oficina;
begin
 for i:=2 to dimL do begin
  aux:= v[i];
  j:=i-1;
  while(j > 0)and(v[j].id > aux.id)do begin //si es con registro poner los campos por que no funciona
   v[j+1]:=v[j];
   j:= j - 1;
  end;
  v[j+1]:=aux;
 end;
end; 

procedure BusquedaDicotomica(v:vec;ini,fin:integer;dato:integer;var pos:integer;var ok:boolean); //busqueda por recursion NO MODIFICAR
var
 medio:integer;
begin
 if(ini > fin)then begin //el dato no existio por lo tanto puede terminar aca
  pos:= -1;      //no se encuentra por lo tanto la posicion es 0
  ok:=false;
 end
 else begin
  medio:= (ini + fin) div 2;
  if(v[medio].id = dato)then begin //se encontro el dato y termina aca
   ok:=true;
   pos:= medio //se encuentra entonces a pos se le asigna medio donde esta la posicion y sin ; por que se cierra
  end
  else begin
   if(v[medio].id < dato)then //busca mediante recursion,agregar campo a v[medio] si es un registro con campos 
    BusquedaDicotomica(v,ini,medio-1,v[medio].id,pos,ok) //el dato esta en la segunda parte del vector,fin es medio-1
   else if(v[medio].id > dato)then
    BusquedaDicotomica(v,medio+1,fin,v[medio].id,pos,ok); //el dato esta en la primera parte del vector,Ini es medio+1
   end;
 end;
end; 

procedure imprimir(v:vec; diml:integer);
var
 i:integer;
begin
 for i:= 1 to diml do begin
  writeln('ID: ',v[i].id);
  writeln('DNI: ',v[i].dni);
  writeln('Valor de expensas: ',v[i].valex);
 end;
end;  

var
 v:vec;
 diml,ini,fin,num,pos:integer;
 ok:boolean;
BEGIN
 ok:= false;
 diml:= 0;
 writeln('*****************************************************************************');
 writeln('Bienvenido al programa, ingrese la oficina - CON ID -1 DEJA DE PROCESAR - ');
 cargar(v,diml);
 writeln('- CARGA TERMINADA -');
 writeln('A continuacion se ordenaran las oficinas');
 OrdenadoPorInsercion(v,diml);
 imprimir(v,diml);
 writeln('- OPERACION TERMINADA -');
 writeln('--------------------------BUSQUEDA DE OFICINA----------------------------');
 ini:= 1;
 fin:= diml;
 writeln('Ingrese oficina a buscar');
 readln(num);
 BusquedaDicotomica(v,ini,fin,num,pos,ok);
 if(ok = true)then 
  writeln('La oficina esta a cargo del propietario con DNI:' , v[pos].dni)
 else
  writeln('La oficina no existe'); 
 writeln('*****************************************************************************'); 
END.

