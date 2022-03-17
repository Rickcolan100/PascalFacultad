program examenpractico;
type
 rangobra = 1..5; //rango de la obra social
 //DATOS DE CARGA
 paciente = record
  dni:integer;
  cod:integer;
  obrasocial:rangobra;
  costoab:integer;
 end;
 arbol = ^nodoa;
 nodoa = record
  elem:paciente;
  hi:arbol;
  hd:arbol;
 end;
 //PROCESAMIENTO
 pacienteg = record //registro nuevo con datos de pacientes galeno
  codigo:integer;
  dnis:integer;
 end;
 lista = ^nodo;
 nodo = record
  dato:pacienteg;
  sig:lista;
 end; 
 
 
//PROCESOS 
procedure leer(var p:paciente);
begin 
 writeln('INGRESE DNI');
 readln(p.dni);
 if(p.dni <> 0)then begin
  writeln('INGRESE CODIGO DEL PACIENTE');
  readln(p.cod);
  writeln('INGRESE OBRA SOCIAL(1-5)');
  readln(p.obrasocial);
  writeln('INGRESE COSTO ABONADO');
  readln(p.costoab); 
 end;
end;

Procedure Insertar(var a:arbol;p:paciente);
begin
 if(a = nil) then begin
    new(a);
    a^.elem:= p;
    a^.hi:=nil;
    a^.hd:=nil;
 end
 else begin
  if(a^.elem.dni > p.dni)then
   insertar(a^.hi,p)
  else
   insertar(a^.hd,p);
  end;
end;

procedure generar(var a:arbol);  //INCISO A
var
 p:paciente;
begin
 leer(p);
 while(p.dni <> 0)do begin
  Insertar(a,p);
  leer(p);
 end;
end;

procedure copiar(a:arbol;var pg:pacienteg);
begin
 pg.codigo:= a^.elem.cod;
 pg.dnis:= a^.elem.dni;
end;

procedure AgregarAtras (var l, ult: lista; pg:pacienteg); 
var  
  nue : lista;
begin 
  new (nue);
  nue^.dato:= pg;
  nue^.sig := NIL;
  if (l <> Nil) then 
                 ult^.sig := nue
               else 
                 l := nue;
  ult := nue;
end;

procedure listagaleno(a:arbol;var l:lista); //INCISO B
var
 pg:pacienteg;
 ult:lista;
begin
 if(a <> nil)then begin
  if(a^.elem.obrasocial = 4)then
   copiar(a,pg);
   AgregarAtras(l,ult,pg);  
  listagaleno(a^.hi,l);
  listagaleno(a^.hd,l);
 end;
end;

procedure imprimir(var l:lista);
begin
 if(l <> nil)then begin
  writeln('*****************************************');
  writeln('Codigo del paciente: ',l^.dato.codigo);
  writeln('DNI del paciente: ',l^.dato.dnis);
  imprimir(l^.sig);
 end;
end;

procedure imprimirdni(a: arbol);
begin
 writeln('Codigo del paciente: ',a^.elem.cod);
 writeln('Obra Social del paciente: ',a^.elem.obrasocial);
 writeln('Costo abonado por sesion del paciente: ',a^.elem.costoab);
 writeln('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
end;

procedure VerValoresRango(a:arbol;inf,sup:integer); //INCISO C
begin
  if(a <> nil)then begin
   if(a^.elem.dni >= inf)then begin
    if(a^.elem.dni <= sup)then begin
      imprimirdni(a);
      VerValoresRango(a^.hi,inf,sup);
      VerValoresRango(a^.hd,inf,sup);
     end
     else
      VerValoresRango(a^.hi,inf,sup)
   end
   else
    VerValoresRango(a^.hd,inf,sup);
 end;
end;

//PROGRAMA PRINCIPAL 
var
 a:arbol;
 inf,sup:integer;
 l:lista;
BEGIN
 l:=nil;
 writeln('Bienvenido al programa,ingrese pacientes y con dni 0 deja de procesar');
 writeln('---------------------CARGA DE DATOS-------------------------------------');
 generar(a);  //inciso a
 writeln('------------------------------------------------------------------------');
 writeln('ARBOL CARGADO');
 writeln('---------------------PROCESAMIENTO DE DATOS----------------------------');
 writeln('Ahora se generara la lista de paciente que tienen obra social galeno');
 listagaleno(a,l);  //inciso b
 writeln('Lista de pacientes de galeno: ');
 imprimir(l);
 writeln('------------------------------------------------------------------------');
 writeln('Ingrese dnis ver la lista de pacientes comprendida');
 writeln('DNI INFERIOR: ');
 readln(inf);
 writeln('DNI SUPERIOR: ');
 readln(sup);
 writeln('------------------------------------------------------------------------');
 writeln('LISTA DE DNIs ENTRE LOS RANGOS');
 VerValoresRango(a,inf,sup); //inciso c
 writeln('------------------------------------------------------------------------');
 writeln('El programa ha finalizado');		
END.

