program NumAleatorio;
var num:integer;
begin
 Randomize;  
 num := random (100); {valores en el intervalo 0 a 99}
 writeln('El numero aleatorio generado es: ', num);
 readln;
end.

