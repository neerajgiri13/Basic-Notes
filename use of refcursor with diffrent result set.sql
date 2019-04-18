CREATE FUNCTION load_page(_session INT) RETURNS setof refcursor AS
$$
DECLARE c_top_items refcursor;
DECLARE c_shopping_cart refcursor;
BEGIN
    OPEN c_top_items FOR
        SELECT t.name, t.description
        FROM top_item t
        ORDER BY t.popularity DESC
        LIMIT 10;
    RETURN NEXT c_top_items;
    OPEN c_shopping_cart FOR
        SELECT c.product_id, c.product_name, c.quantity
        FROM shopping_cart c
        WHERE c.session_id = _session
        ORDER BY c.id;
    RETURN NEXT c_shopping_cart;
END;
$$ LANGUAGE plpgsql;


CALLING:- 

BEGIN;
SELECT load_page(mySession);
FETCH ALL IN "<server cursor 1>";
FETCH ALL IN "<server cursor 2>";
COMMIT;

**********************************************


-- DROP FUNCTION mt_portal.Get_Amc_Pdfdetails(refcursor,refcursor)

CREATE FUNCTION mt_portal.Get_Amc_Pdfdetails(refcursor_1 refcursor,refcursor_2 refcursor)
RETURNS SETOF refcursor AS
$$
-- DECLARE refcursor_1 refcursor;
-- DECLARE refcursor_2 refcursor;
BEGIN
    OPEN refcursor_1 FOR
        SELECT a.* FROM mt_portal.mt_pdfforms a
       WHERE a.amc_code = '128';
    RETURN NEXT refcursor_1;
    
    OPEN refcursor_2 FOR
       SELECT * FROM mt_portal.mt_pdfforms mt
            JOIN mt_portal.mt_pdfformdetails mtpdf
            ON mt.amc_id = mtpdf.amc_id
            WHERE amc_code = '128';
    RETURN NEXT refcursor_2;
END;
$$ LANGUAGE plpgsql;
/*
BEGIN;

SELECT * FROM  mt_portal.Get_Amc_Pdfdetails('refcursor_1','refcursor_2');
 FETCH ALL IN "refcursor_1";
 FETCH ALL IN "refcursor_2";

END;

*/

