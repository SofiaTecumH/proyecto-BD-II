CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `vistaclientescuentas` AS
    SELECT 
        `c`.`id_clientes` AS `id_clientes`,
        `ca`.`id_cuenta_aporte` AS `cuenta_aportes`,
        (SELECT 
                COALESCE(SUM(`manejo_aportes`.`monto`), 0)
            FROM
                `manejo_aportes`
            WHERE
                (`manejo_aportes`.`id_cuenta_aporte` = `ca`.`id_cuenta_aporte`)) AS `monto_aportes`,
        `sa`.`id_cuenta_ahorro` AS `cuenta_ahorro`,
        `sa`.`monto` AS `monto_ahorro`,
        `cm`.`id_cuenta_monetaria` AS `cuenta_monetaria`,
        `cm`.`saldo` AS `monto_monetaria`
    FROM
        (((`clientes` `c`
        LEFT JOIN `cuentas_aportes` `ca` ON ((`c`.`id_clientes` = `ca`.`id_clientes`)))
        LEFT JOIN `cuentas_ahorro` `sa` ON ((`c`.`id_clientes` = `sa`.`id_clientes`)))
        LEFT JOIN `cuentas_monetarias` `cm` ON ((`c`.`id_clientes` = `cm`.`id_cliente`)))