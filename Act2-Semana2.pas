program Act2Semana2;
type
 vec = array[1..20]of integer;

procedure generar(var v:vec);
var 
 num,i:integer;
begin
 for i:= 1 to 20 do begin
  writeln('ingrese un numero');
  readln(num);
  v[i]:= num;
 end;
end;

procedure varmaximo(v:vec;i:integer;var max:integer);
begin
 if(v[i] > max)then begin
  max:= v[i];
  varmaximo(v,i+1,max);
 end;
end;

procedure total(v:vec;i:integer;var sum:integer);
begin
 if(i <= 20)then begin
  sum:= sum + v[i];
  total(v,i+1,sum);
 end;
end;

procedure BusquedaDicotomica(v:vec;ini,fin,dato:integer;var pos:integer;var ok:boolean); //busqueda por recursion NO MODIFICAR
var
 medio:integer;
begin
 if(ini > fin)then begin //el dato no existio por lo tanto puede terminar aca
  pos:= -1;      //no se encuentra por lo tanto la posicion es 0
  ok:=false;
 end
 else begin
  medio:= (ini + fin) div 2;
  if(v[medio] = dato)then begin //se encontro el dato y termina aca
   ok:=true;
   pos:= medio //se encuentra entonces a pos se le asigna medio donde esta la posicion y sin ; por que se cierra
  end
  else begin
   if(v[medio] < dato)then //busca mediante recursion,agregar campo a v[medio] si es un registro con campos 
    BusquedaDicotomica(v,ini,medio-1,v[medio],pos,ok) //el dato esta en la segunda parte del vector,fin es medio-1
   else if(v[medio] > dato)then
    BusquedaDicotomica(v,medio+1,fin,v[medio],pos,ok); //el dato esta en la primera parte del vector,Ini es medio+1
   end;
 end;
end;   

var
 v:vec;
 sum,max,i,ini,fin,pos,dato:integer;
 ok:boolean;
BEGIN
 max:= 0;
 sum:= 0;
 ini:= 1; 
 fin:= 20;
 ok:= false;
 writeln('Bienvenido al programa,ingrese 20 numeros');
 generar(v);
 i:= 1;
 varmaximo(v,i,max);
 writeln('El valor maximo encontrado es: ',max);
 total(v,i,sum);
 writeln('La suma de todos los valores es: ',sum);
 writeln('Ingrese un numero a buscar via busqueda dicotomica');
 readln(dato);
 BusquedaDicotomica(v,ini,fin,dato,pos,ok);
 if(ok = true)then
  writeln('El numero se encuentra en la posicion ',pos)
 else
  writeln('El numero no se encuentra y por lo tanto esta en la posicion ',pos);		
END.

