WITH tb_freq_abs AS (

    SELECT descProduto, 
            COUNT(idTransacao) AS Frequencia_Absoluta

    FROM points
    GROUP BY descProduto

),

tb_freq_abs_cum AS (

    SELECT *,
            sum(Frequencia_Absoluta) OVER (ORDER BY descProduto) AS Frequencia_Absoluta_Acumulada,
            1.0 * Frequencia_Absoluta / (SELECT sum(Frequencia_Absoluta) FROM tb_freq_abs) AS Frequencia_Relativa

    FROM tb_freq_abs
)

SELECT *,
        sum(Frequencia_Relativa) OVER (ORDER BY descProduto) AS Frequencia_Relativa_Acumulada
FROM tb_freq_abs_cum