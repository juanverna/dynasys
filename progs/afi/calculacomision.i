        FOR EACH Cupon OF Rendicion_hd NO-LOCK:
        

            RUN comision_cupon.p (  INPUT Cupon.cdg_cobrador,
                                    INPUT Cupon.cdg_empresa,
                                    INPUT Cupon.cdg_zona,
                                    INPUT Cupon.prf_comprob,
                                    INPUT Cupon.importe_cuota,
                                    INPUT Cupon.tipo_grupo,
                                    INPUT Cupon.cdg_plan,
                                    
                                    OUTPUT v-prc_comision,
                                    OUTPUT v-importe_cuota,
                                    OUTPUT v-imp_comision,
                                    OUTPUT v-areaspesos,
                                    OUTPUT v-areascupones,
                                    OUTPUT v-arecobpesos,
                                    OUTPUT v-area5pesos,
                                    OUTPUT v-area5cupones,
                                    OUTPUT v-ar5cobpesos,
                                    OUTPUT v-planespesos,
                                    OUTPUT v-planescupones,
                                    OUTPUT v-placobpesos,
                                    OUTPUT v-grupospesos,
                                    OUTPUT v-gruposcupones,
                                    OUTPUT v-grucobpesos
                                  ).

           v-importe_cuota = Cupon.importe_cuota / 1.105.

           ASSIGN
                 t-cargopesos    = t-cargopesos    + v-importe_cuota.
                 t-cargocupones  = t-cargocupones  + 1.
                 
                 t-areaspesos    = t-areaspesos    + v-areaspesos.
                 t-areascupones  = t-areascupones  + v-areascupones.
                 t-arecobpesos   = t-arecobpesos   + v-arecobpesos.
                 t-area5pesos    = t-area5pesos    + v-area5pesos.
                 t-area5cupones  = t-area5cupones  + v-area5cupones.
                 t-ar5cobpesos   = t-ar5cobpesos   + v-ar5cobpesos.
                 t-planespesos   = t-planespesos   + v-planespesos.
                 t-planescupones = t-planescupones + v-planescupones.
                 t-placobpesos   = t-placobpesos   + v-placobpesos.
                 t-grupospesos   = t-grupospesos   + v-grupospesos.
                 t-gruposcupones = t-gruposcupones + v-gruposcupones.
                 t-grucobpesos   = t-grucobpesos   + v-grucobpesos.
    
        END. /* De recorrer los cupones de una rendicion */
