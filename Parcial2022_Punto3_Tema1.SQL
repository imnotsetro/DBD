// SOCIO = (nro_socio, DNI, Apellido, Nombre, Fecha_Nacimiento, Fecha_Ingreso)
// LIBRO = (ISBN, Titulo, Cod_Genero, Descripcion)
// COPIA = (ISBN(PK), Nro_Ejemplar, Estado)
// EDITORIAL = (Cod_Editorial, Denominacion, Telefono, Calle, Numero, Piso, Dpto)
// LIBRO-EDITORIAL = (ISBN(FK), Cod_Editorial(PK), Año_Edicion)
// GENERO = (Cod_Genero, Nombre_genero)
// PRESTAMO (Nro_Prestamo, nro_Socio(FK), ISBN(FK), Nro_Ejemplar(FK), Fecha_Prestamo, Fecha_Devolucion) //ISBN Y Nro_Ejemplar SON FORANEAS DE COPIA

1. 
    SELECT L.Titulo, G.Nombre_genero, L.Descripcion
    FROM LIBRO L 
    INNER JOIN GENERO G ON L.Cod_Genero = LE.Cod_Genero 
    INNER JOIN LIBRO-EDITORIAL LE ON LE.ISBN = L.ISBN
    WHERE LE.Cod_Editorial IN (
        SELECT E.Cod_Editorial
        FROM EDITORIAL E 
        WHERE E.Denominacion = 'Nueva Editorial'
    )
    ORDER BY L.Titulo;

2. 
    SELECT Apellido, Nombre
    FROM SOCIO
    WHERE Fecha_Ingreso BETWEEN 01-09-2022 AND 30-09-2022
    ORDER BY Apellido, Nombre;

3. 
    SELECT S.Nombre, S.Apellido, S.Fecha_Nacimiento, COUNT(P.Nro_Prestamo) AS Cant_Prestamos
    FROM SOCIO S 
    INNER JOIN PRESTAMO P ON P.nro_Socio = S.nro_Socio
    GROUP BY S.nro_Socio, S.Nombre, S.Apellido, S.Fecha_Nacimiento
    HAVING COUNT(P.Nro_Prestamo) > 5
    ORDER BY S.Apellido;

4. 
    SELECT S.DNI, S.Apellido, S.Nombre
    FROM SOCIO S 
    WHERE S.nro_Socio NOT IN (
        SELECT P1.nro_Socio
        FROM PRESTAMO P
        INNER JOIN LIBRO L ON P.ISBN = L.ISBN
        INNER JOIN LIBRO-EDITORIAL LE ON LE.ISBN = L.ISBN
        INNER JOIN EDITORIAL E ON E.Cod_Editorial = LE.Cod_Editorial
        WHERE E.Denominacion = 'Gran Editorial'
    )
    ORDER BY S.Apellido, S.Nombre

5. 
    SELECT COUNT(P.nroSocio) AS Cant_Socios_Prestamos_Buenos
    FROM PRESTAMO P
    WHERE P.ISBN IN (
        SELECT C.ISBN
        FROM COPIA C
        WHERE C.Estado = 'Bueno'
    )
    GROUP BY P.nro_Socio
    
