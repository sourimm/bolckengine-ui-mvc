

CREATE TABLE [dbo].[accounts](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[account_id] [bigint] NOT NULL,
	[first_name] [varchar](140) NULL,
	[last_edited_timestamp] [datetime2](7) NULL,
	[last_name] [varchar](140) NULL,
	[name] [varchar](140) NOT NULL,
	[timestamp] [datetime2](7) NOT NULL,
	[username] [varchar](250) NULL,
	[password] [varchar](250) NULL,
	[token] [varchar](max) NULL,
	[email] [varchar](max) NULL,
	[custodian] [varchar](140) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[balances](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[account_id] [bigint] NOT NULL,
	[custodian] [varchar](140) NULL,
	[first_name] [varchar](140) NULL,
	[last_edited_timestamp] [datetime2](7) NULL,
	[last_name] [varchar](140) NULL,
	[name] [varchar](140) NOT NULL,
	[timestamp] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[models](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[description] [varchar](300) NULL,
	[display_name] [varchar](140) NULL,
	[last_edited_timestamp] [datetime2](7) NULL,
	[linked_account_name] [varchar](300) NULL,
	[model_id] [int] NOT NULL,
	[model_type_name] [varchar](140) NULL,
	[name] [varchar](140) NOT NULL,
	[status] [varchar](255) NOT NULL,
	[timestamp] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[model_targets](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[last_edited_timestamp] [datetime2](7) NULL,
	[model_target_id] [int] NOT NULL,
	[percentage] [float] NOT NULL,
	[security_name] [varchar](60) NOT NULL,
	[timestamp] [datetime2](7) NOT NULL,
	[model_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[performance](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[account] [varchar](140) NOT NULL,
	[day_rate_of_return] [float] NULL,
	[last_edited_timestamp] [datetime2](7) NULL,
	[performance_id] [bigint] NOT NULL,
	[security_name] [varchar](140) NULL,
	[timestamp] [datetime2](7) NOT NULL,
	[rate_of_return] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[taxlots](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[amount] [bigint] NOT NULL,
	[entity_name] [varchar](300) NOT NULL,
	[last_edited_timestamp] [datetime2](7) NULL,
	[purchase_date] [datetime2](7) NOT NULL,
	[quantity] [bigint] NOT NULL,
	[tax_lot_id] [bigint] NOT NULL,
	[taxlot] [varchar](200) NULL,
	[timestamp] [datetime2](7) NULL,
	[account_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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


