/****** Object:  Table [dbo].[accounts]    Script Date: 12/29/2020 3:51:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

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