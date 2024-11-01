CREATE DATABASE [ParkPoint]
CREATE TABLE [dbo].[Auto](
	[id_auto] [int] IDENTITY(1,1) NOT NULL,
	[patente] [varchar](50) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_marca] [int] NOT NULL,
	[id_modelo] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_auto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[patente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Canjeo]    Script Date: 1/11/2024 15:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Canjeo](
	[id_canjeo] [int] IDENTITY(1,1) NOT NULL,
	[fecha_canjeo] [date] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_puntos] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_canjeo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estacionamiento]    Script Date: 1/11/2024 15:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estacionamiento](
	[id_estacionamiento] [int] IDENTITY(1,1) NOT NULL,
	[sePuedeEstacionar] [bit] NOT NULL,
	[ocupado] [bit] NOT NULL,
	[calle] [text] NOT NULL,
	[altura_calle] [text] NOT NULL,
	[fecha_libre] [date] NOT NULL,
	[fecha_ocupado] [date] NOT NULL,
	[tiempo_estacionado] [time](7) NOT NULL,
	[tiempo_promedio_llegada] [time](7) NOT NULL,
	[id_auto] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_ubicacion] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_estacionamiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genero]    Script Date: 1/11/2024 15:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genero](
	[id_genero] [int] IDENTITY(1,1) NOT NULL,
	[nombre_genero] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_genero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Infraccion]    Script Date: 1/11/2024 15:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Infraccion](
	[id_motivo_infraccion] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_motivo_infraccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Marca]    Script Date: 1/11/2024 15:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marca](
	[id_marca] [int] IDENTITY(1,1) NOT NULL,
	[nombre_marca] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_marca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Modelo]    Script Date: 1/11/2024 15:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Modelo](
	[id_modelo] [int] IDENTITY(1,1) NOT NULL,
	[nombre_modelo] [varchar](255) NOT NULL,
	[id_marca] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_modelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notificacion]    Script Date: 1/11/2024 15:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notificacion](
	[id_notificacion] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [text] NOT NULL,
	[descripcion] [text] NOT NULL,
	[fecha_notificacion] [date] NOT NULL,
	[leido] [bit] NOT NULL,
	[id_usuario] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_notificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Puntos]    Script Date: 1/11/2024 15:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Puntos](
	[id_puntos] [int] IDENTITY(1,1) NOT NULL,
	[cantidad] [text] NOT NULL,
	[fecha_actualizacion] [date] NOT NULL,
	[id_usuario] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_puntos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recompensa]    Script Date: 1/11/2024 15:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recompensa](
	[id_recompensa] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [text] NOT NULL,
	[descripcion] [text] NOT NULL,
	[puntos_necesarios] [int] NOT NULL,
	[imagen] [varchar](255) NULL,
	[id_canjeo] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_recompensa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registro]    Script Date: 1/11/2024 15:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registro](
	[id_registro] [int] IDENTITY(1,1) NOT NULL,
	[registro_aprobado] [bit] NOT NULL,
	[id_usuario] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_registro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reporte]    Script Date: 1/11/2024 15:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporte](
	[id_reporte] [int] IDENTITY(1,1) NOT NULL,
	[fecha_reporte] [date] NOT NULL,
	[calle_infraccion] [varchar](255) NULL,
	[altura_infraccion] [varchar](255) NULL,
	[patente_reportada] [varchar](50) NOT NULL,
	[id_motivo_infraccion] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_reporte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ubicacion]    Script Date: 1/11/2024 15:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ubicacion](
	[id_ubicacion] [int] IDENTITY(1,1) NOT NULL,
	[ubicacionX] [float] NOT NULL,
	[ubicacionY] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_ubicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 1/11/2024 15:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[dni] [int] NOT NULL,
	[foto_dni] [varchar](255) NOT NULL,
	[nombre] [varchar](255) NOT NULL,
	[apellido] [varchar](255) NOT NULL,
	[fecha_nacimiento] [date] NOT NULL,
	[email] [varchar](255) NOT NULL,
	[contrasena] [varchar](255) NOT NULL,
	[fecha_registro] [date] NOT NULL,
	[fecha_vencimiento_carnet] [date] NOT NULL,
	[foto_carnet] [varchar](255) NOT NULL,
	[foto_usuario] [varchar](255) NULL,
	[id_genero] [int] NOT NULL,
	[id_ubicacion] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Auto]  WITH CHECK ADD FOREIGN KEY([id_modelo])
REFERENCES [dbo].[Modelo] ([id_modelo])
GO
ALTER TABLE [dbo].[Auto]  WITH CHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Canjeo]  WITH CHECK ADD FOREIGN KEY([id_puntos])
REFERENCES [dbo].[Puntos] ([id_puntos])
GO
ALTER TABLE [dbo].[Canjeo]  WITH CHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Estacionamiento]  WITH CHECK ADD FOREIGN KEY([id_auto])
REFERENCES [dbo].[Auto] ([id_auto])
GO
ALTER TABLE [dbo].[Estacionamiento]  WITH CHECK ADD FOREIGN KEY([id_ubicacion])
REFERENCES [dbo].[Ubicacion] ([id_ubicacion])
GO
ALTER TABLE [dbo].[Estacionamiento]  WITH CHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Modelo]  WITH CHECK ADD FOREIGN KEY([id_marca])
REFERENCES [dbo].[Marca] ([id_marca])
GO
ALTER TABLE [dbo].[Notificacion]  WITH CHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Puntos]  WITH CHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Recompensa]  WITH CHECK ADD FOREIGN KEY([id_canjeo])
REFERENCES [dbo].[Canjeo] ([id_canjeo])
GO
ALTER TABLE [dbo].[Registro]  WITH CHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Reporte]  WITH CHECK ADD FOREIGN KEY([id_motivo_infraccion])
REFERENCES [dbo].[Infraccion] ([id_motivo_infraccion])
GO
ALTER TABLE [dbo].[Reporte]  WITH CHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD FOREIGN KEY([id_genero])
REFERENCES [dbo].[Genero] ([id_genero])
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD FOREIGN KEY([id_ubicacion])
REFERENCES [dbo].[Ubicacion] ([id_ubicacion])
GO
USE [master]
GO
ALTER DATABASE [ParkPoint] SET  READ_WRITE 
GO