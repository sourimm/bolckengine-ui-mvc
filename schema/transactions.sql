

/****** Object:  Table [dbo].[transactions]    Script Date: 12/25/2020 1:02:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[transactions](
	[id] [uniqueidentifier] NOT NULL,
	[type] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[amount] [money] NULL,
	[currency] [nvarchar](50) NULL,
	[native_amount] [money] NULL,
	[native_currency] [nvarchar](50) NULL,
	[description] [nvarchar](500) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[resource] [nvarchar](50) NULL,
	[resource_path] [nvarchar](500) NULL,
	[instant_exchange] [bit] NULL,
	[toid] [uniqueidentifier] NULL,
	[toresource] [nvarchar](50) NULL,
	[toresource_path] [nvarchar](500) NULL,
	[tocurrency] [nvarchar](50) NULL,
	[detailstitle] [nvarchar](50) NULL,
	[detailsubtitle] [nvarchar](50) NULL,
	[detailheader] [nvarchar](50) NULL,
	[detailhealth] [nvarchar](50) NULL,
	[vault_withdrawal_details_url] [nvarchar](250) NULL
) ON [PRIMARY]
GO


