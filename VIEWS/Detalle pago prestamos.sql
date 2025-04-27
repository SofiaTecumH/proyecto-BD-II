CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `detallepagosprestamos` AS
    SELECT 
        `p`.`id_prestamo` AS `id_prestamo`,
        `c`.`id_clientes` AS `id_clientes`,
        `p`.`monto` AS `monto_prestamo`,
        `p`.`intereses` AS `intereses`,
        `p`.`saldo_pendiente` AS `saldo_pendiente`,
        `pp`.`monto` AS `monto_pagado`,
        `pp`.`fecha` AS `fecha_pago_realizado`,
        `cp`.`id_cuota` AS `id_cuota`,
        `cp`.`monto_mensual` AS `monto_cuota`,
        `cp`.`fecha_pago` AS `fecha_pago_programado`,
        `cp`.`estado` AS `estado_cuota`,
        (CASE
            WHEN (`p`.`saldo_pendiente` = 0) THEN 'Pagado'
            ELSE 'Pendiente'
        END) AS `estado_prestamo`
    FROM
        (((`prestamos` `p`
        JOIN `pago_prestamo` `pp` ON ((`p`.`id_prestamo` = `pp`.`prestamo_id`)))
        JOIN `cuotas_prestamos` `cp` ON ((`p`.`id_prestamo` = `cp`.`id_prestamo`)))
        JOIN `clientes` `c` ON ((`p`.`id_cliente` = `c`.`id_clientes`)))