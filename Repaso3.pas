program ejerf;

const
	DimF=250; 
type
	categorias = 1..20;
	
	empleado = record
		legajo: integer;
		DNI: integer;
		anio: 1900..2021;
		cat: categorias;
	end;
	
	arbol = ^nodo;
	nodo = record
           dato: empleado;
           HI: arbol;
           HD: arbol;
         end;
	
	Empleado2 = record
		legajo: integer;
		DNI: integer;
	end;
	
	vector = array [1..dimF] of Empleado2;
	

	
Procedure Insertar(var a:arbol; e:empleado);
begin
  if(a=nil) then begin
     new(a);
     a^.dato:=e;
     a^.HI:=nil;
     a^.HD:=nil;
  end
  else begin
     if(a^.dato.legajo>e.legajo) then
        insertar(a^.HI,e)
     else
        insertar(a^.HD,e);
  end;
end;

procedure LeerEmpleado(var e:empleado);
begin
     with e do begin
          writeln('INGRESE LEGAJO: ');
          read(legajo);
          if (legajo<>-1) then begin
             writeln('INGRESE AÑO DE FABRICACION (ENTRE 1999 Y 2021): ');
             read(anio);
             writeln('INGRESE CATEGORIA(ENTRE 1 Y 20): ');
             read(cat);
             writeln('INGRESE DNI: ');
             read(dni);
             end;
     end;
end;

procedure crearArbol(var a:arbol);
var e:empleado;
begin
     LeerEmpleado(e);
     while (e.legajo<> -1) do begin
           Insertar(a,e);
           LeerEmpleado(e);
           end;
end;

procedure imprimirEmpleado(a: arbol);
	begin
		writeln('Nro Legajo: ',a^.dato.legajo);
		writeln('DNI: ',a^.dato.dni);
		writeln('Anio Ingreso: ',a^.dato.anio);
		writeln('Categoria: ',a^.dato.cat);
		writeln(' ');
	end;


procedure imprimirEnOrden(a: arbol);

begin
   if (a <> nil) then begin
    imprimirEnOrden(a^.HI);
	imprimirEmpleado(a);
    imprimirEnOrden(a^.HD);
   end
end;

procedure agregoVector(var v: vector; dni, Legajo: integer; var dimL: integer);
	begin
		if (dimL <= DimF) then begin
		 	DimL := dimL +1;
			v[dimL].legajo := Legajo;
			v[dimL].dni := dni;
		end;
	end;

procedure recorridoAcotado (a: arbol; inf, sup: integer;var v:vector; Var dl,nroCategoria:integer);
begin
  if (a <> nil) then begin
    if (a^.dato.legajo >= inf) then begin
      if (a^.dato.legajo <= sup) then begin
		if (a^.dato.cat = nroCategoria) then 
			agregoVector(v, a^.dato.dni, a^.dato.legajo, dl);
	
        recorridoAcotado(a^.hi, inf, sup,v,dl,nroCategoria);
        recorridoAcotado(a^.hd, inf, sup,v,dl,nroCategoria);
      end
      else begin
        recorridoAcotado(a^.hi, inf, sup,v,dl,nroCategoria);
      end;
    end
    else begin
      recorridoAcotado(a^.hd, inf, sup,v,dl,nroCategoria);
    end;
  end;
end;

var
   a:arbol;
   inf,sup,dl,nroCategoria:integer;
   v:vector;
begin
     a:=nil;
     crearArbol(a); //SE DISPONE
     imprimirEnOrden(a);
     dl:=0;
     writeln('ingrese legajo inferior');
     read(inf);
     writeln('ingrese legajo superior');
     read(sup);
     write('Ingrese numero de categoria entre 1 y 20: '); 
     readln(nroCategoria);
     recorridoAcotado(a,inf,sup,v,dl,nroCategoria);
end.

