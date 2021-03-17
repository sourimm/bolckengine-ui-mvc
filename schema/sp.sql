CREATE PROCEDURE usp_storeTransaction
	@inputJson nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	Declare @json nvarchar(max)
	SELECT @json =[value] FROM OpenJson(@inputJson) where [key] = 'data';

	Insert into transactions
	select * from openJson(@json) with (
		[id] [uniqueidentifier] ,
	[type] [nvarchar](50) ,
	[status] [nvarchar](50) ,
	[amount] [money] '$.amount.amount',
	[currency] [nvarchar](50) '$.amount.currency',
	[native_amount] [money] '$.native_amount.amount',
	[native_currency] [nvarchar](50) '$.native_amount.currency',
	[description] [nvarchar](500) ,
	[created_at] [datetime] ,
	[updated_at] [datetime] ,
	[resource] [nvarchar](50) ,
	[resource_path] [nvarchar](500) ,
	[instant_exchange] [bit] ,
	[toid] [uniqueidentifier] '$.to.id',
	[toresource] [nvarchar](50) '$.to.resource',
	[toresource_path] [nvarchar](500) '$.to.resource_path',
	[tocurrency] [nvarchar](50) '$.to.currency',
	[detailstitle] [nvarchar](50) '$.details.title',
	[detailsubtitle] [nvarchar](50) '$.details.subtitle',
	[detailheader] [nvarchar](50) '$.details.header',
	[detailhealth] [nvarchar](50) '$.details.health',
	[vault_withdrawal_details_url] [nvarchar](250) '$.vault_withdrawal.details_url'
	)


END
GO
