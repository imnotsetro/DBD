
1. 
    SELECT T.descripcionTipo, O.fechaCrea, O.nombre, O.calle, O.nro, L.nombreL
    FROM Obra O 
    INNER JOIN TipoObra T ON TO.idTipo = O.idTipo
    INNER JOIN Localidad L ON L.codigoPostal = O.codigoPostal
    WHERE O.nroObra IN (
        SELECT AO1.nroObra
        FROM Artista_Obra AO1 
        INNER JOIN Artista A1 ON A1.idArtista = AO1.idArtista
        WHERE A1.DNI = '2222222';
    ) AND O.nroObra IN (
        SELECT AO2.nroObra
        FROM Artista_Obra AO2 
        INNER JOIN Artista A2 ON A2.idArtista = AO2.idArtista
        WHERE A1.pasaporte = 'AR123456';
    )

2. 
    SELECT A.DNI, A.pasaporte, A.nombre, A.apellido, A.fnac, A.telefono, L.nombreL
    FROM Artista A
    INNER JOIN Localidad L ON L.codigoPostal = A.codigoPostalVive
    INNER JOIN Artista_Obra AO ON AO.idArtista = A.idArtista
    WHERE AO.fechaI BETWEEN (01-01-2022 AND 31-12-2022)
    GROUP BY A.DNI, A.pasaporte, A.nombre, A.apellido, A.fnac, A.telefono, L.nombreL
    HAVING COUNT(AO.*) > 2
    ORDER BY A.apellido, A.nombre;

3. 
    SELECT T.descripcionTipo, O.fechaCrea, O.nombre, O.calle, O.nro, L.nombreL
    FROM Obra O 
    INNER JOIN TipoObra T ON TO.idTipo = O.idTipo
    INNER JOIN Localidad L ON L.codigoPostal = O.codigoPostal
    WHERE O.nroObra NOT IN (
        SELECT AO.nroObra
        FROM Artista_Obra AO
    );

4.
    SELECT A.DNI, A.pasaporte, A.nombre, A.apellido, A.fnac, A.telefono, L.nombreL
    FROM Artista A
    INNER JOIN Localidad L ON L.codigoPostal = A.codigoPostalVive
    WHERE A.idArtista IN (
        SELECT AO1.idArtista
        FROM Artista_Obra AO1
        INNER JOIN Obra O1 ON O1.nroObra = AO1.nroObra
        WHERE O1.fechaCrea < '01-01-1890'
    ) AND A.idArtista NOT IN (
        SELECT AO2.idArtista
        FROM Artista_Obra AO2
        INNER JOIN Obra O2 ON O2.nroObra = AO2.nroObra
        WHERE O2.fechaCrea >= '01-01-1890'
    );

5. 
    SELECT T.descripcionTipo, O.fechaCrea, O.nombre
    FROM Obra O
    WHERE NOT EXISTS (
        SELECT *
        FROM Artista A
        WHERE NOT EXISTS (
            SELECT *
            FROM Artista_Obra AO
            WHERE A.idArtisa = Ao.idArtista AND O.nroObra = AO.nroObra
        )
    );