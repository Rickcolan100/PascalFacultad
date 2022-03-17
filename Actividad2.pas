program ProgramaDos;
CONST
  DIMFIS = 4;	// Dimension fisica del vector de listas
  CORTE = 0;   //Corte de Lectura
  VALOR_MUY_ALTO= MAXINT; //Para el merge
Type
  Venta=record
     codventa:integer;
     codproducto:integer; //Campo de ordenamiento
     cantvendida:integer;
  end;

  Lista= ^Nodo; // Lista de Ventas 
  Nodo= Record
       dato: Venta;
       sig: Lista;
  End;

  VectorListas = array[1..DIMFIS] of Lista; // Vec de Listas
  
  //***********LISTA ACUMULADORA *********/
  
  ProductoAcumulado= record
     codproducto: integer;   //Campo de ordenamiento
     totalvendido: integer;
  end;
  
  ListaAcumuladora= ^NodoA; // Lista Acumuladora
  NodoA= Record
       dato: ProductoAcumulado;
       sig: ListaAcumuladora;
  End;
  
  

// MODULOS PARA CARGAR EL VECTOR DE LISTAS

procedure leerDatos(var dato: venta);
begin 
  dato.codventa:= random(10);
  if (dato.codventa <> CORTE) then begin
    dato.codproducto:= random(50);
    dato.cantvendida:= random(50);
  end;

end;


Procedure InsertarOrdenado ( var pri: lista; dato: venta);
var ant, nue, act: lista;
begin
  new (nue);
  nue^.dato := dato;
  act := pri;
  ant := pri;
{Recorro mientras no se termine la lista y no encuentro la posición correcta}
  while (act<>NIL) and (act^.dato.codproducto < dato.codproducto) do begin
      ant := act;
      act := act^.sig ;
  end;
  if (ant = act)  then pri := nue   {el dato va al principio}
                  else  ant^.sig  := nue; {va entre otros dos o al final}
  nue^.sig := act ;
end;

 
 procedure CrearListaOrdenada(var l: lista);
 var 
   dato: venta;
 begin
   l:= nil;
   leerDatos(dato);
   while (dato.codventa <> CORTE) do begin
      InsertarOrdenado(l,dato);
      leerDatos(dato);
   end;  
 end;

 procedure CrearVectorListas (var v: VectorListas);
 var
   i: integer;
 begin
   for i:=1 to DIMFIS do begin
      Writeln('Cargando Lista ', i, ' ->');
      CrearListaOrdenada(v[i]);
   end;
 
 end;

//MODULOS PARA IMPRIMIR EL VECTOR DE LISTAS

procedure mostrarDatos(dato: venta);
begin
  Writeln('Cod prod: ', dato.codproducto, ' Cant Vendida: ', dato.cantvendida, ' Cod Venta: ', dato.codventa);
end; 

 procedure ImprimirLista(l: lista); 
 begin
  while (l <> nil) do begin 
	mostrarDatos(l^.dato);
	l:= l^.sig;
  end;
 end;

 procedure ImprimirVectorListas ( v: VectorListas);
 var
   i: integer;
 begin
   for i:=1 to DIMFIS do begin
      Writeln(' Lista ', i, ' ->');
      ImprimirLista(v[i]);
   end;
 
 end;
 
 //MODULOS PARA MERGE

procedure AgregarAlFinal(var pri, ult: ListaAcumuladora; dato: ProductoAcumulado); 
var  nue : ListaAcumuladora;
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

procedure determinar_minimo( var v: VectorListas; 
                             var min: venta);
var
  i, posMin: integer;
begin
  min.codproducto:= VALOR_MUY_ALTO;
  for i:= 1 to DIMFIS do begin
    if(v[i] <> nil) and (v[i]^.dato.codproducto < min.codproducto)then begin
      min:= v[i]^.dato;
      posMin := i;
    end;
  end;
  if(min.codproducto <> VALOR_MUY_ALTO)then 
    v[posMin] := v[posMin]^.sig;
end;

Procedure MergeAcumulador( v: VectorListas; var lnueva: ListaAcumuladora);
var
  min: venta;
  ult: ListaAcumuladora;
  actual: ProductoAcumulado;
begin
  lnueva:= nil; ult:= nil;
  determinar_minimo(v, min);
  while (min.codproducto <> VALOR_MUY_ALTO ) do begin
      actual.codproducto:= min.codproducto;
      actual.totalvendido:=0;
      while (actual.codproducto = min.codproducto) do begin
           actual.totalvendido:= actual.totalvendido + min.cantvendida;
           determinar_minimo(v, min);
      end;
  
      agregarAlFinal(lnueva, ult, actual);  
    
  end;
end;

// MODULOS PARA IMPRIMIR LISTA ACUMULADORA

procedure mostrarDatosAcumulados(dato: ProductoAcumulado);
begin
  Writeln('Cod prod: ', dato.codproducto, ' Total Vendido: ', dato.totalvendido);
end; 

 procedure ImprimirListaAcumuladora(l: ListaAcumuladora); 
 begin
  while (l <> nil) do begin 
	mostrarDatosAcumulados(l^.dato);
	l:= l^.sig;
  end;
 end;

var 
 v: VectorListas;
 lnueva: ListaAcumuladora;
begin
 Randomize;
 CrearVectorListas (v);
 Writeln;
 Writeln('Vector de Listas');
 ImprimirVectorListas (v);
 MergeAcumulador(v,lnueva);

 Writeln;
 Writeln('Lista nueva');
 ImprimirListaAcumuladora(lnueva);
 readln;
 readln;
end.

