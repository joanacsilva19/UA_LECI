USE p7g1;
GO

CREATE OR ALTER VIEW PROJETO_GESTAO_EVENTOS.vw_PrecosAtividades AS
SELECT 
    A.ID_atividade,
    CASE 
        -- Fotografia: preco_sessao * n_sessoes
        WHEN F.ID_atividade_fotografia IS NOT NULL THEN (F.preco_sessao * F.n_sessoes)
        
        -- Musica (Banda ou DJ): valor direto
        WHEN B.ID_atividade_banda IS NOT NULL THEN B.preco_banda
        WHEN D.ID_atividade_DJ IS NOT NULL THEN D.preco_DJ
        
        -- Animacao: preco_tema * n_horas * n_animadores
        WHEN AN.ID_atividade_animacao IS NOT NULL THEN 
            (T.preco_tema * AN.n_horas_animacao * AN.n_animadores)
            
        -- Catering: preço do menu associado
        WHEN C.ID_atividade_catering IS NOT NULL THEN M.preco_menu
        
        ELSE 0 
    END AS PrecoFinal
FROM PROJETO_GESTAO_EVENTOS.Atividade A
LEFT JOIN PROJETO_GESTAO_EVENTOS.Fotografia F ON A.ID_atividade = F.ID_atividade_fotografia
LEFT JOIN PROJETO_GESTAO_EVENTOS.Banda B ON A.ID_atividade = B.ID_atividade_banda
LEFT JOIN PROJETO_GESTAO_EVENTOS.DJ D ON A.ID_atividade = D.ID_atividade_DJ
LEFT JOIN PROJETO_GESTAO_EVENTOS.Animacao AN ON A.ID_atividade = AN.ID_atividade_animacao
LEFT JOIN PROJETO_GESTAO_EVENTOS.Tema T ON AN.ID_tipo_tema_animacao = T.ID_tipo_tema
LEFT JOIN PROJETO_GESTAO_EVENTOS.Catering C ON A.ID_atividade = C.ID_atividade_catering
LEFT JOIN PROJETO_GESTAO_EVENTOS.Menu M ON C.n_menu_catering = M.n_menu;
GO