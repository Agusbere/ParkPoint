
USE [master]
GO
/****** Object:  Database [ParkPoint]    Script Date: 21/10/2024 09:40:51 ******/
CREATE DATABASE [ParkPoint]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ParkPoint', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ParkPoint.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ParkPoint_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ParkPoint_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ParkPoint] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ParkPoint].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ParkPoint] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ParkPoint] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ParkPoint] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ParkPoint] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ParkPoint] SET ARITHABORT OFF 
GO
ALTER DATABASE [ParkPoint] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ParkPoint] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ParkPoint] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ParkPoint] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ParkPoint] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ParkPoint] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ParkPoint] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ParkPoint] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ParkPoint] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ParkPoint] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ParkPoint] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ParkPoint] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ParkPoint] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ParkPoint] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ParkPoint] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ParkPoint] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ParkPoint] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ParkPoint] SET RECOVERY FULL 
GO
ALTER DATABASE [ParkPoint] SET  MULTI_USER 
GO
ALTER DATABASE [ParkPoint] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ParkPoint] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ParkPoint] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ParkPoint] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ParkPoint] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ParkPoint', N'ON'
GO
ALTER DATABASE [ParkPoint] SET QUERY_STORE = OFF
GO
USE [ParkPoint]
GO
/****** Object:  User [alumno]    Script Date: 21/10/2024 09:40:52 ******/
CREATE USER [alumno] FOR LOGIN [alumno] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Auto]    Script Date: 21/10/2024 09:40:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auto](
	[id_auto] [int] IDENTITY(1,1) NOT NULL,
	[patente] [varchar](50) NOT NULL,
	[marca] [varchar](255) NOT NULL,
	[modelo] [varchar](255) NOT NULL,
	[id_usuario] [int] NOT NULL,
 CONSTRAINT [PK_Auto] PRIMARY KEY CLUSTERED 
(
	[id_auto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Canjeo]    Script Date: 21/10/2024 09:40:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Canjeo](
	[id_canjeo] [int] IDENTITY(1,1) NOT NULL,
	[fecha_canjeo] [date] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_puntos] [int] NOT NULL,
 CONSTRAINT [PK__Canjeo__31CCA5589586C5A1] PRIMARY KEY CLUSTERED 
(
	[id_canjeo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estacionamiento]    Script Date: 21/10/2024 09:40:52 ******/
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
	[ubicacion] [geometry] NOT NULL,
	[tiempo_promedio_llegada] [time](7) NOT NULL,
	[id_auto] [int] NOT NULL,
 CONSTRAINT [PK__Estacion__194BC1A718C4462E] PRIMARY KEY CLUSTERED 
(
	[id_estacionamiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notificacion]    Script Date: 21/10/2024 09:40:52 ******/
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
 CONSTRAINT [PK__Notifica__8270F9A5F0965E5F] PRIMARY KEY CLUSTERED 
(
	[id_notificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Puntos]    Script Date: 21/10/2024 09:40:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Puntos](
	[id_puntos] [int] IDENTITY(1,1) NOT NULL,
	[cantidad] [text] NOT NULL,
	[fecha_actualizacion] [date] NOT NULL,
	[id_usuario] [int] NOT NULL,
 CONSTRAINT [PK__Puntos__3486CBF37164DD70] PRIMARY KEY CLUSTERED 
(
	[id_puntos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recompensa]    Script Date: 21/10/2024 09:40:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recompensa](
	[id_recompensa] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [text] NOT NULL,
	[descripcion] [text] NOT NULL,
	[puntos_necesarias] [int] NOT NULL,
	[imagen] [varchar](255) NOT NULL,
	[id_canjeo] [int] NOT NULL,
 CONSTRAINT [PK__Recompen__80FB9ACC964E0912] PRIMARY KEY CLUSTERED 
(
	[id_recompensa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registro]    Script Date: 21/10/2024 09:40:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registro](
	[id_registro] [int] IDENTITY(1,1) NOT NULL,
	[registro_aprobado] [bit] NOT NULL,
	[id_usuario] [int] NOT NULL,
 CONSTRAINT [PK__Registro__48155C1F26732F70] PRIMARY KEY CLUSTERED 
(
	[id_registro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reporte]    Script Date: 21/10/2024 09:40:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporte](
	[id_reporte] [int] IDENTITY(1,1) NOT NULL,
	[enTiempoRealOInfraccion] [bit] NOT NULL,
	[Motivo_tiempo_real] [varchar](255) NOT NULL,
	[Motivo_infraccion] [varchar](255) NOT NULL,
	[calle_infraccion] [varchar](255) NOT NULL,
	[altura_infraccion] [varchar](255) NOT NULL,
	[patente_reportada] [varchar](255) NOT NULL,
	[fecha_reporte] [date] NOT NULL,
	[id_usuario] [int] NOT NULL,
 CONSTRAINT [PK__Reporte__87E4F5CB3DEB92D0] PRIMARY KEY CLUSTERED 
(
	[id_reporte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 21/10/2024 09:40:52 ******/
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
	[email] [varchar](255) NOT NULL,
	[contrasena] [varchar](255) NOT NULL,
	[fecha_registro] [time](7) NOT NULL,
	[foto_usuario] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Auto]  WITH CHECK ADD  CONSTRAINT [FK_Auto_Usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Auto] CHECK CONSTRAINT [FK_Auto_Usuario]
GO
ALTER TABLE [dbo].[Canjeo]  WITH CHECK ADD  CONSTRAINT [FK_Canjeo_Puntos] FOREIGN KEY([id_puntos])
REFERENCES [dbo].[Puntos] ([id_puntos])
GO
ALTER TABLE [dbo].[Canjeo] CHECK CONSTRAINT [FK_Canjeo_Puntos]
GO
ALTER TABLE [dbo].[Canjeo]  WITH CHECK ADD  CONSTRAINT [FK_Canjeo_Usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Canjeo] CHECK CONSTRAINT [FK_Canjeo_Usuario]
GO
ALTER TABLE [dbo].[Estacionamiento]  WITH CHECK ADD  CONSTRAINT [FK_Estacionamiento_Auto] FOREIGN KEY([id_auto])
REFERENCES [dbo].[Auto] ([id_auto])
GO
ALTER TABLE [dbo].[Estacionamiento] CHECK CONSTRAINT [FK_Estacionamiento_Auto]
GO
ALTER TABLE [dbo].[Notificacion]  WITH CHECK ADD  CONSTRAINT [FK_Notificacion_Usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Notificacion] CHECK CONSTRAINT [FK_Notificacion_Usuario]
GO
ALTER TABLE [dbo].[Puntos]  WITH CHECK ADD  CONSTRAINT [FK_Puntos_Usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Puntos] CHECK CONSTRAINT [FK_Puntos_Usuario]
GO
ALTER TABLE [dbo].[Recompensa]  WITH CHECK ADD  CONSTRAINT [FK_Recompensa_Canjeo] FOREIGN KEY([id_canjeo])
REFERENCES [dbo].[Canjeo] ([id_canjeo])
GO
ALTER TABLE [dbo].[Recompensa] CHECK CONSTRAINT [FK_Recompensa_Canjeo]
GO
ALTER TABLE [dbo].[Registro]  WITH CHECK ADD  CONSTRAINT [FK_Registro_Usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Registro] CHECK CONSTRAINT [FK_Registro_Usuario]
GO
ALTER TABLE [dbo].[Reporte]  WITH CHECK ADD  CONSTRAINT [FK_Reporte_Usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Reporte] CHECK CONSTRAINT [FK_Reporte_Usuario]
GO
USE [master]
GO
ALTER DATABASE [ParkPoint] SET  READ_WRITE 
GO