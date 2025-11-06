/****** Object:  StoredProcedure [dbo].[usp_test]    Script Date: 11/6/2025 3:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_test]
AS
--*******************************************************************************************
--      Copyright Körber Supply Chain U.S., Inc.  All Rights Reserved. 
--      Körber is a trademark of Körber AG, Anckelmannsplatz 1, 20537 Hamburg, Germany.
--      All other trademarks used are the property of their respective owners.
--      For a complete copyright notice, see "K.Motion Advantage Application Database Installation Guide".
--*******************************************************************************************
-- 
--    PURPOSE:
--        This stored procedure selects the top two items from t_item_master table.
--
--    DESCRIPTION:
--        Returns the first two records from t_item_master ordered by item_master_id.
--
--    OUTPUT:
--        Returns result set with top 2 items
--      
--  TARGET: 
--        SQL Server
--
--*******************************************************************************************

SET NOCOUNT ON;

BEGIN TRY
    SELECT TOP 2
        item_master_id
    ,   item_number
    ,   description
    ,   uom
    ,   wh_id
    ,   inventory_type
    ,   price
    ,   reorder_point
    ,   reorder_qty
    FROM t_item_master WITH (NOLOCK)
    ORDER BY item_master_id

END TRY
/******************************************************************************************
        Error Handling
******************************************************************************************/
BEGIN CATCH
    DECLARE @catch_error_msg        NVARCHAR(MAX);

    IF @@TRANCOUNT > 0 BEGIN
        ROLLBACK TRAN;
    END;

    SET @catch_error_msg = CONCAT(N'(Error Number: ', ERROR_NUMBER(), N', Procedure: ', OBJECT_NAME(@@PROCID), N', Line Number: ', ERROR_LINE(), N', Error Message: ', ERROR_MESSAGE(), N')');

    IF ERROR_NUMBER() = 1205 BEGIN --T-SQL deadlock
        PRINT @catch_error_msg;
        THROW;
    END;
    ELSE BEGIN
        SET @catch_error_msg = REPLACE(REPLACE(@catch_error_msg, N'%%', N'%'), N'%', N'%%');
        THROW 50000, @catch_error_msg, 1;
    END;
END CATCH
GO
GRANT EXECUTE ON [dbo].[usp_test] TO [AAD_USER] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[usp_test] TO [WA_USER] AS [dbo]
GO

