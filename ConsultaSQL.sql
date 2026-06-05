   SELECT c.CodigoCliente, CONCAT(ISNULL(sn.PrimerNombre, ''), ' ',  
        ISNULL(sn.SegundoNombre, ''), ' ', ISNULL(sn.PrimerApellido, ''), ' ', 
        ISNULL(sn.SegundoApellido, '')) AS NombreCompleto, DATEDIFF(DAY, MAX(ot.FechaOrden), '2026-06-05') AS Recencia,
        COUNT(DISTINCT ot.NumeroOrden) AS Frecuencia,
        SUM(ISNULL(dmo.Unidades * mo.Precio, 0) + ISNULL(dm.Unidades * dm.PrecioVenta, 0)) AS ValorMonetario
    FROM dbo.Cliente c
    INNER JOIN dbo.SocioNegocio sn ON c.CodigoSocio = sn.CodigoSocio
    INNER JOIN dbo.Cita ci ON c.CodigoCliente = ci.CodigoCliente
    INNER JOIN dbo.OrdeDeTrabajo ot ON ci.NumeroCita = ot.NumeroCita
    LEFT JOIN dbo.DetalleManoDeObra dmo ON ot.NumeroOrden = dmo.NumeroOrden
    LEFT JOIN dbo.ManoObra mo ON dmo.CodigoManoObra = mo.CodigoManoObra
    LEFT JOIN dbo.DetalleMaterial dm ON ot.NumeroOrden = dm.NumeroOrden
    GROUP BY c.CodigoCliente, sn.PrimerNombre, sn.SegundoNombre, sn.PrimerApellido, sn.SegundoApellido;